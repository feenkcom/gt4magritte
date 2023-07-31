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
GtMagritteByScripterExamples >> addressWithCallbacksAndAcceptActionWithDefectiveCallbacks [
	<gtExample>
	| aScripter |
	aScripter := self addressWithCallbacksAndChangedStreet.

	aScripter
		substeps: 'Unsuccessful cancel of changed street values'
		do: [ :aStep | 
			| aStreetId anAcceptId |
			aStreetId := GtMagritteFieldElementId new
					description: aScripter model descriptionStreet.

			anAcceptId := GtMagritteActionElementId new
					description: aScripter model magritteAcceptActionWithDefectiveCallbacks.

			aStep click
				// anAcceptId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: false.

			self
				assert: aStep
				successAcceptCount: 1
				errorAcceptCount: 0
				successCancelCount: 0
				errorCancelCount: 0 ].

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
GtMagritteByScripterExamples >> addressWithCallbacksAndChangedFavorite [
	<gtExample>
	| aScripter |
	aScripter := self addressObjectWithCallbacks.

	aScripter
		substeps: 'Change favorite widget value'
		do: [ :aStep | 
			| anId |
			anId := GtMagritteFieldElementId new
					description: aScripter model descriptionIsFavorite.

			aStep click
				// anId;
				// BrCheckbox;
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

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressWithCallbacksAndDefectiveAcceptAction [
	<gtExample>
	| aScripter |
	aScripter := self addressWithCallbacksAndChangedStreet.

	aScripter
		substeps: 'Unsuccessful cancel of changed street values'
		do: [ :aStep | 
			| aStreetId anAcceptId |
			aStreetId := GtMagritteFieldElementId new
					description: aScripter model descriptionStreet.

			anAcceptId := GtMagritteActionElementId new
					description: aScripter model magritteDefectiveAcceptAction.

			aStep click
				// anAcceptId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: true
				cancelEnabled: true.

			self
				assert: aStep
				successAcceptCount: 0
				errorAcceptCount: 1
				successCancelCount: 0
				errorCancelCount: 0 ].

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressWithCallbacksAndDefectiveCancelAction [
	<gtExample>
	| aScripter |
	aScripter := self addressWithCallbacksAndChangedStreet.

	aScripter
		substeps: 'Unsuccessful cancel of changed street values'
		do: [ :aStep | 
			| aStreetId aCancelId |
			aStreetId := GtMagritteFieldElementId new
					description: aScripter model descriptionStreet.

			aCancelId := GtMagritteActionElementId new
					description: aScripter model magritteDefectiveCancelAction.

			aStep click
				// aCancelId;
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
				errorCancelCount: 1 ].

	^ aScripter
]

{ #category : #'examples - address' }
GtMagritteByScripterExamples >> addressWithErrorAcceptCallbacks [
	<gtExample>
	| aScripter |
	aScripter := self addressWithCallbacksAndChangedFavorite.

	aScripter
		substeps: 'Accept changed favorite value'
		do: [ :aStep | 
			| aFavoriteId anAcceptId |
			aFavoriteId := GtMagritteFieldElementId new
					description: aScripter model descriptionIsFavorite.

			anAcceptId := GtMagritteActionElementId new
					description: aScripter model magritteAcceptAction.

			aStep click
				// anAcceptId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: true
				cancelEnabled: true.

			self
				assert: aStep
				successAcceptCount: 0
				errorAcceptCount: 1
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

{ #category : #assertions }
GtMagritteByScripterExamples >> assert: aStep model: aModel actionDescription: aDescription isEnabled: isButtonEnabled label: aLabelString [
	| aButtonId |
	aButtonId := GtMagritteActionElementId new description: aDescription.

	self
		assert: aStep
		model: aModel
		actionId: aButtonId
		isEnabled: isButtonEnabled
		label: aLabelString
]

{ #category : #assertions }
GtMagritteByScripterExamples >> assert: aStep model: aModel actionId: aButtonId isEnabled: isButtonEnabled label: aLabelString [
	aStep assert
		label: ('Assert {1} button is {2}' format: { 
			aLabelString.
			isButtonEnabled ifTrue: [ 'enabled' ] ifFalse: [ 'disabled' ] });
		value: [ :aButton | aButton isEnabled ]
			equals: [ :aButton | isButtonEnabled ];
		// aButtonId;
		play.
		
	aStep assert
		label: ('Assert {1} button label' format: { aLabelString });
		value: [ :aButton | aButton label asString ]
			equals: [ :aButton | aLabelString asString ];
		// aButtonId;
		play.
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
				play.
			
			successAcceptCount > 0 ifTrue: [
				aStep assert
					label: 'Assert success accept callbacks have all parameters';
					satisfies: [ :aModel | 
						aModel successAcceptCallbacks 
							allSatisfy: [ :anArray | anArray size = 4 
								and: [ anArray allSatisfy: #isNotNil ] ] ];
					onModel;
					play ].
					
			errorAcceptCount > 0 ifTrue: [
				aStep assert
					label: 'Assert error accept callbacks have all parameters';
					satisfies: [ :aModel | 
						aModel errorAcceptCallbacks 
							allSatisfy: [ :anArray | anArray size = 4 
								and: [ anArray allSatisfy: #isNotNil ] ] ];
					onModel;
					play ].
					
			successCancelCount > 0 ifTrue: [
				aStep assert
					label: 'Assert success cancel callbacks have all parameters';
					satisfies: [ :aModel | 
						aModel successCancelCallbacks 
							allSatisfy: [ :anArray | anArray size = 4 
								and: [ anArray allSatisfy: #isNotNil ] ] ];
					onModel;
					play ].
					
			errorCancelCount > 0 ifTrue: [
				aStep assert
					label: 'Assert error cancel callbacks have all parameters';
					satisfies: [ :aModel | 
						aModel errorCancelCallbacks 
							allSatisfy: [ :anArray | anArray size = 4 
								and: [ anArray allSatisfy: #isNotNil ] ] ];
					onModel;
					play ].
		]
]

{ #category : #'examples - server' }
GtMagritteByScripterExamples >> serverObject [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtMagritteModelExamples new basicServerObject ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ].

			
	aScripter substeps: 'Assert default server' do: [ :aStep | 
		self
			assert: aStep
			model: aScripter model
			acceptEnabled: false
			cancelEnabled: false.
			
		self 
			assert: aStep
			model: aScripter model
			actionDescription: (aScripter model startAndStopActionDescription) 
			isEnabled: true 
			label: 'Start'.
			
		aStep assert
				label: 'Server read-only mode value is false';
				value: [ :aModel | aModel readOnlyMode ] equals: [ false ];
				onModel;
				play.
				
		aStep assert
				label: 'Server port value is 0';
				value: [ :aModel | aModel port ] equals: [ 0 ];
				onModel;
				play.
	].

	^ aScripter
]

{ #category : #'examples - server' }
GtMagritteByScripterExamples >> serverObjectInStartedState [
	<gtExample>
	| aScripter |
	aScripter := self serverObject.
	
	aScripter 
		substeps: 'Start server'
		do: [ :aStep | 
			| aStartDescription |
			aStartDescription := aScripter model startAndStopActionDescription.
			
			aStep click
				label: 'Click on the start button';
				// (GtMagritteActionElementId new description: aStartDescription);
				play.
				
			self 
				assert: aStep
				model: aScripter model
				actionDescription: aScripter model startAndStopActionDescription 
				isEnabled: true 
				label: 'Stop'.
				
			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: false.
				
			aStep assert
				label: 'Server port value is NOT 0';
				satisfies: [ :aModel | aModel port ~= 0 ];
				onModel;
				play.
		].
				
	^ aScripter
]

{ #category : #'examples - server' }
GtMagritteByScripterExamples >> serverObjectInStartedStateAndAutoAcceptWidget [
	<gtExample>
	| aScripter |
	aScripter := self serverObjectInStartedState.
	
	aScripter
		substeps: 'Change Read-only server mode value to true'
		do: [ :aStep | 
			| anId |
			anId := GtMagritteFieldElementId new
					description: aScripter model readOnlyModeRequestDescription.

			aStep click
				label: 'Click on the checkbox';
				// anId;
				/ BrCheckbox;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: false.
				
			self 
				assert: aStep
				model: aScripter model
				actionDescription: aScripter model startAndStopActionDescription 
				isEnabled: true 
				label: 'Stop'.
				
			aStep assert
				label: 'Server read-only mode value is true';
				value: [ :aModel | aModel readOnlyMode ] equals: [ true ];
				onModel;
				play. ].
				
	^ aScripter
]

{ #category : #'examples - server' }
GtMagritteByScripterExamples >> serverObjectInStartedStateAndReadOnlyPort [
	<gtExample>
	| aScripter |
	aScripter := self serverObjectInStartedState.
	
	aScripter
		substeps: 'Try to change read-only port value'
		do: [ :aStep | 
			| anId |
			anId := GtMagritteFieldElementId new
					description: aScripter model portDescription.

			aStep requestFocus
				// anId;
				play.

			aStep type
				text: '2023';
				// anId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: false.
				
			self 
				assert: aStep
				model: aScripter model
				actionDescription: aScripter model startAndStopActionDescription
				isEnabled: true 
				label: 'Stop' ].
				
	^ aScripter
]

{ #category : #'examples - server' }
GtMagritteByScripterExamples >> serverObjectInStoppedStateAndChangedPort [
	<gtExample>
	| aScripter |
	aScripter := self serverObject.
	
	aScripter
		substeps: 'Change port widget value'
		do: [ :aStep | 
			| anId |
			anId := GtMagritteFieldElementId new
					description: aScripter model portDescription.

			aStep requestFocus
				// anId;
				play.

			aStep type
				text: '2023';
				// anId;
				play.

			self
				assert: aStep
				model: aScripter model
				acceptEnabled: true
				cancelEnabled: true.
				
			self 
				assert: aStep
				model: aScripter model
				actionDescription: (aScripter model startAndStopActionDescription) 
				isEnabled: false 
				label: 'Start' ].
				
	^ aScripter
]
