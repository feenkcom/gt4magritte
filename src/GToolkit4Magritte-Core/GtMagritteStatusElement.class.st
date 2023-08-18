Class {
	#name : #GtMagritteStatusElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtMagritteWithMementoViewModel',
	#classTraits : 'TGtMagritteWithMementoViewModel classTrait',
	#instVars : [
		'labelElement',
		'exceptionContainer'
	],
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #initialization }
GtMagritteStatusElement >> initialize [
	super initialize.

	labelElement := BrLabel new
			visibility: BlVisibility gone;
			aptitude: BrGlamorousLabelAptitude new glamorousCodeTinySize;
			text: '';
			hFitContentLimited;
			vFitContent.
			
	exceptionContainer := BrFrame new
			visibility: BlVisibility gone;
			margin: (BlInsets left: 3);
			hFitContentLimited;
			vFitContent.
			
	self
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :aLabel :aSink | 
					self onExecutionStatusChanged: aSink value ] ].

	self addChild: labelElement.
	self addChild: exceptionContainer.

	self
		hFitContentLimited;
		vFitContent
]

{ #category : #'private - event handling' }
GtMagritteStatusElement >> onExecutionStatusChanged: aGtMagritteExecutionStatus [
	aGtMagritteExecutionStatus updateToolbarLabelExecutionStatus: labelElement.
	aGtMagritteExecutionStatus updateToolbarExceptionExecutionStatus: exceptionContainer
]

{ #category : #'api - memento view model' }
GtMagritteStatusElement >> onPostMementoViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToMementoViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."

	self
		withAsyncSinkDo: [ :anElementSink | 
			self mementoViewModel memento executionStatus observe: anElementSink ]
]
