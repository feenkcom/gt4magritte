Class {
	#name : #GtMagritteModelValueChangedAnnouncement,
	#superclass : #GtMagritteMementoAnnouncement,
	#instVars : [
		'description',
		'result'
	],
	#category : #'GToolkit-Magritte-Announcements'
}

{ #category : #accessing }
GtMagritteModelValueChangedAnnouncement >> description [

	^ description
]

{ #category : #accessing }
GtMagritteModelValueChangedAnnouncement >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteModelValueChangedAnnouncement >> result [

	^ result
]

{ #category : #accessing }
GtMagritteModelValueChangedAnnouncement >> result: anObject [

	result := anObject
]
