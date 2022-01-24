Extension { #name : #MABooleanDescription }

{ #category : #'*GToolkit-Magritte-Core' }
MABooleanDescription >> blocActionString [

	^ self propertyAt: #blocActionString ifAbsent: [ '' ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MABooleanDescription >> blocActionString: aString [

	self propertyAt: #blocActionString put: aString
]

{ #category : #'*GToolkit-Magritte-Core' }
MABooleanDescription >> blocUseDropdown [

	^ self
		  propertyAt: #blocUseDropdown
		  ifPresent: [ :aBoolean | 
		  	aBoolean and: [ self blocActionString isNotEmpty ] ]
		  ifAbsent: [ false ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MABooleanDescription >> blocUseDropdown: aBoolean [

	self propertyAt: #blocUseDropdown put: aBoolean
]
