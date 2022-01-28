Class {
	#name : #GtMagritteDummyModelWithBrokenDescription,
	#superclass : #Object,
	#instVars : [
		'value',
		'comment'
	],
	#category : #'GToolkit-Magritte-Examples-Support'
}

{ #category : #accessing }
GtMagritteDummyModelWithBrokenDescription >> comment [

	^ comment
]

{ #category : #accessing }
GtMagritteDummyModelWithBrokenDescription >> comment: anObject [

	comment := anObject
]

{ #category : #accessing }
GtMagritteDummyModelWithBrokenDescription >> descriptionComment [

	<magritteDescription>
	^ MAStringDescription new
		  label: 'Comment';
		  priority: 2;
		  accessor: #comment;
		  default: 'This is a defaut comment';
		  beOptional
]

{ #category : #accessing }
GtMagritteDummyModelWithBrokenDescription >> descriptionValue [

	<magritteDescription>
	^ MAStringDescription new
		  label: 'Label';
		  priority: 1;
		  accessor: #value;
		  default: 'This is defaut value';
		  notImplementedMthod;
		  beRequiered
]

{ #category : #accessing }
GtMagritteDummyModelWithBrokenDescription >> value [

	^ value
]

{ #category : #accessing }
GtMagritteDummyModelWithBrokenDescription >> value: anObject [

	value := anObject
]
