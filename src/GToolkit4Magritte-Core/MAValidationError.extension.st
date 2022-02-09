Extension { #name : #MAValidationError }

{ #category : #'*GToolkit4Magritte-Core' }
MAValidationError >> gtMagritteErrorsDo: aBlock [

	aBlock cull: self
]

{ #category : #'*GToolkit4Magritte-Core' }
MAValidationError >> gtMagritteErrorsDo: aMainBlock separatedBy: aSeparationBlock [

	aMainBlock cull: self
]
