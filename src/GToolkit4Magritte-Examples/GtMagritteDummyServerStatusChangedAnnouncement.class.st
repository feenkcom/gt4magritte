Class {
	#name : #GtMagritteDummyServerStatusChangedAnnouncement,
	#superclass : #GtMagritteDummyServerAnnouncement,
	#instVars : [
		'status'
	],
	#category : #'GToolkit4Magritte-Examples-Support - Server'
}

{ #category : #accessing }
GtMagritteDummyServerStatusChangedAnnouncement >> status [
	^ status
]

{ #category : #accessing }
GtMagritteDummyServerStatusChangedAnnouncement >> status: anObject [
	status := anObject
]
