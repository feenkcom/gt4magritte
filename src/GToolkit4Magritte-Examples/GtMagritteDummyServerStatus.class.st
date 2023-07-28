Class {
	#name : #GtMagritteDummyServerStatus,
	#superclass : #Object,
	#instVars : [
		'status'
	],
	#category : #'GToolkit4Magritte-Examples-Support - Server'
}

{ #category : #testing }
GtMagritteDummyServerStatus >> ifRunning: runningBlock ifStopped: idleBlock [
	self isRunning ifTrue: [ 
		runningBlock cull: self.
		^ self ].
		
	self isStopped ifTrue: [
		idleBlock cull: self.
		^ self ]
]

{ #category : #testing }
GtMagritteDummyServerStatus >> isRunning [
	^ self status = GtMagritteDummyServer runningStatus
]

{ #category : #testing }
GtMagritteDummyServerStatus >> isStopped [
	^ self status = GtMagritteDummyServer stoppedStatus
]

{ #category : #printing }
GtMagritteDummyServerStatus >> printOn: aStream [
	self status
		ifNil: [ super printOn: aStream.
			^ self ].

	aStream print: self status
]

{ #category : #accessing }
GtMagritteDummyServerStatus >> status [
	^ status
]

{ #category : #accessing }
GtMagritteDummyServerStatus >> status: anObject [
	status := anObject
]
