Class {
	#name : #GtMagritteIconDescription,
	#superclass : #MAElementDescription,
	#category : #'GToolkit4Magritte-Core-Descriptions'
}

{ #category : #visiting }
GtMagritteIconDescription >> acceptMagritte: aVisitor [

	aVisitor visitIconDescription: self
]

{ #category : #accessing }
GtMagritteIconDescription >> blocStencil [

	^ self
		  propertyAt: #blocStencil
		  ifAbsent: [ GtMagritteModelStencilBuilder new ]
]

{ #category : #accessing }
GtMagritteIconDescription >> blocStencil: aStencil [

	self
		propertyAt: #blocStencil
		put: (aStencil asStencilBuilder: GtMagritteModelStencilBuilder)
]
