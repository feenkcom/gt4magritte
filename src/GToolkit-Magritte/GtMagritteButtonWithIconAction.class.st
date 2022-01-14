Class {
	#name : #GtMagritteButtonWithIconAction,
	#superclass : #Object,
	#instVars : [
		'action',
		'installOn',
		'tooltip',
		'icon'
	],
	#category : #'GToolkit-Magritte-Support'
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
		           beTinySize;
		           aptitude: BrGlamorousButtonWithIconAptitude;
		           icon: self icon;
		           label: self tooltip;
		           action: [ :theButton | 
			           self action ifNotNil: [ :anAction | 
					           anAction cull: aMemento cull: theButton ] ].

	self installOn ifNotNil: [ :anAction | 
		anAction cull: aMemento cull: aButton ].

	^ aButton
]

{ #category : #'api - converting' }
GtMagritteButtonWithIconAction >> asGtMagritteAction [

	^ self
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
GtMagritteButtonWithIconAction >> tooltip [

	^ tooltip
]

{ #category : #accessing }
GtMagritteButtonWithIconAction >> tooltip: anObject [

	tooltip := anObject
]
