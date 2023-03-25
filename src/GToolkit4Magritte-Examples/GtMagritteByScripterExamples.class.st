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

{ #category : #'examples - address with callbacks' }
GtMagritteByScripterExamples >> addressObjectWithCallbacks [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtMagritteModelExamples new addressObjectWithCallbacks ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ].

	self
		assert: aScripter
		model: aScripter model
		acceptEnabled: false
		cancelEnabled: false.

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressWithCallbacksAndAcceptChangedStreet [
	<gtExample>
	| aScripter |
	aScripter := self addressWithCallbacksAndChangedStreet.

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
				play.

			self
				assert: aStep
				successAcceptCount: 1
				errorAcceptCount: 0
				successCancelCount: 0
				errorCancelCount: 0 ].

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressWithCallbacksAndCanceledChangedStreet [
	<gtExample>
	| aScripter |
	aScripter := self addressWithCallbacksAndChangedStreet.

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
				cancelEnabled: false.

			self
				assert: aStep
				successAcceptCount: 0
				errorAcceptCount: 0
				successCancelCount: 1
				errorCancelCount: 0 ].

	^ aScripter
]

{ #category : #'examples - address with callbacks' }
GtMagritteByScripterExamples >> addressWithCallbacksAndChangedStreet [
	<gtExample>
	| aScripter |
	aScripter := self addressObjectWithCallbacks.

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
				cancelEnabled: true.

			self
				assert: aStep
				successAcceptCount: 0
				errorAcceptCount: 0
				successCancelCount: 0
				errorCancelCount: 0 ].

	^ aScripter
]

{ #category : #'examples - address without cancel' }
GtMagritteByScripterExamples >> addressWithoutCancel [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtMagritteModelExamples new addressObjectWithoutCancel ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ].

	self
		assert: aScripter
		model: aScripter model
		acceptEnabled: false
		cancelEnabled: nil.

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

	isCancelEnabled
		ifNotNil: [ aStep assert
				label: 'Assert cancel button enablement';
				value: [ :aButton | aButton isEnabled ]
					equals: [ :aButton | isCancelEnabled ];
				// anCancelId;
				play ]
		ifNil: [ aStep assert
				label: 'Assert cancel button is missing';
				value: [ :anElement | 
						| aQuery |
						aQuery := anElement query // anCancelId.
						aQuery result size ]
					equals: [ 0 ];
				play ]
]

{ #category : #'examples - support' }
GtMagritteByScripterExamples >> assert: aParentStep successAcceptCount: successAcceptCount errorAcceptCount: errorAcceptCount successCancelCount: successCancelCount errorCancelCount: errorCancelCount [
	aParentStep
		substeps: 'Assert action callbacks'
		do: [ :aStep | 
			aStep assert
				label: 'Assert accept success callbacks';
				value: [ :aModel | aModel successAcceptCallbacks size ]
					equals: [ successAcceptCount ];
				onModel;
				play.

			aStep assert
				label: 'Assert accept error callbacks';
				value: [ :aModel | aModel errorAcceptCallbacks size ]
					equals: [ errorAcceptCount ];
				onModel;
				play.

			aStep assert
				label: 'Assert cancel success callbacks';
				value: [ :aModel | aModel successCancelCallbacks size ]
					equals: [ successCancelCount ];
				onModel;
				play.

			aStep assert
				label: 'Assert cancel error callbacks';
				value: [ :aModel | aModel errorCancelCallbacks size ]
					equals: [ errorCancelCount ];
				onModel;
				play ]
]
