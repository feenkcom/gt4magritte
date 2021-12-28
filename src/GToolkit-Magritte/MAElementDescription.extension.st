Extension { #name : #MAElementDescription }

{ #category : #'*GToolkit-Magritte' }
MAElementDescription >> blocCompletion [

	^ self propertyAt: #blocCompletion ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Magritte' }
MAElementDescription >> blocCompletion: aStrategyStencil [

	self propertyAt: #blocCompletion put: aStrategyStencil asStencil
]
