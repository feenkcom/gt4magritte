Class {
	#name : #GtMagritteModelValueChangedAnnouncement,
	#superclass : #GtMagritteMementoAnnouncement,
	#instVars : [
		'value',
		'description'
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
GtMagritteModelValueChangedAnnouncement >> value [

	^ value
]

{ #category : #accessing }
GtMagritteModelValueChangedAnnouncement >> value: anObject [

	value := anObject
]
