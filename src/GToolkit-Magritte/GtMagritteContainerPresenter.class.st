Class {
	#name : #GtMagritteContainerPresenter,
	#superclass : #Object,
	#traits : 'MATDescriptionPresenter',
	#classTraits : 'MATDescriptionPresenter classTrait',
	#instVars : [
		'elements'
	],
	#category : #'GToolkit-Magritte-Support'
}

{ #category : #'instace creation' }
GtMagritteContainerPresenter class >> memento: aMemento [

	^ self memento: aMemento description: aMemento magritteDescription
]

{ #category : #'instace creation' }
GtMagritteContainerPresenter class >> memento: aMemento description: aDescription [

	^ self memento: aMemento description: aDescription parent: nil
]

{ #category : #'instace creation' }
GtMagritteContainerPresenter class >> memento: aMemento description: aDescription parent: aComponent [

	^ self new
		  setMemento: aMemento;
		  setDescription: aDescription;
		  setParent: aComponent
]

{ #category : #adding }
GtMagritteContainerPresenter >> addElement: anElement [

	self elements: (self elements copyWith: anElement)
]

{ #category : #actions }
GtMagritteContainerPresenter >> cancel [

	self reset.

	self elements do: [ :eachElement | 
		eachElement dispatchEvent:
			(GtMagritteCancelWish new memento: self memento) ].
]

{ #category : #actions }
GtMagritteContainerPresenter >> commit [

	self memento commit
]

{ #category : #accessing }
GtMagritteContainerPresenter >> elements [

	^ elements ifNil: [ #(  ) ]
]

{ #category : #accessing }
GtMagritteContainerPresenter >> elements: aCollection [

	elements := aCollection
]

{ #category : #actions }
GtMagritteContainerPresenter >> save [

	[ self validate ]
		on: MAValidationError
		do: [ :err | ^ self inform: err greaseString ].

	self elements do: [ :eachElement | 
		eachElement dispatchEvent:
			(GtMagritteAcceptWish new memento: self memento) ].

	self commit
]

{ #category : #actions }
GtMagritteContainerPresenter >> validate [

	self memento validate
]
