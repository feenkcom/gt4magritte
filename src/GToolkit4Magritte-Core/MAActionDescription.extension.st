Extension { #name : #MAActionDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beCommitAction [
	self propertyAt: #beCommitAction put: true
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> beResetAction [
	self propertyAt: #beResetAction put: true
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> isCommitAction [
	^ self propertyAt: #beCommitAction ifAbsent: [ false ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> isResetAction [
	^ self propertyAt: #beResetAction ifAbsent: [ false ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onErrorAction [
	^ self
		propertyAt: #onErrorAction
		ifAbsent: [ [ :aModel :aButton :aMemento |  ] ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAActionDescription >> onErrorAction: anAction [
	self propertyAt: #onErrorAction put: anAction
]
