Class {
	#name : #GtMagritteMementoExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #'examples - model' }
GtMagritteMementoExamples >> addressDescription [

	<gtExample>
	^ GtMagritteModelExamples new addressDescription
]

{ #category : #'examples - model' }
GtMagritteMementoExamples >> addressObject [

	<gtExample>
	^ GtMagritteModelExamples new addressObject
]

{ #category : #support }
GtMagritteMementoExamples >> assertAnnouncements: aReceivedAnnouncements equals: aCollectionOfClasses [

	self
		assert: aReceivedAnnouncements size
		equals: aCollectionOfClasses size.

	aReceivedAnnouncements
		with: aCollectionOfClasses
		do: [ :eachAnnouncement :aClass | 
			self assert: eachAnnouncement class equals: aClass ]
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> basicMemento [

	<gtExample>
	| aMemento |
	aMemento := GtMagritteMemento new.

	self assert: aMemento mementoPromise isNil.

	^ aMemento
]

{ #category : #'examples - model' }
GtMagritteMementoExamples >> invalidAddressObject [

	<gtExample>
	^ GtMagritteModelExamples new invalidAddressObject
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedInvalidAddress [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithValidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.
	
	aPromise := aMemento writePromise: 'Werkstraße' using: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstraße'.
	self assert: aResult original equals: 'Werkstrasse 18'.
	self assert: aResult isChanged.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValueChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.
	self assert: aCollection first description equals: aDescription.
	self assert: aCollection first memento equals: aMemento.
	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedInvalidAddress_Commit [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithChangedInvalidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento commitPromise.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess not.
	self
		assert: aResult issuesDescription
		equals: 'Street must include street number'.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValidationChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.

	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedInvalidAddress_Reset [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithChangedInvalidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento resetPromise.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValueChangedAnnouncement }.
	self assert: aCollection first result value equals: 'Werkstrasse 18'.
	self assert: aCollection first result original equals: 'Werkstrasse 18'.
	self assert: aCollection first result isChanged not.
	self assert: aCollection first description equals: aDescription.
	self assert: aCollection first memento equals: aMemento.
	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedInvalidAddress_ValidateOneDescription [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithChangedInvalidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento validationPromiseUsing: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess not.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals:
		{ GtMagritteMementoDescriptionValidationChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.
	self assert: aCollection first description equals: aDescription.
	self assert: aCollection first memento equals: aMemento.

	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedInvalidAddress_ValidatePromiseResult [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection aSemaphore aTimeout |
	aMemento := self mementoWithChangedInvalidAddress.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento validationPromise.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess not.
	self assert: aResult exception isNotNil.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValidationChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.

	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedValidAddress [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithValidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento
		            writePromise: 'Werkstraße 1008'
		            using: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstraße 1008'.
	self assert: aResult original equals: 'Werkstrasse 18'.
	self assert: aResult isChanged.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValueChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.
	self assert: aCollection first description equals: aDescription.
	self assert: aCollection first memento equals: aMemento.
	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedValidAddress_Commit [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithChangedValidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento commitPromise.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.

	self waitExtra: aPromise.
	self assertAnnouncements: aCollection equals: { 
			GtMagritteMementoValidationChangedAnnouncement.
			GtMagritteMementoCommittedAnnouncement }.
	self assert: aCollection first result isSuccess.
	self assert: aCollection second result equals: aResult.

	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithInvalidAddress [

	<gtExample>
	| aMemento anObject aDescription |
	anObject := self invalidAddressObject.
	aDescription := self addressDescription.
	aMemento := GtMagritteMemento
		            forObject: anObject
		            description: aDescription.

	self assert: aMemento mementoPromise isNotNil.
	self assert: aMemento object equals: anObject.
	self assert: aMemento description equals: aDescription.

	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithInvalidAddress_ValidationPromiseResult [

	<gtExample>
	| aMemento aPromiseOne aResult aPromiseTwo aCollection |
	aMemento := self mementoWithInvalidAddress.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromiseOne := aMemento validationPromise.
	aPromiseTwo := aMemento validationPromise.

	self assert: aPromiseOne == aPromiseTwo.

	aResult := aPromiseOne wait.

	self assert: aPromiseOne isFulfilled.
	self assert: aResult isSuccess not.

	self waitExtra: aPromiseOne.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValidationChangedAnnouncement }.

	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress [

	<gtExample>
	| aMemento anObject aDescription |
	anObject := self addressObject.
	aDescription := self addressDescription.
	aMemento := GtMagritteMemento
		            forObject: anObject
		            description: aDescription.

	self assert: aMemento mementoPromise isNotNil.
	self assert: aMemento object equals: anObject.
	self assert: aMemento description equals: aDescription.

	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress_ReadPromiseResult [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithValidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento readPromiseUsing: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstrasse 18'.

	self waitExtra: aPromise.
	self assertAnnouncements: aCollection equals: #(  ).

	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress_ValidateOneDescription [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithValidAddress.
	aDescription := aMemento description at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento validationPromiseUsing: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals:
		{ GtMagritteMementoDescriptionValidationChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.
	self assert: aCollection first description equals: aDescription.
	self assert: aCollection first memento equals: aMemento.

	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress_ValidationPromiseResult [

	<gtExample>
	| aMemento aPromise aResult aCollection |
	aMemento := self mementoWithValidAddress.
	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento validationPromise.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValidationChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.

	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress_WritePromiseResult [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection aSemaphore aTimeout |
	aMemento := self mementoWithValidAddress.
	aDescription := aMemento description at: 1.

	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento writePromise: 'Werkstraße' using: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstraße'.
	self assert: aResult original equals: 'Werkstrasse 18'.
	self assert: aResult isChanged.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteMementoValueChangedAnnouncement }.
	self assert: aCollection first result equals: aResult.
	self assert: aCollection first description equals: aDescription.
	self assert: aCollection first memento equals: aMemento.

	^ aResult
]

{ #category : #support }
GtMagritteMementoExamples >> subscribeToMementoAnnouncements: aMemento [

	| aCollection |
	aCollection := OrderedCollection new.
	aMemento
		when: Announcement
		send: #add:
		to: aCollection.
	^ aCollection
]

{ #category : #support }
GtMagritteMementoExamples >> waitExtra: aPromise [

	| aTimeout aSemaphore |
	aSemaphore := Semaphore new.
	aPromise asyncThen: [ :theResult | 
		AsyncFuturePromise new
			future: [ aSemaphore signal ] asAsyncFuture
			configuration: AsyncFutureExecutionConfiguration new lowPriority ].
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	self
		assert: aTimeout not
		description: [ 'Semaphore must not timeout' ]
]
