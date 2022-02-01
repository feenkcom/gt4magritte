Class {
	#name : #GtMagritteNullElementHolder,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Magritte-Core-Support'
}

{ #category : #'api - accessing' }
GtMagritteNullElementHolder >> elementDo: aBlock [

	"do nothing"

	
]

{ #category : #printing }
GtMagritteNullElementHolder >> gtDisplayOn: aStream [

	aStream nextPutAll: 'ignored container'
]
