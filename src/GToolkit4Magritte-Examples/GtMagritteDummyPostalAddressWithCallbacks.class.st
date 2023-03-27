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
		onSuccessCallback: (GtMagritteCallback new
			action: [ :aModel :aButton :aMemento :aDescription | successAcceptCallbacks add: aMemento ]);
		onErrorCallback: (GtMagritteCallback new
			action: [ :aModel :aButton :aMemento :aDescription | errorAcceptCallbacks add: aMemento ])
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithCallbacks >> magritteCancelAction [
	<magritteActionDescription>
	^ super magritteCancelAction
		onSuccessCallback: (GtMagritteCallback new
			action: [ :aModel :aButton :aMemento :aDescription | successCancelCallbacks add: aMemento ]);
		onErrorCallback: (GtMagritteCallback new
			action: [ :aModel :aButton :aMemento :aDescription | errorCancelCallbacks add: aMemento ])
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithCallbacks >> magritteDelayedAcceptAction [
	<magritteActionDescription>
	^ self magritteAcceptAction
		priority: 15;
		label: 'Delayed Accept';
		isLabelVisible: true;
		action: (GtMagritteAction new
				beInFutureProcess;
				beWithFutureResponse;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aMemento commit.
					3 seconds wait ])
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithCallbacks >> magritteErrorAcceptAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 16;
		label: 'Error Action';
		blocIcon: BrGlamorousVectorIcons debug;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					3 / 0 ]);
		beToolbarAction
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithCallbacks >> magritteInspectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 20;
		label: 'Inspect';
		blocIcon: BrGlamorousVectorIcons inspect;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aButton phlow spawnObject: aMemento ]);
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
