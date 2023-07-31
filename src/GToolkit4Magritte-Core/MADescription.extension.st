Extension { #name : #MADescription }

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> announcerSubscriptionsDo: aBlock [
	"Iterates over all subscriptions"

	self
		propertyAt: #announcerSubscriptions
		ifPresent: [ :aCollection | 
			aCollection do: aBlock ]
		ifAbsent: [ "ignore" ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> beAlwaysEditable [

	self propertyAt: #alwaysEditable put: true
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> beWithChangeIndicator [

	self propertyAt: #changeIndicator put: true
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> beWithoutChangeIndicator [

	self propertyAt: #changeIndicator put: false
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> blocStencil [
	<return: #GtMagritteDescriptionElementStencilBuilder or: nil>
	^ self propertyAt: #blocStencil ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> blocStencil: aStencil [
	self
		propertyAt: #blocStencil
		put: (aStencil asStencilBuilder: GtMagritteDescriptionElementStencilBuilder)
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> gtConditionsFor: aView [

	<gtView>
	(self hasProperty: #conditions) ifFalse: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Conditions';
		  priority: 55;
		  items: [ self conditions ];
		  column: 'Valuable' text: #key;
		  column: 'Description' text: #value;
		  send: #key
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> isAlwaysEditable [

	^ self propertyAt: #alwaysEditable ifAbsent: [ false ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> isWithChangeIndicator [

	^ self propertyAt: #changeIndicator ifAbsent: [ true ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> updateDescription: aDescriptionSetterSelector as: aModelValueSelector on: anAnnouncementClass from: anAnnouncerBlock [
	"Update description property (aDescriptionSetterSelector) to a value provided by the memento selector (aModelValueSelector) when the given announcement is propagated.
	
	The aModelValueSelector message is used to get a new model value and must be of zero arguments.
	The aModelValueSelector message is used to update the description property and must be of a one argument.
	
	Note that we force to use Symbol instances to omit memory leaks. All memento subscriptions are weak."

	| aSpecification |
	aSpecification := GtMagritteDescriptionFromModelUpdateSpecification new
			descriptionSetterSelector: aDescriptionSetterSelector;
			modelValueSelector: aModelValueSelector;
			announcementClass: anAnnouncementClass;
			announcerBlock: anAnnouncerBlock.

	self
		propertyAt: #announcerSubscriptions
		ifPresent: [ :aCollection | aCollection add: aSpecification ]
		ifAbsentPut: [ OrderedCollection with: aSpecification ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> updateOn: anAnnouncementClass from: anAnnouncerBlock [
	"Update memento original value (provided by a model) when the given announcement is propagated.
	
	All memento subscriptions are weak."

	| aSpecification |
	aSpecification := GtMagritteDescriptionValueFromModelUpdateSpecification new
		announcementClass: anAnnouncementClass;
		announcerBlock: anAnnouncerBlock.

	self
		propertyAt: #announcerSubscriptions
		ifPresent: [ :aCollection | 
			aCollection add: aSpecification ]
		ifAbsentPut: [ 
			OrderedCollection with: aSpecification ]
]
