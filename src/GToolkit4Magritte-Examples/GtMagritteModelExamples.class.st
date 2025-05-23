Class {
	#name : #GtMagritteModelExamples,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Examples-Core'
}

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressObject [
	<gtExample>
	<return: #GtMagritteDummyPostalAddress>
	| anAddress |
	anAddress := self basicAddressObject.

	anAddress
		street: 'Husova 108/12';
		city: 'Všetín';
		zipCode: 75501.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressObjectWithCallbacks [
	<gtExample>
	<return: #GtMagritteDummyPostalAddressWithCallbacks>
	| anAddress |
	anAddress := self basicAddressObjectWithCallbacks.

	anAddress
		street: 'Husova 108/12';
		city: 'Všetín';
		zipCode: 75501.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressObjectWithoutCancel [
	<gtExample>
	<return: #GtMagritteDummyPostalAddressWithoutCancel>
	| anAddress |
	anAddress := self basicAddressObjectWithoutCancel.

	anAddress
		street: 'Husova 108/12';
		city: 'Všetín';
		zipCode: 75501.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressTwoObject [
	<gtExample>
	<return: #GtMagritteDummyPostalAddress>
	| anAddress |
	anAddress := self basicAddressObject.

	anAddress
		street: 'Básníkova 72/21';
		city: 'Hodonín'.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> basicAddressObject [
	<gtExample>
	<return: #GtMagritteDummyPostalAddress>
	| anAddress |
	anAddress := GtMagritteDummyPostalAddress new.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> basicAddressObjectWithCallbacks [
	<gtExample>
	<return: #GtMagritteDummyPostalAddressWithCallbacks>
	| anAddress |
	anAddress := GtMagritteDummyPostalAddressWithCallbacks new.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> basicAddressObjectWithoutCancel [
	<gtExample>
	<return: #GtMagritteDummyPostalAddressWithoutCancel>
	| anAddress |
	anAddress := GtMagritteDummyPostalAddressWithoutCancel new.

	^ anAddress
]

{ #category : #'examples - broken object' }
GtMagritteModelExamples >> basicBrokenObject [
	<gtExample>
	<return: #GtMagritteDummyModelWithBrokenDescription>
	| anObject |
	anObject := GtMagritteDummyModelWithBrokenDescription new.

	self assert: anObject value isNil.

	^ anObject
]

{ #category : #'examples - person' }
GtMagritteModelExamples >> basicPersonObject [
	<gtExample>
	<return: #GtMagritteDummyPerson>
	| aPerson |
	aPerson := GtMagritteDummyPerson new.

	self assert: aPerson name isNil.
	self assert: aPerson addresses isEmpty.

	^ aPerson
]

{ #category : #'examples - person' }
GtMagritteModelExamples >> basicPersonWithExtraActionsObject [
	<gtExample>
	<return: #GtMagritteDummyPersonWithExtraActions>
	| aPerson |
	aPerson := GtMagritteDummyPersonWithExtraActions new.

	self assert: aPerson name isNil.
	self assert: aPerson addresses isEmpty.

	^ aPerson
]

{ #category : #'examples - server\t' }
GtMagritteModelExamples >> basicServerObject [
	<gtExample>
	<return: #GtMagritteDummyServer>
	| server |
	server := GtMagritteDummyServer new.

	self assert: server name isNotNil description: 'Name must be non-nil'.
	self assert: server port isNotNil description: 'Port must be non-nil'.
	self assert: server port isInteger description: 'Port must be an integer'.
	self assert: server status isNotNil description: 'Status must be non-nil'.
	self
		assert: server readOnlyMode isNotNil
		description: 'Ready-only mode must be non-nil'.
	self
		assert: server readOnlyMode isBoolean
		description: 'Ready-only mode must be a boolean'.

	^ server
]

{ #category : #'examples - broken object' }
GtMagritteModelExamples >> brokenObject [
	<gtExample>
	<return: #GtMagritteDummyModelWithBrokenDescription>
	| anObject |
	anObject := self basicBrokenObject.
	anObject value: 'I have a value'.
	anObject comment: 'I have a comment'.

	self assert: anObject value equals: 'I have a value'.
	self assert: anObject comment equals: 'I have a comment'.

	^ anObject
]

{ #category : #'examples - person' }
GtMagritteModelExamples >> personObjectWithTwoAddresses [
	<gtExample>
	<return: #GtMagritteDummyPerson>
	| aPerson anAddressOne anAddressTwo |
	aPerson := self basicPersonObject.

	aPerson name: 'Adélka'.
	anAddressOne := self primaryAddressObject.
	anAddressTwo := self addressTwoObject.
	aPerson
		addresses: {anAddressOne.
				anAddressTwo}.

	self assert: aPerson name equals: 'Adélka'.
	self assert: aPerson addresses size equals: 2.

	^ aPerson
]

{ #category : #'examples - person' }
GtMagritteModelExamples >> personWithExtraActionsObject [
	<gtExample>
	<return: #GtMagritteDummyPersonWithExtraActions>
	| aPerson |
	aPerson := self basicPersonWithExtraActionsObject.

	aPerson name: 'Adélka'.

	self assert: aPerson name equals: 'Adélka'.
	self assert: aPerson addresses size equals: 0.

	^ aPerson
]

{ #category : #'examples - person' }
GtMagritteModelExamples >> personWithExtraActionsObjectWithTwoAddresses [
	<gtExample>
	<return: #GtMagritteDummyPersonWithExtraActions>
	| aPerson anAddressOne anAddressTwo |
	aPerson := self basicPersonWithExtraActionsObject.

	aPerson name: 'Adélka'.
	anAddressOne := self primaryAddressObject.
	anAddressTwo := self addressTwoObject.
	aPerson
		addresses: {anAddressOne.
				anAddressTwo}.

	self assert: aPerson name equals: 'Adélka'.
	self assert: aPerson addresses size equals: 2.

	^ aPerson
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> primaryAddressObject [
	<gtExample>
	<return: #GtMagritteDummyPostalAddress>
	| anAddress |
	anAddress := self addressObject.

	anAddress isPrimary: true.

	^ anAddress
]

{ #category : #'examples - simple address' }
GtMagritteModelExamples >> simpleAddressDescription [
	<gtExample>
	<return: #MAPriorityContainer>
	^ MAPriorityContainer
		withAll: {MAStringDescription new
					accessor: (MADictionaryAccessor key: #street);
					comment: 'Street name and number';
					addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
						labelled: 'Street must be non empty';
					addCondition: [ :aValue | (aValue select: [ :e | e isDigit ]) isNotEmpty ]
						labelled: 'Street must include street number'.
				MAStringDescription new
					accessor: (MADictionaryAccessor key: #city);
					comment: 'City name';
					beRequired;
					addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
						labelled: 'City must be non empty';
					addCondition: [ :aValue | aValue allSatisfy: [ :each | each isLetter or: [ each isSeparator ] ] ]
						labelled: 'City must include letters only'}
]

{ #category : #'examples - simple address' }
GtMagritteModelExamples >> simpleAddressObject [
	<gtExample>
	<return: #Dictionary>
	^ {#street -> 'Werkstrasse 18'.
		#city -> 'Chamoille'} asDictionary
]

{ #category : #'examples - simple baseline' }
GtMagritteModelExamples >> simpleBaselineObject [
	<gtExample>
	<return: #Dictionary>
	^ {#baseline -> 'BaselineOfMyProject'} asDictionary
]

{ #category : #'examples - simple baselines' }
GtMagritteModelExamples >> simpleBaselinesObject [
	<gtExample>
	<return: #Dictionary>
	^ {#baselines
			-> {'BaselineOfOne'.
					'BaselineOfTwo'.
					'BaselineOfThree'}} asDictionary
]

{ #category : #'examples - directory' }
GtMagritteModelExamples >> simpleDirectoryDescription [
	<gtExample>
	<return: #MAPriorityContainer>
	^ MAPriorityContainer
		withAll: {MADirectoryDescription new
					label: 'Directory';
					kind: AbstractFileReference;
					display: #printString;
					accessor: (MADictionaryAccessor key: #directory);
					beRequired;
					addCondition: [ :aFileReference | aFileReference asFileReference exists ]
						labelled: 'Directory must exist';
					comment: 'Directory name'}
]

{ #category : #'examples - directory' }
GtMagritteModelExamples >> simpleDirectoryObject [
	<gtExample>
	<return: #Dictionary>
	^ {#directory -> (FileLocator imageDirectory / 'pharo-local')} asDictionary
]

{ #category : #'examples - simple address' }
GtMagritteModelExamples >> simpleInvalidAddressObject [
	<gtExample>
	<return: #Dictionary>
	^ {#street -> 'Werkstrasse'.
		#city -> '345 01 Chamoille'} asDictionary
]

{ #category : #'examples - simple password' }
GtMagritteModelExamples >> simplePasswordDescription [
	<gtExample>
	<return: #MAPriorityContainer>
	^ MAPriorityContainer
		withAll: {MAStringDescription new
					label: 'ID';
					beReadOnly;
					accessor: (MADictionaryAccessor key: #id).
				MAStringDescription new
					label: 'Login';
					accessor: (MADictionaryAccessor key: #login).
				MAPasswordDescription new
					label: 'Password';
					accessor: (MADictionaryAccessor key: #password)}
]

{ #category : #'examples - simple password' }
GtMagritteModelExamples >> simplePasswordObject [
	<gtExample>
	<return: #Dictionary>
	^ Dictionary new
		at: 'id' put: '1233232';
		at: 'login' put: 'joe';
		at: 'password' put: 'secret password';
		yourself
]
