Class {
	#name : #GtMagritteElementContext,
	#superclass : #Object,
	#instVars : [
		'element',
		'containerElements',
		'containerTypes'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - constants' }
GtMagritteElementContext class >> fieldName [

	^ #field
]

{ #category : #'api - constants' }
GtMagritteElementContext class >> labelName [

	^ #label
]

{ #category : #'instance creation' }
GtMagritteElementContext class >> on: anElement [

	^ self new element: anElement
]

{ #category : #'api - constants' }
GtMagritteElementContext class >> toolbarName [

	^ #toolbar
]

{ #category : #'api - initialization' }
GtMagritteElementContext >> beFieldContainer [

	containerTypes at: self class fieldName put: true
]

{ #category : #'api - initialization' }
GtMagritteElementContext >> beLabelContainer [

	containerTypes at: self class labelName put: true
]

{ #category : #'api - initialization' }
GtMagritteElementContext >> beToolbarContainer [

	containerTypes at: self class toolbarName put: true
]

{ #category : #'api - accessing' }
GtMagritteElementContext >> containerNamed: aSymbol do: aBlock [

	"Search cached container"
	containerElements
		at: aSymbol
		ifPresent: [ :aHolder | 
			aHolder elementDo: aBlock.
			^ self ]
		ifAbsent: [ "ignore" ].

	"Find new container"
	self element withAllChildrenBreadthFirstDo: [ :anElement | 
		(anElement magritte isContainerNamed: aSymbol) ifTrue: [ 
			| aHolder |
			containerElements
				at: aSymbol
				put: (aHolder := GtMagritteElementHolder forElement: anElement).
			aHolder elementDo: aBlock.
			^ self ] ].

	"There is no such container. Let's store the information."
	containerElements at: aSymbol put: GtMagritteElementHolder null
]

{ #category : #accessing }
GtMagritteElementContext >> element [

	^ element
]

{ #category : #accessing }
GtMagritteElementContext >> element: anObject [

	element := anObject
]

{ #category : #'api - accessing' }
GtMagritteElementContext >> fieldContainerDo: aBlock [

	self containerNamed: self class fieldName do: aBlock
]

{ #category : #'gt - extensions' }
GtMagritteElementContext >> gtContainerElementsFor: aView [

	<gtView>
	containerElements ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Container elements';
		  priority: 2;
		  items: [ 
			  containerElements ifNotNil: #associations ifNil: [ #(  ) ] ];
		  column: 'Container Type' text: #key;
		  column: 'Element' text: #value weight: 3;
		  send: [ :anAssoc | 
			  | anElement |
			  anAssoc value elementDo: [ :theElement | anElement := theElement ].
			  anElement ];
		  actionUpdateButtonTooltip: 'Update items'
]

{ #category : #'gt - extensions' }
GtMagritteElementContext >> gtContainerTypesFor: aView [

	<gtView>
	containerTypes ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Container types';
		  priority: 1;
		  items: [ containerTypes ifNotNil: #associations ifNil: [ #(  ) ] ];
		  column: 'Container Type' text: #key;
		  send: #key;
		  actionUpdateButtonTooltip: 'Update items'
]

{ #category : #initialization }
GtMagritteElementContext >> initialize [

	super initialize.

	containerTypes := SmallDictionary new: 3.
	containerElements := SmallDictionary new: 3.
]

{ #category : #'api - testing' }
GtMagritteElementContext >> isContainerNamed: aSymbol [

	^ containerTypes at: aSymbol ifAbsent: [ false ]
]

{ #category : #'api - testing' }
GtMagritteElementContext >> isFieldContainer [

	^ self isContainerNamed: self class fieldName
]

{ #category : #'api - testing' }
GtMagritteElementContext >> isLabelContainer [

	^ self isContainerNamed: self class labelName
]

{ #category : #'api - accessing' }
GtMagritteElementContext >> labelContainerDo: aBlock [

	self containerNamed: self class labelName do: aBlock
]

{ #category : #'api - accessing' }
GtMagritteElementContext >> toolbarContainerDo: aBlock [

	self containerNamed: self class toolbarName do: aBlock
]
