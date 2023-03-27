Class {
	#name : #GtMagritteActionUsedProcess,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #'api - factory' }
GtMagritteActionUsedProcess class >> activeProcess [
	^ GtMagritteActionInActiveProcess default
]

{ #category : #'api - factory' }
GtMagritteActionUsedProcess class >> default [
	^ self activeProcess
]

{ #category : #'api - factory' }
GtMagritteActionUsedProcess class >> futureProcess [
	^ GtMagritteActionInFutureProcess new
]

{ #category : #'api - factory' }
GtMagritteActionUsedProcess class >> uiProcess [
	^ GtMagritteActionInUIProcess default
]

{ #category : #execution }
GtMagritteActionUsedProcess >> executeAction: anActionExecutor [
	anActionExecutor executeInActiveProcess
]
