Class {
	#name : #GtMagritteActionExecutorUsedProcess,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - factory' }
GtMagritteActionExecutorUsedProcess class >> activeProcess [
	^ GtMagritteActionExecutorInActiveProcess default
]

{ #category : #'api - factory' }
GtMagritteActionExecutorUsedProcess class >> default [
	^ self activeProcess
]

{ #category : #'api - factory' }
GtMagritteActionExecutorUsedProcess class >> uiProcess [
	^ GtMagritteActionExecutorInUIProcess default
]

{ #category : #execution }
GtMagritteActionExecutorUsedProcess >> executeAction: anActionExecutor [
	anActionExecutor executeInActiveProcess
]
