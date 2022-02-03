Extension { #name : #MAContainer }

{ #category : #'*GToolkit-Magritte-Core' }
MAContainer >> blocElementContainerStencil [

	^ self propertyAt: #blocElementContainerStencil ifAbsent: [ 
		  [ :aMemento | GtMagritteBuilderUtility newHorizontalGridContainer ] 
			  asStencilBuilder: GtMagritteFormStencilBuilder ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAContainer >> blocElementContainerStencil: aStencilBuilder [

	"Stencil builder may be a block that receives a memento [ :aMemento | ... ]
	and builds an element"

	self
		propertyAt: #blocElementContainerStencil
		put: (aStencilBuilder asStencilBuilder: GtMagritteFormStencilBuilder)
]

{ #category : #'*GToolkit-Magritte-Core' }
MAContainer >> gtChildrenFor: aView [

	<gtView>
	self children ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Descriptions';
		  priority: 51;
		  items: [ self children ];
		  column: 'Label' text: #label;
		  column: 'Comment' text: [ :e | e comment ifNil: [ '' ] ] weight: 3
]
