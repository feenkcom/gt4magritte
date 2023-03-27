Class {
	#name : #GtMagritteActionInActiveProcess,
	#superclass : #GtMagritteActionUsedProcess,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #execution }
GtMagritteActionInActiveProcess >> executeAction: anActionExecutor [
	anActionExecutor executeInActiveProcess
]
