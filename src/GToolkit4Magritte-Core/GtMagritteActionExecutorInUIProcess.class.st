Class {
	#name : #GtMagritteActionExecutorInUIProcess,
	#superclass : #GtMagritteActionExecutorUsedProcess,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #execution }
GtMagritteActionExecutorInUIProcess >> executeAction: anActionExecutor [
	anActionExecutor executeInUIProcess
]
