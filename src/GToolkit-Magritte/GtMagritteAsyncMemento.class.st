Class {
	#name : #GtMagritteAsyncMemento,
	#superclass : #MAMemento,
	#instVars : [
		'cache',
		'validators',
		'overallStatus',
		'internalStatus',
		'subscriptions'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #testing }
GtMagritteAsyncMemento class >> isAbstract [

	^ false
]

{ #category : #private }
GtMagritteAsyncMemento >> cache [

	^ cache
]

{ #category : #actions }
GtMagritteAsyncMemento >> commit [

	super commit.
	self push: self cache.
	self reset
]

{ #category : #private }
GtMagritteAsyncMemento >> computeOverallStatus [

	| isValid isUnchanged |
	isValid := self cache allSatisfy: [ :e | 
		           e valueOrNil isValidated and: [ e valueOrNil isValid ] ].

	isUnchanged := self cache allSatisfy: [ :e | 
		               e valueOrNil isChanged not ].

	^ GtMagritteAsyncOverallStatus new
		  isValid: isValid;
		  isChanged: isUnchanged not
]

{ #category : #private }
GtMagritteAsyncMemento >> createValueUsing: aDescription [

	^ GtMagritteAsyncBuilderUtility
		  createValueFrom: self model
		  using: aDescription
]

{ #category : #'gt - extensions' }
GtMagritteAsyncMemento >> gtCacheFor: aView [

	<gtView>
	self cache ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Cached Values';
		  priority: 10;
		  items: [ self cache associations ];
		  column: 'Name' text: [ :anAssoc | anAssoc key label ];
		  column: 'Value' stencil: [ :anAssoc | 
			  | aLabel anObservable |
			  anObservable := anAssoc value.
			  aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.

			  aLabel withAsyncSinkDo: [ :anElementSink | 
					  anElementSink
						  sink: AsyncPeakSink new;
						  whenUpdate: [ :theLabel :aSink | 
							  | aValue |
							  aValue := aSink value.

							  theLabel text:
									  (aValue ifNotNil: #currentValue ifNil: [ '?' ]) ].
					  anObservable observe: anElementSink ].

			  aLabel ]
		  weight: 2;
		  column: 'Original Value' stencil: [ :anAssoc | 
			  | aLabel anObservable |
			  anObservable := anAssoc value.
			  aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.
			  aLabel withAsyncSinkDo: [ :anElementSink | 
				  anElementSink
					  sink: AsyncPeakSink new;
					  whenUpdate: [ :theLabel :aSink | 
						  | aValue |
						  aValue := aSink value.
						  aValue ifNil: [ theLabel text: '?' ] ifNotNil: [ 
								  aValue isChanged
									  ifFalse: [ theLabel text: '' ]
									  ifTrue: [ 
										  theLabel text:
												  (aValue originalValue asString asRopedText foreground:
														   BrGlamorousColors disabledButtonTextColor) ] ] ].
				  anObservable observe: anElementSink ].

			  aLabel ]
		  weight: 2;
		  column: 'Validation' stencil: [ :anAssoc | 
			  | aLabel anObservable |
			  anObservable := anAssoc value.
			  aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.

			  aLabel withAsyncSinkDo: [ :anElementSink | 
				  anElementSink
					  sink: AsyncPeakSink new;
					  whenUpdate: [ :theLabel :aSink | 
						  | aValue aText |
						  aValue := aSink value.
						  aText := aValue ifNil: [ '?' ] ifNotNil: [ 
								           aValue isSuccess
									           ifTrue: [ 
										           'ok' asRopedText foreground:
												           BrGlamorousColors successBackgroundColor ]
									           ifFalse: [ 
										           aValue issuesDescription asRopedText foreground:
												           BrGlamorousColors errorBackgroundColor ] ].
						  theLabel text: aText ].
				  (self validatorUsing: anAssoc key) observe: anElementSink ].

			  aLabel ]
		  weight: 2;
		  column: 'Subscribed' text: [ :anAssoc | 
			  | isSubscribed |
			  isSubscribed := false.
			  subscriptions ifNotNil: [ :aDictionary | 
				  (aDictionary includesKey: anAssoc key) ifTrue: [ 
					  isSubscribed := true ] ].
			  isSubscribed
				  ifTrue: [ 
					  'yes' asRopedText foreground:
						  BrGlamorousColors successBackgroundColor ]
				  ifFalse: [ 
					  'no' asRopedText foreground:
						  BrGlamorousColors disabledButtonTextColor ] ]
		  width: 70;
		  send: [ :anAssoc | anAssoc value valueOrNil ];
		  actionUpdateButtonTooltip: 'Update the list'
]

{ #category : #initialization }
GtMagritteAsyncMemento >> initialize [

	super initialize.

	cache := Dictionary new.
	validators := Dictionary new.
	subscriptions := Dictionary new.
	internalStatus := AsyncObservableValue new.
	overallStatus := (internalStatus observe map: [ :aValidationResult | 
		                  self computeOverallStatus ]) asAsyncObservable
]

{ #category : #accessing }
GtMagritteAsyncMemento >> overallStatus [

	<return: #AsyncObservableValue of: #GtMagritteAsyncOverallStatus>
	^ overallStatus
]

{ #category : #private }
GtMagritteAsyncMemento >> pull [

	"Utility method to pull the model into a dictionary mapping descriptions to values. nil values are replaced with the default ones of the model."

	<return: #Dictionary of: #GtMagritteValue>
	| aResult |
	aResult := self pullRaw.
	aResult keysAndValuesDo: [ :aKey :aValue | 
		aValue currentValue isNil ifTrue: [ 
			aValue currentValue: aKey default ] ].
	^ aResult
]

{ #category : #private }
GtMagritteAsyncMemento >> pullRaw [

	<return: #Dictionary of: #GtMagritteValue>
	| aResult |
	aResult := Dictionary new.
	self magritteDescription do: [ :eachDescription | 
		aResult
			at: eachDescription
			put: (self createValueUsing: eachDescription) ].
	^ aResult
]

{ #category : #private }
GtMagritteAsyncMemento >> push: aDictionary [

	"Utility method to push a dictionary mapping descriptions to values into the model."

	aDictionary keysAndValuesDo: [ :aDescription :anObservable | 
		(aDescription isVisible and: [ 
			 aDescription isReadOnly not and: [ 
				 anObservable valueOrNil isChanged ] ]) ifTrue: [ 
			self model
				write: anObservable valueOrNil currentValue
				using: aDescription ] ]
]

{ #category : #actions }
GtMagritteAsyncMemento >> readObservableValueUsing: aDescription [

	<return: #AsyncObservableValue of: #GtMagritteValue>
	^ self cache at: aDescription
]

{ #category : #actions }
GtMagritteAsyncMemento >> readUsing: aDescription [

	| anObservable |
	anObservable := self readObservableValueUsing: aDescription.
	^ anObservable valueOrNil ifNotNil: #currentValue
]

{ #category : #actions }
GtMagritteAsyncMemento >> reset [
	super reset.
	self setCache: self pull.
]

{ #category : #private }
GtMagritteAsyncMemento >> setCache: aDictionary [

	"Add new descriptions"

	aDictionary keysAndValuesDo: [ :aDescription :aValue | 
		cache
			at: aDescription
			ifPresent: [ :anObservable | anObservable value: aValue ]
			ifAbsentPut: [ 
				| anObservable |
				anObservable := AsyncObservableValue new value: aValue.
				self subscribeToModelUsing: aDescription observable: anObservable.
				anObservable ] ].

	"Remove old descriptions"
	cache copy keysAndValuesDo: [ :aDescription :anObservable | 
		(aDictionary includesKey: aDescription) ifFalse: [ 
			cache removeKey: aDescription ifAbsent: [ "ignore" ].
			self unsubscribeFromModelUsing: aDescription ] ].

	"Add new validators"
	cache keysAndValuesDo: [ :aDescription :anObservable | 
		validators
			at: aDescription
			ifPresent: [ :theObservable | "ignore" ]
			ifAbsentPut: [ 
				| aValidator |
				aValidator := (anObservable observe map: [ :aValue | 
					               self validateValue: aValue ]) asAsyncObservable.
				aValidator observe: internalStatus.
				aValidator ] ].

	"Remove old validators"
	validators copy keysAndValuesDo: [ :aDescription :anObservable | 
		(aDictionary includesKey: aDescription) ifFalse: [ 
			validators removeKey: aDescription ifAbsent: [ "ignore" ] ] ]
]

{ #category : #private }
GtMagritteAsyncMemento >> subscribeToModelUsing: aDescription observable: anObservable [

	| aHandler |
	aDescription announcerSubscriptionsDo: [ :eachAssoc | 
		eachAssoc value value ifNotNil: [ :anAnnouncer | 
			anAnnouncer weak
				when: eachAssoc key
				send: #onAnnouncement:
				to: (aHandler := GtMagritteAsyncMementoAnnouncementHandler new
						             model: self model;
						             memento: self;
						             description: aDescription;
						             observable: anObservable).

			subscriptions
				at: aDescription
				ifPresent: [ :aCollection | aCollection add: aHandler ]
				ifAbsentPut: [ OrderedCollection with: aHandler ] ] ]
]

{ #category : #private }
GtMagritteAsyncMemento >> unsubscribeFromModelUsing: aDescription [

	subscriptions removeKey: aDescription ifAbsent: [ "ignore" ].

	aDescription announcerSubscriptionsDo: [ :eachAssoc | 
		eachAssoc value value ifNotNil: [ :anAnnouncer | 
			anAnnouncer unsubscribe: self ] ]
]

{ #category : #private }
GtMagritteAsyncMemento >> validateValue: aValue [

	| aResult |
	[ 
	aValue description validate: aValue currentValue.

	aResult := GtMagritteAsyncValidationSuccess new value: aValue ]
		on: MAValidationError
		do: [ :anError | 
			aResult := GtMagritteAsyncValidationFailure new
				           value: aValue;
				           exception: anError ].

	aValue validation: aResult.

	^ aResult
]

{ #category : #actions }
GtMagritteAsyncMemento >> validatorUsing: aDescription [

	<return: #AsyncObservableValue of: #GtMagritteValue>
	^ validators at: aDescription
]

{ #category : #private }
GtMagritteAsyncMemento >> validators [

	^ validators
]

{ #category : #actions }
GtMagritteAsyncMemento >> write: anObject using: aDescription [

	| anObservable aNewValue |
	anObservable := self readObservableValueUsing: aDescription.
	aNewValue := anObservable valueOrNil copyWithCurrentValue: anObject.
	anObservable value: aNewValue
]
