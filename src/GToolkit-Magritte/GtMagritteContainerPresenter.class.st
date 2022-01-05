Class {
	#name : #GtMagritteContainerPresenter,
	#superclass : #Object,
	#traits : 'MATDescriptionPresenter',
	#classTraits : 'MATDescriptionPresenter classTrait',
	#instVars : [
		'viewModels'
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
GtMagritteContainerPresenter >> addViewModel: anElement [

	self viewModels: (self viewModels copyWith: anElement)
]

{ #category : #actions }
GtMagritteContainerPresenter >> cancel [

	self reset.

	self viewModels do: [ :eachViewModel | 
		eachViewModel notifyCanceled ].
]

{ #category : #actions }
GtMagritteContainerPresenter >> commit [

	self memento commit
]

{ #category : #'gt - extensions' }
GtMagritteContainerPresenter >> gtMementoFor: aView [

	<gtView>
	self memento ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Memento';
		  priority: 1;
		  object: [ self memento ];
		  view: #maGtFormFor:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  tooltip: 'Inspect memento'
		  action: [ :aButton | aButton phlow spawnObject: self memento ]
]

{ #category : #'private - notifying' }
GtMagritteContainerPresenter >> notifyValidationError: anError [

	self viewModels do: [ :eachViewModel | 
		eachViewModel notifyValidationError: anError ]
]

{ #category : #actions }
GtMagritteContainerPresenter >> save [

	[ self validate ]
		on: MAValidationError
		do: [ :anError | 
			self notifyValidationError: anError.
			^ self ].

	self viewModels do: [ :eachViewModel | 
		eachViewModel notifyValidatedAndAccepted ].

	self commit
]

{ #category : #actions }
GtMagritteContainerPresenter >> validate [

	self memento validate
]

{ #category : #accessing }
GtMagritteContainerPresenter >> viewModels [

	^ viewModels ifNil: [ #(  ) ]
]

{ #category : #accessing }
GtMagritteContainerPresenter >> viewModels: aCollection [

	viewModels := aCollection
]
