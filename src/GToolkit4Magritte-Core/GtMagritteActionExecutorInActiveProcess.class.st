Class {
	#name : #GtMagritteActionExecutorInActiveProcess,
	#superclass : #GtMagritteActionExecutorUsedProcess,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #execution }
GtMagritteActionExecutorInActiveProcess >> executeAction: anActionExecutor [
	anActionExecutor executeInActiveProcess
]
