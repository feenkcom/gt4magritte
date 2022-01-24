Extension { #name : #MAElementDescription }

{ #category : #'*GToolkit-Magritte-Core' }
MAElementDescription >> blocCompletion [

	^ self propertyAt: #blocCompletion ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAElementDescription >> blocCompletion: aStrategyStencil [

	self propertyAt: #blocCompletion put: aStrategyStencil asStencil
]
