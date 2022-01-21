Class {
	#name : #GtMagritteSelectorAction,
	#superclass : #Object,
	#instVars : [
		'selector'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
}

{ #category : #converting }
GtMagritteSelectorAction >> asBlocButtonWithPresenter: aPresenter [

	^ BrButton new
		  beTinySize;
		  aptitude: BrGlamorousButtonWithLabelAptitude;
		  label: self label;
		  action: [ :aButton | aPresenter perform: self selector ]
]

{ #category : #printing }
GtMagritteSelectorAction >> gtDisplayOn: stream [

	stream nextPutAll: self label asString
]

{ #category : #accessing }
GtMagritteSelectorAction >> label [

	^ self selector capitalized
]

{ #category : #printing }
GtMagritteSelectorAction >> printOn: aStream [

	super printOn: aStream.

	self selector ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		print: self selector;
		nextPut: $)
]

{ #category : #accessing }
GtMagritteSelectorAction >> selector [

	^ selector
]

{ #category : #accessing }
GtMagritteSelectorAction >> selector: anObject [

	selector := anObject
]
