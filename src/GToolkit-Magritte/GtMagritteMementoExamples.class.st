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

	self assert: aMemento memento isNil.

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
	aDescription := aMemento memento magritteDescription at: 1.
	aCollection := self subscribeToMementoAnnouncements: aMemento.
	
	aPromise := aMemento writePromise: 'Werkstraße' using: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstraße'.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteModelValueChangedAnnouncement }.
	self assert: aCollection first value equals: aResult value.
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
GtMagritteMementoExamples >> mementoWithInvalidAddress [

	<gtExample>
	| aMemento anObject aDescription |
	anObject := self invalidAddressObject.
	aDescription := self addressDescription.
	aMemento := GtMagritteMemento
		            forObject: anObject
		            description: aDescription.

	self assert: aMemento memento isNotNil.
	self assert: aMemento memento model equals: anObject.
	self assert: aMemento memento magritteDescription equals: aDescription.

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

	self assert: aMemento memento isNotNil.
	self assert: aMemento memento model equals: anObject.
	self assert: aMemento memento magritteDescription equals: aDescription.

	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress_ReadPromiseResult [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection |
	aMemento := self mementoWithValidAddress.
	aDescription := aMemento memento magritteDescription at: 1.
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
	aDescription := aMemento memento magritteDescription at: 1.

	aCollection := self subscribeToMementoAnnouncements: aMemento.

	aPromise := aMemento writePromise: 'Werkstraße' using: aDescription.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstraße'.

	self waitExtra: aPromise.
	self
		assertAnnouncements: aCollection
		equals: { GtMagritteModelValueChangedAnnouncement }.
	self assert: aCollection first value equals: aResult value.
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
	aPromise asyncThen: [ :theResult | aSemaphore signal ].
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	self
		assert: aTimeout not
		description: [ 'Semaphore must not timeout' ]
]
