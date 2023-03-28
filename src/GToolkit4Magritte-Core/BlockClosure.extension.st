Extension { #name : #BlockClosure }

{ #category : #'*GToolkit4Magritte-Core' }
BlockClosure >> asGtMagritteCallback [
	^ GtMagritteCallback new action: self
]
