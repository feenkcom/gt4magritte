Class {
	#name : #GtMagritteDummyServerPortChangedAnnouncement,
	#superclass : #GtMagritteDummyServerAnnouncement,
	#instVars : [
		'port'
	],
	#category : #'GToolkit4Magritte-Examples-Support - Server'
}

{ #category : #accessing }
GtMagritteDummyServerPortChangedAnnouncement >> port [
	^ port
]

{ #category : #accessing }
GtMagritteDummyServerPortChangedAnnouncement >> port: anObject [
	port := anObject
]
