Class {
	#name : #GtMagritteByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit4Magritte-Examples-Core'
}

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> address [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtMagritteModelExamples new addressObject ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ].

	self
		assert: aScripter
		model: aScripter model
		acceptEnabled: false
		cancelEnabled: false.

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressAcceptChangedStreet [
	<gtExample>
	| aScripter |
	aScripter := self addressChangedStreet.

	aScripter
		substeps: 'Accept changed street values'
		do: [ :aStep | 
			| aStreetId aCancelId |
			aStreetId := GtMagritteFieldElementId new
					description: aScripter model descriptionStreet.

			aCancelId := GtMagritteActionElementId new
					description: aScripter model magritteAcceptAction.

			aStep click
				// aCancelId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: false.

			aStep assert
				label: 'Assert model street value';
				value: [ :aModel | aModel street ] equals: [ 'Hodonínova 77/7' ];
				onModel;
				play ].

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressCancelChangedStreet [
	<gtExample>
	| aScripter |
	aScripter := self addressChangedStreet.

	aScripter
		substeps: 'Cancel changed street values'
		do: [ :aStep | 
			| aStreetId aCancelId |
			aStreetId := GtMagritteFieldElementId new
					description: aScripter model descriptionStreet.

			aCancelId := GtMagritteActionElementId new
					description: aScripter model magritteCancelAction.

			aStep click
				// aCancelId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: false ].

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressChangedStreet [
	<gtExample>
	| aScripter |
	aScripter := self address.

	aScripter
		substeps: 'Change street widget value'
		do: [ :aStep | 
			| anId |
			anId := GtMagritteFieldElementId new
					description: aScripter model descriptionStreet.

			aStep requestFocus
				// anId;
				play.

			aStep type
				text: 'Hodonínova 77/7';
				// anId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: true
				cancelEnabled: true ].

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressEmptyStreet [
	<gtExample>
	| aScripter |
	aScripter := self address.

	aScripter
		substeps: 'Change street widget value'
		do: [ :aStep | 
			| anId |
			anId := GtMagritteFieldElementId new
					description: aScripter model descriptionStreet.

			aStep requestFocus
				// anId;
				play.

			aStep type
				text: '';
				// anId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: true ].

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> assert: aStep model: aModel acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled [
	| anAcceptId anCancelId |
	anAcceptId := GtMagritteActionElementId new
			description: aModel magritteAcceptAction.
	anCancelId := GtMagritteActionElementId new
			description: aModel magritteCancelAction.

	aStep assert
		label: 'Assert accept button enablement';
		value: [ :aButton | aButton isEnabled ]
			equals: [ :aButton | isAcceptEnabled ];
		// anAcceptId;
		play.

	aStep assert
		label: 'Assert cancel button enablement';
		value: [ :aButton | aButton isEnabled ]
			equals: [ :aButton | isCancelEnabled ];
		// anCancelId;
		play
]
