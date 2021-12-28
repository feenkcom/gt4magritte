Class {
	#name : #GtMagritteBaselineDescription,
	#superclass : #MAElementDescription,
	#category : #'GToolkit-Magritte-Descriptions'
}

{ #category : #accessing }
GtMagritteBaselineDescription class >> defaultKind [

	^ String
]

{ #category : #testing }
GtMagritteBaselineDescription class >> isAbstract [

	^ false
]

{ #category : #accessing }
GtMagritteBaselineDescription class >> label [

	^ 'Baseline'
]

{ #category : #visiting }
GtMagritteBaselineDescription >> acceptMagritte: aVisitor [

	aVisitor visitBaselineDescription: self
]

{ #category : #testing }
GtMagritteBaselineDescription >> isSortable [

	^ true
]
