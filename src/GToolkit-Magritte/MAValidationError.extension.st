Extension { #name : #MAValidationError }

{ #category : #'*GToolkit-Magritte' }
MAValidationError >> gtMagritteErrorsDo: aBlock [

	aBlock cull: self
]
