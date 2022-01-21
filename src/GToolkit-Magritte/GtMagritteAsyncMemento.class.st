Class {
	#name : #GtMagritteAsyncMemento,
	#superclass : #MAMemento,
	#instVars : [
		'cache',
		'validators',
		'overallStatus',
		'internalStatus'
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

	| aValue |
	aValue := self model readUsing: aDescription.

	^ GtMagritteValue new
		  description: aDescription;
		  currentValue: aValue;
		  originalValue: aValue
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
		  column: 'Value' text: [ :anAssoc | 
			  anAssoc value valueOrNil ifNotNil: #currentValue ifNil: [ '?' ] ]
		  weight: 2;
		  column: 'Value' text: [ :anAssoc | 
			  | aValue anOriginal |
			  aValue := anAssoc value valueOrNil.
			  aValue ifNil: [ '?' ] ifNotNil: [ 
					  aValue isChanged
						  ifFalse: [ '' ]
						  ifTrue: [ 
							  aValue originalValue asString asRopedText foreground:
									  BrGlamorousColors disabledButtonTextColor ] ] ]
		  weight: 2;
		  column: 'Validation' text: [ :anAssoc | 
			  | aValue anOriginal |
			  aValue := anAssoc value valueOrNil.
			  aValue ifNil: [ '?' ] ifNotNil: [ 
					  aValue isValidated
						  ifFalse: [ '?' ]
						  ifTrue: [ 
							  aValue isValid
								  ifTrue: [ 
									  'ok' asRopedText foreground:
											  BrGlamorousColors successBackgroundColor ]
								  ifFalse: [ 
									  aValue issuesDescription asRopedText foreground:
											  BrGlamorousColors errorBackgroundColor ] ] ] ]
		  weight: 2;
		  send: [ :anAssoc | anAssoc value valueOrNil ];
		  actionUpdateButtonTooltip: 'Update the list'
]

{ #category : #initialization }
GtMagritteAsyncMemento >> initialize [

	super initialize.

	cache := Dictionary new.
	validators := Dictionary new.
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

	aDictionary keysAndValuesDo: [ :aKey :aValue | 
		cache
			at: aKey
			ifPresent: [ :anObservable | anObservable value: aValue ]
			ifAbsentPut: [ AsyncObservableValue new value: aValue ] ].

	cache copy keysAndValuesDo: [ :aKey :anObservable | 
		(aDictionary includesKey: aKey) ifFalse: [ 
			cache removeKey: aKey ifAbsent: [ "ignore" ] ] ].

	cache keysAndValuesDo: [ :aKey :anObservable | 
		validators
			at: aKey
			ifPresent: [ :theObservable | "ignore" ]
			ifAbsentPut: [ 
				| aValidator |
				aValidator := (anObservable observe map: [ :aValue | 
					               self validateValue: aValue ]) asAsyncObservable.
				aValidator observe: internalStatus.
				aValidator ] ].

	validators copy keysAndValuesDo: [ :aKey :anObservable | 
		(aDictionary includesKey: aKey) ifFalse: [ 
			validators removeKey: aKey ifAbsent: [ "ignore" ] ] ]
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
