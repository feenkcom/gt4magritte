Class {
	#name : #GtMagritteMementoDescriptionValidationChangedAnnouncement,
	#superclass : #GtMagritteMementoAnnouncement,
	#instVars : [
		'description',
		'result'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Announcements'
}

{ #category : #accessing }
GtMagritteMementoDescriptionValidationChangedAnnouncement >> description [

	^ description
]

{ #category : #accessing }
GtMagritteMementoDescriptionValidationChangedAnnouncement >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteMementoDescriptionValidationChangedAnnouncement >> issuesText [

	^ String streamContents: [ :aStream | 
		  self result validationErrors
			  do: [ :eachError | 
			  	aStream nextPutAll: eachError messageText asString ]
			  separatedBy: [ aStream cr ] ]
]

{ #category : #accessing }
GtMagritteMementoDescriptionValidationChangedAnnouncement >> result [

	^ result
]

{ #category : #accessing }
GtMagritteMementoDescriptionValidationChangedAnnouncement >> result: anObject [

	result := anObject
]
