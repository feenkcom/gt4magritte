Class {
	#name : #GtMagritteBasicAction,
	#superclass : #Object,
	#instVars : [
		'action'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #accessing }
GtMagritteBasicAction >> action [
	^ action
]

{ #category : #accessing }
GtMagritteBasicAction >> action: anObject [
	action := anObject
]

{ #category : #'private - execution' }
GtMagritteBasicAction >> actionExecutor [
	^ GtMagritteBasicActionExecutor new
]

{ #category : #evaluating }
GtMagritteBasicAction >> cull: anObject cull: anElement cull: aMemento cull: aDescription [
	self actionExecutor 
		action: self;
		object: anObject;
		element: anElement;
		memento: aMemento;
		description: aDescription;
		execute
]
