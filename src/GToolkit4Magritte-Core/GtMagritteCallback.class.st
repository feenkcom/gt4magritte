Class {
	#name : #GtMagritteCallback,
	#superclass : #GtMagritteBasicAction,
	#instVars : [
		'isWithFutureResponse',
		'usedProcess'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #'private - execution' }
GtMagritteCallback >> actionExecutor [
	^ GtMagritteCallbackExecutor new action: self
]

{ #category : #converting }
GtMagritteCallback >> asGtMagritteCallback [
	^ self
]

{ #category : #accessing }
GtMagritteCallback >> beInFutureProcess [
	usedProcess := GtMagritteActionUsedProcess futureProcess
]

{ #category : #accessing }
GtMagritteCallback >> beInUIProcess [
	usedProcess := GtMagritteActionUsedProcess uiProcess
]

{ #category : #accessing }
GtMagritteCallback >> beWithFutureResponse [
	^ isWithFutureResponse := true
]

{ #category : #testing }
GtMagritteCallback >> isWithFutureResponse [
	^ isWithFutureResponse ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteCallback >> usedProcess [
	^ usedProcess ifNil: [ GtMagritteActionUsedProcess activeProcess  ]
]
