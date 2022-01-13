Class {
	#name : #GtMagritteValidationErrorAnnouncement,
	#superclass : #GtMagritteMementoAnnouncement,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Magritte-Announcements'
}

{ #category : #accessing }
GtMagritteValidationErrorAnnouncement >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteValidationErrorAnnouncement >> exception: anObject [

	exception := anObject
]