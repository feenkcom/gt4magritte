Extension { #name : #MAElementDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> blocCompletion [

	^ self propertyAt: #blocCompletion ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> blocCompletion: aStrategyStencil [

	self propertyAt: #blocCompletion put: (aStrategyStencil asStencilBuilder: GtMagritteCompletionStrategyStencilBuilder)
]
