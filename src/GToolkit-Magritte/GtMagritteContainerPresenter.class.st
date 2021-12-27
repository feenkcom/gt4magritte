Class {
	#name : #GtMagritteContainerPresenter,
	#superclass : #Object,
	#traits : 'MATDescriptionPresenter',
	#classTraits : 'MATDescriptionPresenter classTrait',
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
