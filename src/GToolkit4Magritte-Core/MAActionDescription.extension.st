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
	| aButton |
	aButton := BrButton new
			id: (GtMagritteActionElementId new description: self);
			beFocusable;
			beTinySize.

	self blocIcon ifNotNil: [ :aStencil | aButton icon: aStencil ].

	self label ifNotNil: [ :aLabel | aButton label: aLabel ].

	self isLabelVisible
		ifTrue: [ aButton aptitude: BrGlamorousButtonWithIconAndLabelAptitude ]
		ifFalse: [ aButton aptitude: BrGlamorousButtonWithIconAptitude ].

	self action
		ifNotNil: [ :anAction | 
			aButton
				action: [ :theButton | 
					anAction
						cull: aMemento model
						cull: theButton
						cull: aMemento
						cull: self ] ].

	aButton
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theButton :aSink | 
					| aStatus |
					aStatus := aSink value.

					self onOverallStatusChanged
						ifNotNil: [ :aBlock | 
							aBlock
								cull: aStatus
								cull: aButton
								cull: aMemento
								cull: self ] ].
			aMemento overallStatus observe: anElementSink ].
			
	aButton userData
		at: #maIconHandler put: (GtMagritteDescriptionPropertyChangedHandler new
			key: #blocIcon;
			receiver: aButton;
			selector: #icon:;
			subscribeToDescription: self).
			
	aButton userData
		at: #maLabelHandler put: (GtMagritteDescriptionPropertyChangedHandler new
			key: #label;
			receiver: aButton;
			selector: #label:;
			subscribeToDescription: self).

	^ aButton
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beAlwaysEnabled [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aButton enabled: true ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beDisabledOnActive [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aButton enabled: aStatus isActive not ])
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
					ifTrue: [ aButton enabled: aStatus isInactive ]
					ifFalse: [ aButton enabled: false ] ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beEnabledAndChangedAndValidAndInactiveOverallStatus [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aStatus isChanged
					ifTrue: [ aButton enabled: aStatus isValidAndInactive ]
					ifFalse: [ aButton enabled: false ] ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beEnabledOnChangedOverallStatus [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aStatus isChanged
					ifTrue: [ aButton enabled: true ]
					ifFalse: [ aButton enabled: false ] ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beEnabledOnValidOverallStatus [
	self onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription | 
				aButton enabled: aStatus isValid ])
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beToolbarAction [
	self propertyAt: #beToolbarAction put: true
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> blocEnabled [
	"aBlock with arguments [ :aMemento :aDescription | ].
	aBlock returns boolean values."

	^ self
		propertyAt: #blocEnabled
		ifAbsent: [ [ :aMemento :aDescription | self enableBlock cull: aMemento model ] ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> blocEnabled: aBlock [
	"aBlock with arguments [ :aMemento :aDescription | ].
	aBlock returns boolean values."
	self propertyAt: #blocEnabled put: aBlock
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
