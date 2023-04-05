Class {
	#name : #GtMagritteDummyPostalAddressWithoutCancel,
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
GtMagritteDummyPostalAddressWithoutCancel >> errorAcceptCallbacks [
	^ errorAcceptCallbacks
]

{ #category : #accessing }
GtMagritteDummyPostalAddressWithoutCancel >> errorCancelCallbacks [
	^ errorCancelCallbacks
]

{ #category : #initialization }
GtMagritteDummyPostalAddressWithoutCancel >> initialize [
	super initialize.

	successAcceptCallbacks := OrderedCollection new.
	errorAcceptCallbacks := OrderedCollection new.
	successCancelCallbacks := OrderedCollection new.
	errorCancelCallbacks := OrderedCollection new
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithoutCancel >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		onSuccessCallback: (GtMagritteCallback new
			action: [ :aModel :aButton :aMemento :aDescription | successAcceptCallbacks add: { aModel. aButton. aMemento. aDescription } ]);
		onErrorCallback: (GtMagritteCallback new
			action: [ :aModel :aButton :aMemento :aDescription | errorAcceptCallbacks add: { aModel. aButton. aMemento. aDescription } ])
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddressWithoutCancel >> magritteCancelAction [
	<magritteActionDescription>
	^ nil
]

{ #category : #accessing }
GtMagritteDummyPostalAddressWithoutCancel >> successAcceptCallbacks [
	^ successAcceptCallbacks
]

{ #category : #accessing }
GtMagritteDummyPostalAddressWithoutCancel >> successCancelCallbacks [
	^ successCancelCallbacks
]
