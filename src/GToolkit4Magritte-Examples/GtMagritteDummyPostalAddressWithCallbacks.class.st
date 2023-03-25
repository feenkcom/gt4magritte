Class {
	#name : #GtMagritteDummyPostalAddressWithCallbacks,
	#superclass : #GtMagritteDummyPostalAddress,
	#instVars : [
		'successAcceptCallbacks',
		'errorAcceptCallbacks',
		'successCancelCallbacks',
		'errorCancelCallbacks'
	],
	#category : #'GToolkit4Magritte-Examples-Support'
}

{ #category : #accessing }
GtMagritteDummyPostalAddressWithCallbacks >> errorAcceptCallbacks [
	^ errorAcceptCallbacks
]

{ #category : #accessing }
GtMagritteDummyPostalAddressWithCallbacks >> errorCancelCallbacks [
	^ errorCancelCallbacks
]

{ #category : #initialization }
GtMagritteDummyPostalAddressWithCallbacks >> initialize [
	super initialize.

	successAcceptCallbacks := OrderedCollection new.
	errorAcceptCallbacks := OrderedCollection new.
	successCancelCallbacks := OrderedCollection new.
	errorCancelCallbacks := OrderedCollection new
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithCallbacks >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		onSuccessCallback: [ :aMemento | successAcceptCallbacks add: aMemento ];
		onErrorCallback: [ :aMemento | errorAcceptCallbacks add: aMemento ]
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithCallbacks >> magritteCancelAction [
	<magritteActionDescription>
	^ super magritteCancelAction
		onSuccessCallback: [ :aMemento | successCancelCallbacks add: aMemento ];
		onErrorCallback: [ :aMemento | errorCancelCallbacks add: aMemento ]
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithCallbacks >> magritteInspectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 20;
		label: 'New Inspect';
		blocIcon: BrGlamorousVectorIcons inspect;
		action: [ :aModel :aButton :aMemento :aDescription | 
			aButton inUIProcessDo: [ aButton phlow spawnObject: aMemento  ] ];
		beToolbarAction
]

{ #category : #accessing }
GtMagritteDummyPostalAddressWithCallbacks >> successAcceptCallbacks [
	^ successAcceptCallbacks
]

{ #category : #accessing }
GtMagritteDummyPostalAddressWithCallbacks >> successCancelCallbacks [
	^ successCancelCallbacks
]
