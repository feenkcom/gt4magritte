Extension { #name : #MAValidationError }

{ #category : #'*GToolkit-Magritte-Core' }
MAValidationError >> gtMagritteErrorsDo: aBlock [

	aBlock cull: self
]

{ #category : #'*GToolkit-Magritte-Core' }
MAValidationError >> gtMagritteErrorsDo: aMainBlock separatedBy: aSeparationBlock [

	aMainBlock cull: self
]
