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
	^ GtMagritteActionExecutor new
		action: self;
		isWithStatusUpdates: false;
		isWithCallbacks: false
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

{ #category : #'gt - extensions' }
GtMagritteCallback >> gtSourceCodeFor: aView [
	<gtView>
	
	(self action respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source code';
		priority: 1;
		object: [ self action ];
		view: #gtSourceCodeFor:
]

{ #category : #testing }
GtMagritteCallback >> isWithFutureResponse [
	^ isWithFutureResponse ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteCallback >> usedProcess [
	^ usedProcess ifNil: [ GtMagritteActionUsedProcess activeProcess  ]
]
