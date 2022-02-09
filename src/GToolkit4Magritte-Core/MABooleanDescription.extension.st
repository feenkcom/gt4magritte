Extension { #name : #MABooleanDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MABooleanDescription >> blocActionString [

	^ self propertyAt: #blocActionString ifAbsent: [ '' ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MABooleanDescription >> blocActionString: aString [

	self propertyAt: #blocActionString put: aString
]

{ #category : #'*GToolkit4Magritte-Core' }
MABooleanDescription >> blocUseDropdown [

	^ self
		  propertyAt: #blocUseDropdown
		  ifPresent: [ :aBoolean | 
		  	aBoolean and: [ self blocActionString isNotEmpty ] ]
		  ifAbsent: [ false ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MABooleanDescription >> blocUseDropdown: aBoolean [

	self propertyAt: #blocUseDropdown put: aBoolean
]

{ #category : #'*GToolkit4Magritte-Core' }
MABooleanDescription >> hasCustomLabels [

	^ (self hasProperty: #trueString) or: [ 
		  self hasProperty: #falseString ]
]
