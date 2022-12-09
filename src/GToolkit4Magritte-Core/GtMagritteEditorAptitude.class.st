Class {
	#name : #GtMagritteEditorAptitude,
	#superclass : #BrGlamorousEditorAptitude,
	#instVars : [
		'defaultBackground',
		'defaultForeground',
		'minWidth',
		'styleLook'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #accessing }
GtMagritteEditorAptitude >> defaultBackground [
	^ defaultBackground
]

{ #category : #accessing }
GtMagritteEditorAptitude >> defaultBackground: anObject [
	defaultBackground := anObject.
	styleLook 
		default: [ :aStyle |
			aStyle background: self defaultBackground ];
		when: [ :aState | aState hovered and: BrEditorModeState readOnly ]
			style: [ :aStyle | aStyle background: self defaultBackground darker ].
]

{ #category : #accessing }
GtMagritteEditorAptitude >> defaultForeground [
	^ defaultForeground
]

{ #category : #accessing }
GtMagritteEditorAptitude >> defaultForeground: anObject [
	defaultForeground := anObject
]

{ #category : #initialization }
GtMagritteEditorAptitude >> initialize [
	super initialize.
	defaultBackground := Color transparent.
	defaultForeground := Color black.
	minWidth := 5.
	self addChangeProperty: #(widget constraints minWidth) with: [ self minWidth ].
	self
		add: (styleLook := BrStyleCommonAptitude new
					default: [ :aStyle | 
						aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
						aStyle background: self defaultBackground.
						aStyle border: BlBorder empty ];
					when: BrEditorModeState editable
						style: [ :aStyle | aStyle background: Color transparent ];
					when: [ :aState | aState focused and: BrEditorModeState editable ]
						style: [ :aStyle | aStyle border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ];
					when: [ :aState | aState hovered and: BrEditorModeState readOnly ]
						style: [ :aStyle | aStyle background: BrGlamorousColors disabledButtonBackgroundColor ];
					when: [ :aState | aState focused and: BrEditorModeState readOnly ]
						style: [ :aStyle | 
							aStyle background: self theme editor focusedBorderColor.
							aStyle
								do: [ self foreground: Color white ]
								after: [ self foreground: self defaultForeground ] ])
]

{ #category : #initialization }
GtMagritteEditorAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BlClickEvent do: [ :anEvent | anEvent currentTarget dispatchEvent: (BlElementSelectedStateWish selected: true) ]
]

{ #category : #accessing }
GtMagritteEditorAptitude >> minWidth [
	^ minWidth
]

{ #category : #accessing }
GtMagritteEditorAptitude >> minWidth: anObject [
	minWidth := anObject
]
