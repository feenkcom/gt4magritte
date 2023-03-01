Extension { #name : #MAElementDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> blocCompletion [

	^ self propertyAt: #blocCompletion ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> blocCompletion: aStrategyStencil [

	self propertyAt: #blocCompletion put: (aStrategyStencil asStencilBuilder: GtMagritteCompletionStrategyStencilBuilder)
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> blocShortcuts [

	^ self propertyAt: #blocShortcuts ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> blocShortcuts: aCollectionOfShortcuts [

	self propertyAt: #blocShortcuts put: aCollectionOfShortcuts
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> editorAptitude [
	^ self propertyAt: #editorAptitude ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> editorAptitude: aBlock [
	self propertyAt: #editorAptitude put: aBlock
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ | form memento stencil |
			form := BrFrame new fitContent.
			memento := GtMagritteMemento new
					setDescription: self asContainer;
					reset.
			form userData at: #gtmemento put: memento.

			stencil := memento magritteDescription blocElementContainerStencil
					asStencilBuilder: GtMagritteFormStencilBuilder.

			form
				addChild: (stencil
						memento: memento;
						asElement).
			GtMagritteElementBuilder new
				form: form;
				memento: memento;
				build.
			form ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> labelAptitude [
	^ self propertyAt: #labelAptitude ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> labelAptitude: aBlock [
	self propertyAt: #labelAptitude put: aBlock
]
