Extension { #name : #MAActionDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> announcerSubscriptionsDo: aBlock [
	"Iterates over all subscriptions"

	self
		propertyAt: #announcerSubscriptions
		ifPresent: [ :aCollection | 
			aCollection do: aBlock ]
		ifAbsent: [ "ignore" ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> asBlockButtonWithMemento: aMemento [
	^ GtMagritteActionElement new
		fieldViewModel: (GtMagritteFieldViewModel new
				memento: aMemento;
				description: self)
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beAlwaysEnabled [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aDescription enabled: true ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beDisabledOnActive [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aDescription enabled: aStatus isActive not ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beDisabledOnExecution [
	self beDisabledOnActive
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beEnabledAndChangedAndInactiveOverallStatus [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aStatus isChanged
					ifTrue: [ aDescription enabled: aStatus isInactive ]
					ifFalse: [ aDescription enabled: false ] ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beEnabledAndChangedAndValidAndInactiveOverallStatus [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aStatus isChanged
					ifTrue: [ aDescription enabled: aStatus isValidAndInactive ]
					ifFalse: [ aDescription enabled: false ] ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beEnabledOnChangedOverallStatus [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aStatus isChanged
					ifTrue: [ aDescription enabled: true ]
					ifFalse: [ aDescription enabled: false ] ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beEnabledOnValidOverallStatus [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aDescription enabled: aStatus isValid ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beToolbarAction [
	self propertyAt: #beToolbarAction put: true
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> blocIcon [
	"Return an object that understands #asElement, 
	providing a {{gtClass:BlElement}}"

	^ self propertyAt: #blocIcon ifAbsent: [ self icon ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> blocIcon: aStencil [
	self propertyAt: #blocIcon put: aStencil
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription class >> defaultEnabled [
	^ true
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription class >> defaultVisible [
	^ true
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> enabled [
	"Return true if the action is enabled or false if the action should be disabled."

	<return: #Boolean>
	^ self propertyAt: #enabled ifAbsent: [ self class defaultEnabled ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> enabled: aBoolean [
	"Set whether the action should be enabled (true) or disabled (false)."

	self propertyAt: #enabled put: aBoolean
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> gtSourceFor: aView [
	<gtView>
	self definingContext ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self definingContext ];
		view: #compiledMethodGtViewFor:
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> isToolbarAction [
	^ self propertyAt: #beToolbarAction ifAbsent: [ false ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onErrorCallback: aCallback [
	self onErrorCallbacks add: aCallback
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onErrorCallbacks [
	^ self 
		propertyAt: #onErrorCallbacks 
		ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onErrorCallbacks: aCollection [
	^ self propertyAt: #onErrorCallbacks put: aCollection
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onOverallStatusChanged [
	^ self propertyAt: #onOverallStatusChanged ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onOverallStatusChanged: aBlock [
	"aBlock with arguments [ :aStatus :anElement :aMemento :aDescription | ]."

	self
		propertyAt: #onOverallStatusChanged
		put: aBlock
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onSuccessCallback: aCallback [
	self onSuccessCallbacks add: aCallback
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onSuccessCallbacks [
	^ self 
		propertyAt: #onSuccessCallbacks 
		ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onSuccessCallbacks: aCollection [
	^ self propertyAt: #onSuccessCallbacks put: aCollection
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> updateDescription: aDescriptionSetterSelector as: aModelValueSelector on: anAnnouncementClass from: anAnnouncerBlock [

	| aSpecification |
	aSpecification := GtMagritteDescriptionFromModelUpdateSpecification new
		descriptionSetterSelector: aDescriptionSetterSelector;
		modelValueSelector: aModelValueSelector;
		announcementClass: anAnnouncementClass;
		announcerBlock: anAnnouncerBlock.

	self
		propertyAt: #announcerSubscriptions
		ifPresent: [ :aCollection | 
			aCollection add: aSpecification ]
		ifAbsentPut: [ 
			OrderedCollection with: aSpecification ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> visible [
	"Answer ==true== if the model described by the receiver is visible, as an opposite to hidden."

	^ self propertyAt: #visible ifAbsent: [ self class defaultVisible ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> visible: aBoolean [
	self propertyAt: #visible put: aBoolean
]
