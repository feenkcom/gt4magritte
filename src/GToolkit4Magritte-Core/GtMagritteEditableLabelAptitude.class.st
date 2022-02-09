Class {
	#name : #GtMagritteEditableLabelAptitude,
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
GtMagritteEditableLabelAptitude >> defaultBackground [
	^ defaultBackground
]

{ #category : #accessing }
GtMagritteEditableLabelAptitude >> defaultBackground: anObject [
	defaultBackground := anObject.
	styleLook 
		default: [ :aStyle |
			aStyle background: self defaultBackground ];
		when: [ :aState | aState hovered and: BrEditorModeState readOnly ]
			style: [ :aStyle | aStyle background: self defaultBackground darker ].
]

{ #category : #accessing }
GtMagritteEditableLabelAptitude >> defaultForeground [
	^ defaultForeground
]

{ #category : #accessing }
GtMagritteEditableLabelAptitude >> defaultForeground: anObject [
	defaultForeground := anObject
]

{ #category : #initialization }
GtMagritteEditableLabelAptitude >> initialize [
	super initialize.
	defaultBackground := Color transparent.
	defaultForeground := Color black.
	minWidth := 5.
	self
		addChangeProperty: #(widget constraints minWidth)
		with: [ self minWidth ].
	self
		add:
			(styleLook := BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
					aStyle background: self defaultBackground.
					aStyle border: BlBorder empty ];
				when: BrEditorModeState editable
					style: [ :aStyle | aStyle background: Color transparent ];
				when: [ :aState | aState focused not and: BrEditorModeState editable ]
					style: [ :aStyle | 
					aStyle
						border: (BlBorder paint: self theme editor borderColor width: 1) ];
				when: [ :aState | aState focused and: BrEditorModeState editable ]
					style: [ :aStyle | 
					aStyle
						border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ];
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
GtMagritteEditableLabelAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BlClickEvent do: [ :anEvent | anEvent currentTarget dispatchEvent: (BlElementSelectedStateWish selected: true) ]
]

{ #category : #accessing }
GtMagritteEditableLabelAptitude >> minWidth [
	^ minWidth
]

{ #category : #accessing }
GtMagritteEditableLabelAptitude >> minWidth: anObject [
	minWidth := anObject
]
