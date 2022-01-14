Extension { #name : #MACheckedMemento }

{ #category : #'*GToolkit-Magritte' }
MACheckedMemento >> readOriginalUsing: aDescription [

	^ self original at: aDescription
]
