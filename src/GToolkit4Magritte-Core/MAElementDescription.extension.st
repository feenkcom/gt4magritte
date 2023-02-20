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
MAElementDescription >> labelStyler [
	^ self propertyAt: #labelStyler ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> labelStyler: aBlock [
	self propertyAt: #labelStyler put: aBlock
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> textStyler [
	^ self propertyAt: #textStyler ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAElementDescription >> textStyler: aBlock [
	self propertyAt: #textStyler put: aBlock
]
