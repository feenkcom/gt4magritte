Class {
	#name : #MAGridDescription,
	#superclass : #MAElementDescription,
	#category : #'GToolkit-Magritte-Descriptions'
}

{ #category : #visiting }
MAGridDescription >> acceptMagritte: aVisitor [

	aVisitor visitGridDescription: self
]

{ #category : #accessing }
MAGridDescription >> stencil [

	"aStencilBuilder is expected to be a subclass of BrListRowStencil or a valuable"

	^ self
		  propertyAt: #blocStencil
		  ifAbsentPut:
			  ([ :anItem | anItem asGtMagritteViewModel ] asStencilBuilder:
				   BrListRowStencilBuilder)
]

{ #category : #accessing }
MAGridDescription >> stencil: aStencilBuilder [

	"aStencilBuilder is expected to be a subclass of BrListRowStencil or a valuable"

	self
		propertyAt: #blocStencil
		put: (aStencilBuilder asStencilBuilder: BrListRowStencilBuilder)
]
