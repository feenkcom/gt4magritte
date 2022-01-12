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
	| aMemento aPromise aResult aDescription |
	aMemento := self mementoWithValidAddress. 
	aDescription := aMemento memento magritteDescription at: 1.
	
	aPromise := aMemento writePromise: 'Werkstraße' using: aDescription.
	aResult := aPromise wait.
	
	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstraße'.
	
	^ aMemento
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithChangedInvalidAddress_ValidatePromiseResult [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection aSemaphore aTimeout |
	aMemento := self mementoWithChangedInvalidAddress.

	aCollection := OrderedCollection new.
	aMemento
		when: GtMagritteMementoAnnouncement
		send: #add:
		to: aCollection.

	aPromise := aMemento validationPromise.
	aResult := aPromise wait.

	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess not.
	self assert: aResult exception isNotNil.

	aSemaphore := Semaphore new.
	aPromise asyncThen: [ :theResult | aSemaphore signal ].
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	self
		assert: aTimeout not
		description: [ 'Semaphore must not timeout' ].

	self assert: aCollection size equals: 1.
	self
		assert: aCollection first class
		equals: GtMagritteMementoValidationChangedAnnouncement.
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
	| aMemento aPromiseOne aResult aPromiseTwo |
	aMemento := self mementoWithInvalidAddress.

	aPromiseOne := aMemento validationPromise.
	aPromiseTwo := aMemento validationPromise.

	self assert: aPromiseOne == aPromiseTwo.

	aResult := aPromiseOne wait.

	self assert: aPromiseOne isFulfilled.
	self assert: aResult isSuccess not.

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
	| aMemento aPromise aResult aDescription |
	aMemento := self mementoWithValidAddress. 
	aDescription := aMemento memento magritteDescription at: 1.
	
	aPromise := aMemento readPromiseUsing: aDescription.
	aResult := aPromise wait.
	
	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstrasse 18'.
	
	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress_ValidationPromiseResult [

	<gtExample>
	| aMemento aPromise aResult |
	aMemento := self mementoWithValidAddress. 
	
	aPromise := aMemento validationPromise.
	aResult := aPromise wait.
	
	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	
	^ aResult
]

{ #category : #'examples - memento' }
GtMagritteMementoExamples >> mementoWithValidAddress_WritePromiseResult [

	<gtExample>
	| aMemento aPromise aResult aDescription aCollection aSemaphore aTimeout |
	aMemento := self mementoWithValidAddress. 
	aDescription := aMemento memento magritteDescription at: 1.
	
	aCollection := OrderedCollection new.
	aMemento
		when: GtMagritteMementoAnnouncement
		send: #add:
		to: aCollection.
		
	aPromise := aMemento writePromise: 'Werkstraße' using: aDescription.
	aResult := aPromise wait.
	
	self assert: aPromise isFulfilled.
	self assert: aResult isSuccess.
	self assert: aResult value equals: 'Werkstraße'.
	
	aSemaphore := Semaphore new.
	aPromise asyncThen: [ :theResult | aSemaphore signal ].
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	self
		assert: aTimeout not
		description: [ 'Semaphore must not timeout' ].

	self assert: aCollection size equals: 1.
	self
		assert: aCollection first class
		equals: GtMagritteModelValueChangedAnnouncement.
	self assert: aCollection first value equals: aResult value.
	self assert: aCollection first description equals: aDescription.
	self assert: aCollection first memento equals: aMemento.
	
	^ aResult
]
