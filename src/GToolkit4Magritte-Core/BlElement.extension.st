Extension { #name : #BlElement }

{ #category : #'*GToolkit4Magritte-Core' }
BlElement >> magritte [

	^ self userData
		  at: #gtMagritteElementContext
		  ifAbsentPut: [ GtMagritteElementContext on: self ]
]

{ #category : #'*GToolkit4Magritte-Core' }
BlElement >> magritteDo: aBlock [

	aBlock value: self magritte
]
