Class {
	#name : #GtMagritteAction,
	#superclass : #GtMagritteBasicAction,
	#instVars : [
		'isWithFutureResponse',
		'usedProcess'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #'private - execution' }
GtMagritteAction >> actionExecutor [
	^ GtMagritteActionExecutor new
		action: self;
		isWithStatusUpdates: true;
		isWithCallbacks: true
]

{ #category : #accessing }
GtMagritteAction >> beInActiveProcess [
	usedProcess := GtMagritteActionUsedProcess activeProcess
]

{ #category : #accessing }
GtMagritteAction >> beInFutureProcess [
	usedProcess := GtMagritteActionUsedProcess futureProcess
]

{ #category : #accessing }
GtMagritteAction >> beInUIProcess [
	usedProcess := GtMagritteActionUsedProcess uiProcess
]

{ #category : #accessing }
GtMagritteAction >> beWithFutureResponse [
	^ isWithFutureResponse := true
]

{ #category : #'gt - extensions' }
GtMagritteAction >> gtSourceCodeFor: aView [
	<gtView>
	
	(self action respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source code';
		priority: 1;
		object: [ self action ];
		view: #gtSourceCodeFor:
]

{ #category : #testing }
GtMagritteAction >> isWithFutureResponse [
	^ isWithFutureResponse ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteAction >> usedProcess [
	^ usedProcess ifNil: [ GtMagritteActionUsedProcess default  ]
]
