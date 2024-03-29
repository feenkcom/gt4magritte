Class {
	#name : #GtMagritteButtonWithIconAction,
	#superclass : #Object,
	#instVars : [
		'action',
		'installOn',
		'tooltip',
		'icon',
		'priority'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #accessing }
GtMagritteButtonWithIconAction >> action [

	^ action
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> action: anObject [

	action := anObject
]

{ #category : #'api - building' }
GtMagritteButtonWithIconAction >> asBlockButtonWithMemento: aMemento [
	| aButton |
	aButton := BrButton new
			beFocusable;
			beTinySize;
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: self icon;
			label: self tooltip;
			action: [ :theButton | 
				self action
					ifNotNil: [ :anAction | 
						anAction
							cull: aMemento model
							cull: theButton
							cull: aMemento ] ].

	self installOn
		ifNotNil: [ :anAction | 
			anAction
				cull: aMemento model
				cull: aButton
				cull: aMemento ].

	^ aButton
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> icon [

	^ icon
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> icon: anObject [

	icon := anObject
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> installOn [

	^ installOn
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> installOn: anObject [

	installOn := anObject
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> priority [
	^ priority ifNil: [ 50 ]
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> priority: aNumber [
	priority := aNumber
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> tooltip [

	^ tooltip
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> tooltip: anObject [

	tooltip := anObject
]
