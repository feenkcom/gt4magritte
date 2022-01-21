Class {
	#name : #GtMagritteFieldWithValidationErrorsElement,
	#superclass : #BlElement,
	#traits : 'TGtMagritteWithFieldViewModel + TBrLayoutResizable',
	#classTraits : 'TGtMagritteWithFieldViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'issuesElement',
		'fieldElement',
		'issuesUpdater',
		'fieldValueUpdater'
	],
	#category : #'GToolkit-Magritte-FirstImplementation'
}

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsElement >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #'private - accessing' }
GtMagritteFieldWithValidationErrorsElement >> fieldElement [

	^ fieldElement
]

{ #category : #'private - accessing' }
GtMagritteFieldWithValidationErrorsElement >> fieldElementChildDo: aBlock [

	| anElement |
	self fieldElement hasChildren ifFalse: [ ^ self ].

	anElement := self fieldElement childAt: 1.

	aBlock cull: anElement
]

{ #category : #initialization }
GtMagritteFieldWithValidationErrorsElement >> initialize [

	super initialize.

	fieldValueUpdater := BrElementUpdater new
		                 element: self
		                 selector: #updateFieldElementValue.
	issuesUpdater := BrElementUpdater new
		                 element: self
		                 selector: #updateIssuesElement.

	fieldElement := BrFrame new
		                hFitContentLimited;
		                vFitContent.

	issuesElement := BrEditor new
		                 aptitude: (BrGlamorousRegularEditorAptitude new
				                  glamorousRegularFont;
				                  glamorousCodeSmallSize;
				                  foreground: BrGlamorousColors errorBackgroundColor);
		                 beReadOnlyWithSelection;
		                 hFitContentLimited;
		                 vFitContent;
		                 text: '';
		                 visibility: BlVisibility gone.

	self addChild: fieldElement as: #field.
	self addChild: issuesElement as: #issues.
	
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: fieldElement).

	self hFitContentLimited.
	self vFitContent
]

{ #category : #'private - accessing' }
GtMagritteFieldWithValidationErrorsElement >> issuesElement [

	^ issuesElement
]

{ #category : #'private - announcement handling' }
GtMagritteFieldWithValidationErrorsElement >> onCanceled: anAnnouncement [

	issuesUpdater requestUpdate.
	fieldValueUpdater requestUpdate.
]

{ #category : #'api - field view model' }
GtMagritteFieldWithValidationErrorsElement >> onFieldViewModelChanged [
	"Is sent when a new fieldViewModel is assigned to the receiver.
	Note: #onFieldViewModelChanged is sent before #subscribeToFieldViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostFieldViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self updateElement
]

{ #category : #'private - announcement handling' }
GtMagritteFieldWithValidationErrorsElement >> onValidatedAndAccepted: anAnnouncement [

	issuesUpdater requestUpdate.
	fieldValueUpdater requestUpdate.
]

{ #category : #'private - announcement handling' }
GtMagritteFieldWithValidationErrorsElement >> onValidationErrorsChanged: anAnnouncement [

	issuesUpdater requestUpdate
]

{ #category : #'api - field view model' }
GtMagritteFieldWithValidationErrorsElement >> subscribeToFieldViewModel [

	"Is sent after a new fieldViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromFieldViewModel if the receiver subscribes to them"

	<objectSubscriber: #fieldViewModel>
	<generatedFrom:
	#'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	self fieldViewModel weak
		when: GtMagritteValidationErrorsChanged
		send: #onValidationErrorsChanged:
		to: self;
		when: GtMagritteValidatedAndAcceptedAnnouncement
		send: #onValidatedAndAccepted:
		to: self;
		when: GtMagritteCanceledAnnouncement send: #onCanceled: to: self
]

{ #category : #'api - field view model' }
GtMagritteFieldWithValidationErrorsElement >> unsubscribeFromFieldViewModel [
	"Is sent before a new fieldViewModel is assigned to the receiver.
	Objects that subscribe to fieldViewModel are required to implement this method."
	<objectUnsubscriber: #fieldViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self fieldViewModel unsubscribe: self.
]

{ #category : #'private - updating' }
GtMagritteFieldWithValidationErrorsElement >> updateElement [
	
	self updateFieldElement.
	self updateIssuesElement.
]

{ #category : #'private - updating' }
GtMagritteFieldWithValidationErrorsElement >> updateFieldElement [

	self fieldElement enqueueTask: (BlTaskAction new action: [ 
			 | anElement |
			 self hasFieldViewModel ifTrue: [ 
				 anElement := self fieldViewModel fieldStencil asElement.
				 self fieldElement
					 removeChildren;
					 addChild: anElement ] ])
]

{ #category : #'private - updating' }
GtMagritteFieldWithValidationErrorsElement >> updateFieldElementValue [

	self fieldElementChildDo: [ :anElement | 
		anElement dispatchEvent:
			(GtMagritteValueUpdateWish new value: self fieldViewModel currentValue) ]
]

{ #category : #'private - updating' }
GtMagritteFieldWithValidationErrorsElement >> updateIssuesElement [

	self hasFieldViewModel ifFalse: [ 
		self issuesElement text: ''.
		self issuesElement visibility: BlVisibility gone.
		^ self ].
	self fieldViewModel hasIssues ifFalse: [ 
		self issuesElement text: ''.
		self issuesElement visibility: BlVisibility gone.
		^ self ].


	self issuesElement visibility: BlVisibility visible.
	self issuesElement text: self fieldViewModel issuesText
]
