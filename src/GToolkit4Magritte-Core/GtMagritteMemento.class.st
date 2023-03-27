Class {
	#name : #GtMagritteMemento,
	#superclass : #MAMemento,
	#instVars : [
		'cache',
		'validators',
		'overallStatus',
		'internalStatus',
		'subscriptions',
		'executionStatus'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #testing }
GtMagritteMemento class >> isAbstract [

	^ false
]

{ #category : #private }
GtMagritteMemento >> basicValidateValue: aValue [
	aValue description validate: aValue currentValue
]

{ #category : #private }
GtMagritteMemento >> cache [

	^ cache
]

{ #category : #actions }
GtMagritteMemento >> commit [
	<return: #TAsyncFuture>
	super commit.	
	self push: self cache.
	^ self reset
]

{ #category : #private }
GtMagritteMemento >> computeOverallStatus [

	| isValid isUnchanged |
	isValid := self cache allSatisfy: [ :e | 
		           e valueOrNil isValidated and: [ e valueOrNil isValid ] ].

	isUnchanged := self cache allSatisfy: [ :e | 
		               e valueOrNil isChanged not ].

	^ GtMagritteOverallStatus new
		  isValid: isValid;
		  isChanged: isUnchanged not;
		  executionStatus: executionStatus valueOrNil
]

{ #category : #private }
GtMagritteMemento >> computeOverallStatus: anInternalStatus [
	self computeOverallStatus
]

{ #category : #private }
GtMagritteMemento >> createValueUsing: aDescription [

	^ GtMagritteBuilderUtility
		  createValueFrom: self model
		  using: aDescription
]

{ #category : #private }
GtMagritteMemento >> debugValidateValue: aValue [
	| aCompiledMethod aProcess aContext aDebugSession |
	aCompiledMethod := self class >> #basicValidateValue:.

	aProcess := [ self basicValidateValue: aValue ] newProcess.
	aContext := aProcess suspendedContext.

	aDebugSession := aProcess
			newDebugSessionNamed: 'Debug value validation'
			startedAt: aContext.
	aDebugSession
		stepIntoUntil: [ :currentContext | currentContext method == aCompiledMethod ].

	Smalltalk tools debugger openOn: aDebugSession withFullView: true
]

{ #category : #actions }
GtMagritteMemento >> executionStatus [
	<return: #AsyncObservableValue of: #GtMagritteExecutionStatus>
	^ executionStatus
]

{ #category : #actions }
GtMagritteMemento >> executionStatus: aGtMagritteExecutionStatus [
	executionStatus valueOrNil = aGtMagritteExecutionStatus ifTrue: [ ^ self ].

	executionStatus value: aGtMagritteExecutionStatus
]

{ #category : #'gt - extensions' }
GtMagritteMemento >> gtActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Actions';
		priority: 13;
		items: [ self magritteActions sorted: [ :a :b | a priority < b priority ] ];
		column: 'Priority'
			text: #priority
			width: 50;
		column: 'Icon'
			icon: [ :anAction | anAction blocIcon ifNotNil: #asElement ifNil: [ BlElement new size: 0 @ 0 ] ];
		column: 'Label' text: #label;
		column: 'Is Toolbar Action'
			text: [ :anAction | 
				anAction isToolbarAction
					ifTrue: [ 'yes' asRopedText ]
					ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ]
]

{ #category : #'gt - extensions' }
GtMagritteMemento >> gtCacheFor: aView [
	<gtView>
	self cache ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Cached Values';
		priority: 10;
		items: [ self cache associations ];
		column: 'Name' text: [ :anAssoc | anAssoc key label ];
		column: 'Value'
			stencil: [ :anAssoc | 
				| aLabel anObservable |
				anObservable := anAssoc value.
				aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.

				aLabel
					withAsyncSinkDo: [ :anElementSink | 
						anElementSink
							sink: AsyncPeekSink new;
							whenUpdate: [ :theLabel :aSink | 
								| aValue |
								aValue := aSink value.

								theLabel text: (aValue ifNotNil: #currentValue ifNil: [ '?' ]) ].
						anObservable observe: anElementSink ].

				aLabel ]
			weight: 2;
		column: 'Original Value'
			stencil: [ :anAssoc | 
				| aLabel anObservable |
				anObservable := anAssoc value.
				aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.
				aLabel
					withAsyncSinkDo: [ :anElementSink | 
						anElementSink
							sink: AsyncPeekSink new;
							whenUpdate: [ :theLabel :aSink | 
								| aValue |
								aValue := aSink value.
								aValue
									ifNil: [ theLabel text: '?' ]
									ifNotNil: [ aValue isChanged
											ifFalse: [ theLabel text: '' ]
											ifTrue: [ theLabel
													text: (aValue originalValue asString asRopedText
															foreground: BrGlamorousColors disabledButtonTextColor) ] ] ].
						anObservable observe: anElementSink ].

				aLabel ]
			weight: 2;
		column: 'Validation'
			stencil: [ :anAssoc | 
				| aLabel anObservable |
				anObservable := anAssoc value.
				aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.

				aLabel
					withAsyncSinkDo: [ :anElementSink | 
						anElementSink
							sink: AsyncPeekSink new;
							whenUpdate: [ :theLabel :aSink | 
								| aValue aText |
								aValue := aSink value.
								aText := aValue
										ifNil: [ '?' ]
										ifNotNil: [ aValue isSuccess
												ifTrue: [ 'ok' asRopedText foreground: BrGlamorousColors successBackgroundColor ]
												ifFalse: [ aValue issuesDescription asRopedText
														foreground: BrGlamorousColors errorBackgroundColor ] ].
								theLabel text: aText ].
						(self validatorUsing: anAssoc key) observe: anElementSink ].

				aLabel ]
			weight: 2;
		column: 'Subscribed'
			text: [ :anAssoc | 
				| isSubscribed |
				isSubscribed := false.
				subscriptions
					ifNotNil: [ :aDictionary | (aDictionary includesKey: anAssoc key) ifTrue: [ isSubscribed := true ] ].
				isSubscribed
					ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors successBackgroundColor ]
					ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ]
			width: 70;
		contextItemLabel: 'Inspect current value'
			action: [ :anElement :anAssoc | 
				anAssoc value valueOrNil
					ifNotNil: [ :aValue | anElement phlow spawnObject: aValue currentValue ] ];
		contextItemLabel: 'Inspect original value'
			action: [ :anElement :anAssoc | 
				anAssoc value valueOrNil
					ifNotNil: [ :aValue | anElement phlow spawnObject: aValue originalValue ] ];
		send: [ :anAssoc | anAssoc value valueOrNil ];
		contextItemLabel: 'Debug current value validation'
			action: [ :anElement :anAssoc | anAssoc value valueOrNil ifNotNil: [ :aValue | self debugValidateValue: aValue ] ];
		contextItemLabel: 'Inspect last validation result'
			action: [ :anElement :anAssoc | 
				anAssoc value valueOrNil
					ifNotNil: [ :aValue | anElement phlow spawnObject: aValue validation ] ];
		send: [ :anAssoc | anAssoc value valueOrNil ];
		actionUpdateButtonTooltip: 'Update the list'
]

{ #category : #'gt - extensions' }
GtMagritteMemento >> gtOverallStatusFor: aView [
	<gtView>
	self cache ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Execution Status';
		priority: 11;
		items: [ { self executionStatus } ];
		column: 'Name'
			stencil: [ :anObservable | 
				| aLabel |
				aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.

				aLabel
					withAsyncSinkDo: [ :anElementSink | 
						anElementSink
							sink: AsyncPeekSink new;
							whenUpdate: [ :theLabel :aSink | 
								| aValue |
								aValue := aSink value.

								theLabel text: (aValue ifNotNil: #label ifNil: [ '?' ]) ].
						anObservable observe: anElementSink ].

				aLabel ];
		column: 'Type'
			stencil: [ :anObservable | 
				| aLabel |
				aLabel := BrLabel new aptitude: BrGlamorousLabelAptitude.

				aLabel
					withAsyncSinkDo: [ :anElementSink | 
						anElementSink
							sink: AsyncPeekSink new;
							whenUpdate: [ :theLabel :aSink | 
								| aValue |
								aValue := aSink value.

								theLabel text: (aValue ifNotNil: #className ifNil: [ '?' ]) ].
						anObservable observe: anElementSink ].

				aLabel ];
		send: #valueOrNil;
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtMagritteMemento >> gtSubscriptionsFor: aView [

	<gtView>
	subscriptions ifNil: [ ^ aView empty ].
	subscriptions ifEmpty: [ ^ aView empty ].

	^ aView tree
		  title: 'Subscriptions';
		  priority: 12;
		  items: [ subscriptions keys ];
		  children: [ :anItem | 
			  (anItem isKindOf: MADescription)
				  ifTrue: [ subscriptions at: anItem ifAbsent: [ #(  ) ] ]
				  ifFalse: [ #(  ) ] ];
		  itemText: [ :anItem | 
			  (anItem isKindOf: MADescription)
				  ifTrue: [ 
					  'Change ' asRopedText
						  foreground: BrGlamorousColors disabledButtonTextColor;
						  append: anItem label asRopedText;
						  append:
							  (' original values on the following announcements:'
								   asRopedText foreground:
									   BrGlamorousColors disabledButtonTextColor) ]
				  ifFalse: [ anItem announcementClass ] ];
		  expandAll
]

{ #category : #initialization }
GtMagritteMemento >> initialize [
	super initialize.

	cache := Dictionary new.
	validators := Dictionary new.
	subscriptions := Dictionary new.
	executionStatus := self newObservable.
	executionStatus value: GtMagritteExecutionStatus inactive.
	internalStatus := self newObservable.
	executionStatus observe: internalStatus.
	overallStatus := (internalStatus observe
			map: (MessageSend 
				receiver: self 
				selector: #computeOverallStatus:))
			asAsyncObservable
]

{ #category : #accessing }
GtMagritteMemento >> magritteActions [
	^ self model magritteActions
]

{ #category : #private }
GtMagritteMemento >> newObservable [
	^ AsyncObservableValue executionConfiguration: 
		GtMagritteBuilderUtility executionConfigutation
]

{ #category : #accessing }
GtMagritteMemento >> overallStatus [

	<return: #AsyncObservableValue of: #GtMagritteOverallStatus>
	^ overallStatus
]

{ #category : #private }
GtMagritteMemento >> pull [

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
GtMagritteMemento >> pullRaw [

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
GtMagritteMemento >> push: aDictionary [

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
GtMagritteMemento >> readObservableValueUsing: aDescription [

	<return: #AsyncObservableValue of: #GtMagritteValue>
	^ self cache at: aDescription
]

{ #category : #actions }
GtMagritteMemento >> readUsing: aDescription [

	| anObservable |
	anObservable := self readObservableValueUsing: aDescription.
	^ anObservable valueOrNil ifNotNil: #currentValue
]

{ #category : #actions }
GtMagritteMemento >> reset [
	<return: #TAsyncFuture>
	super reset.
	self setCache: self pull.

	^ self overallStatus observeNext next
]

{ #category : #private }
GtMagritteMemento >> setCache: aDictionary [

	"Add new descriptions"
	aDictionary keysAndValuesDo: [ :aDescription :aValue | 
		cache
			at: aDescription
			ifPresent: [ :anObservable | anObservable value: aValue ]
			ifAbsentPut: [ 
				| anObservable |
				anObservable := self newObservable value: aValue.
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
				aValidator := (anObservable observe 
					map: (MessageSend 
						receiver: self 
						selector: #validateValue:)) asAsyncObservable.
				aValidator observe: internalStatus.
				aValidator ] ].

	"Remove old validators"
	validators copy keysAndValuesDo: [ :aDescription :anObservable | 
		(aDictionary includesKey: aDescription) ifFalse: [ 
			validators removeKey: aDescription ifAbsent: [ "ignore" ] ] ]
]

{ #category : #private }
GtMagritteMemento >> subscribeToModelUsing: aDescription observable: anObservable [
	| aHandler |
	aDescription
		announcerSubscriptionsDo: [ :anAnnouncementClass :anAnnouncerValuable | 
			anAnnouncerValuable value
				ifNotNil: [ :anAnnouncer | 
					| aSubscriptionBuilder |
					aSubscriptionBuilder := [ anAnnouncer weak ]
							onDNU: #weak
							do: [ :ex | anAnnouncer ].

					aSubscriptionBuilder
						when: anAnnouncementClass
						send: #onAnnouncement:
						to: (aHandler := GtMagritteMementoAnnouncementHandler new
									model: self model;
									memento: self;
									description: aDescription;
									observable: anObservable;
									announcementClass: anAnnouncementClass).

					subscriptions
						at: aDescription
						ifPresent: [ :aCollection | aCollection add: aHandler ]
						ifAbsentPut: [ OrderedCollection with: aHandler ] ] ]
]

{ #category : #private }
GtMagritteMemento >> unsubscribeFromModelUsing: aDescription [

	subscriptions removeKey: aDescription ifAbsent: [ "ignore" ].

	aDescription announcerSubscriptionsDo: [ :eachAssoc | 
		eachAssoc value value ifNotNil: [ :anAnnouncer | 
			anAnnouncer unsubscribe: self ] ]
]

{ #category : #private }
GtMagritteMemento >> validateValue: aValue [
	| aResult |
	[ self basicValidateValue: aValue.

	aResult := GtMagritteValidationSuccess new value: aValue ]
		on: MAValidationError
		do: [ :anError | 
			aResult := GtMagritteValidationFailure new
					value: aValue;
					exception: anError ].

	aValue validation: aResult.

	^ aResult
]

{ #category : #actions }
GtMagritteMemento >> validatorUsing: aDescription [

	<return: #AsyncObservableValue of: #GtMagritteValue>
	^ validators at: aDescription
]

{ #category : #private }
GtMagritteMemento >> validators [

	^ validators
]

{ #category : #actions }
GtMagritteMemento >> write: anObject using: aDescription [
	"must only be called in UI thread"

	<return: #TAsyncFuture>
	| anObservable aNewValue |
	anObservable := self readObservableValueUsing: aDescription.
	aNewValue := anObservable valueOrNil copyWithCurrentValue: anObject.
	anObservable value: aNewValue.

	^ (self validatorUsing: aDescription) observeNext next
]
