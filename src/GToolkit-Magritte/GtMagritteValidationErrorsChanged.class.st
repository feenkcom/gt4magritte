Class {
	#name : #GtMagritteValidationErrorsChanged,
	#superclass : #Announcement,
	#instVars : [
		'validationErrors'
	],
	#category : #'GToolkit-Magritte-Support'
}

{ #category : #accessing }
GtMagritteValidationErrorsChanged >> validationErrors [

	^ validationErrors
]

{ #category : #accessing }
GtMagritteValidationErrorsChanged >> validationErrors: anObject [

	validationErrors := anObject
]
