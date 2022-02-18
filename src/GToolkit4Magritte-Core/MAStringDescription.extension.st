Extension { #name : #MAStringDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAStringDescription >> blocStencil [

	^ self propertyAt: #blocStencil ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAStringDescription >> blocStencil: aBlock [
	self propertyAt: #blocStencil put: aBlock
]
