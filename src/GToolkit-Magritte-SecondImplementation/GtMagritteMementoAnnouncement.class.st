Class {
	#name : #GtMagritteMementoAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Announcements'
}

{ #category : #accessing }
GtMagritteMementoAnnouncement >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteMementoAnnouncement >> memento: anObject [

	memento := anObject
]
