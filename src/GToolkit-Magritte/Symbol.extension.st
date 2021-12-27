Extension { #name : #Symbol }

{ #category : #'*GToolkit-Magritte' }
Symbol >> asGtMagritteAction [

	^ GtMagritteSelectorAction new selector: self
]
