Class {
	#name : #GtMagritteExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #accessing }
GtMagritteExamples >> address [

	<gtExample>
	| anAddress |
	anAddress := self basicAddress.

	anAddress
		street: 'Husova 108/12';
		city: 'Všetín'.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteExamples >> basicAddress [

	<gtExample>
	| anAddress |
	anAddress := GtMagritteDummyPostalAddress new.

	^ anAddress
]
