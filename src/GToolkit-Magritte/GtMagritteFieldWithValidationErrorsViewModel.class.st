Class {
	#name : #GtMagritteFieldWithValidationErrorsViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'validationErrors',
		'fieldStencil',
		'announcer',
		'description',
		'memento'
	],
	#category : #'GToolkit-Magritte-Support'
}

{ #category : #announcer }
GtMagritteFieldWithValidationErrorsViewModel >> announcer [

	<return: #Announcer>
	^ announcer
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> asElement [

	^ GtMagritteFieldWithValidationErrorsElement new fieldViewModel: self
]

{ #category : #'api - accessing' }
GtMagritteFieldWithValidationErrorsViewModel >> currentValue [

	^ self memento readUsing: self description
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> description [

	^ description
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> fieldStencil [

	^ fieldStencil
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> fieldStencil: aStencil [

	fieldStencil := aStencil asStencil
]

{ #category : #'gt - extensions' }
GtMagritteFieldWithValidationErrorsViewModel >> gtValidationErrorsFor: aView [

	<gtView>
	^ aView list
		  title: 'Validation Errors';
		  priority: 1;
		  items: [ self validationErrors ];
		  actionUpdateButtonTooltip: 'Update validation errors list';
		  itemText: #messageText
]

{ #category : #'api - testing' }
GtMagritteFieldWithValidationErrorsViewModel >> hasIssues [

	^ self validationErrors isNotEmpty
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> initialize [

	super initialize.
	announcer := Announcer new.
	fieldStencil := [ BrFrame new fitContent ] asStencil.
]

{ #category : #'api - accessing' }
GtMagritteFieldWithValidationErrorsViewModel >> issuesText [

	^ String streamContents: [ :aStream | 
		  self validationErrors
			  do: [ :eachError | 
			  	aStream nextPutAll: eachError messageText asString ]
			  separatedBy: [ aStream cr ] ]
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> memento: aMemento [

	memento := aMemento
]

{ #category : #'api - notifying' }
GtMagritteFieldWithValidationErrorsViewModel >> notifyCanceled [

	self validationErrors: #(  ).

	self announce:
		(GtMagritteCanceledAnnouncement new value:
			 self currentValue)
]

{ #category : #'api - notifying' }
GtMagritteFieldWithValidationErrorsViewModel >> notifyValidatedAndAccepted [

	self validationErrors: #(  ).

	self announce:
		(GtMagritteValidatedAndAcceptedAnnouncement new value:
			 self currentValue)
]

{ #category : #'api - notifying' }
GtMagritteFieldWithValidationErrorsViewModel >> notifyValidationError: anError [

	| relevantErrors |
	self assert: (anError isKindOf: MAValidationError).
	
	relevantErrors := Array streamContents: [ :aStream | 
		                  anError gtMagritteErrorsDo: [ :eachError | 
			                  eachError tag = self description ifTrue: [ 
				                  aStream nextPut: eachError ] ] ].
				                  
	self validationErrors: relevantErrors
]

{ #category : #'private - notifying' }
GtMagritteFieldWithValidationErrorsViewModel >> notifyValidationErrorsChanged [

	self announce:
		(GtMagritteValidationErrorsChanged new validationErrors:
			 self validationErrors)
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> validationErrors [

	^ validationErrors ifNil: [ #(  ) ]
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsViewModel >> validationErrors: aCollection [

	self assert: [ aCollection isCollection ].

	validationErrors = aCollection ifTrue: [ ^ self ].

	validationErrors := aCollection.
	
	self notifyValidationErrorsChanged.
]
