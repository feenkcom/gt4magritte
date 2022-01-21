Extension { #name : #Symbol }

{ #category : #'*GToolkit-Magritte-SecondImplementation' }
Symbol >> asGtMagritteAction [

	^ GtMagritteSelectorAction new selector: self
]
