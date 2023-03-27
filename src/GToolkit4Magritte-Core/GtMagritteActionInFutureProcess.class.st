Class {
	#name : #GtMagritteActionInFutureProcess,
	#superclass : #GtMagritteActionUsedProcess,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'promise'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #private }
GtMagritteActionInFutureProcess >> cleanPromise [
	promise := nil
]

{ #category : #execution }
GtMagritteActionInFutureProcess >> executeAction: anActionExecutor [
	promise := anActionExecutor executeInFutureProcess.
	promise ifNil: [ ^ self ].
	promise := promise
		then: (MessageSend receiver: self selector: #cleanPromise)
		otherwise: (MessageSend receiver: self selector: #cleanPromise)
]
