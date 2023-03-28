Class {
	#name : #GtMagritteActionInUIProcess,
	#superclass : #GtMagritteActionUsedProcess,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #execution }
GtMagritteActionInUIProcess >> executeAction: anActionExecutor [
	anActionExecutor executeInUIProcess
]
