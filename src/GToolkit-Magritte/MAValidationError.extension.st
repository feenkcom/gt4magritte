Extension { #name : #MAValidationError }

{ #category : #'*GToolkit-Magritte' }
MAValidationError >> gtMagritteErrorsDo: aBlock [

	aBlock cull: self
]

{ #category : #'*GToolkit-Magritte' }
MAValidationError >> gtMagritteErrorsDo: aMainBlock separatedBy: aSeparationBlock [

	aMainBlock cull: self
]
