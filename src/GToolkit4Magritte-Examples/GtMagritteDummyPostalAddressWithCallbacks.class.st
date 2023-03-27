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
GtMagritteDummyPostalAddressWithCallbacks >> descriptionIsFavorite [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Favorite';
		comment: 'A buggy description, please do not add #isFavorite:';
		accessor: #isFavorite;
		default: false;
		priority: 15;
		trueString: 'favorite';
		falseString: '';
		blocActionString: 'set as favorite';
		blocUseDropdown: true
]

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

{ #category : #accessing }
GtMagritteDummyPostalAddressWithCallbacks >> isFavorite [
	"A buggy implementation, please do not add #isFavorite:"

	^ false
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
					2 seconds wait.
					aMemento commit.
					2 seconds wait ])
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
