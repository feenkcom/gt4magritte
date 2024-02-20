Class {
	#name : #GtMagritteToolbarAptitude,
	#superclass : #BrToolbarAptitude,
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #initialization }
GtMagritteToolbarAptitude >> initialize [
	super initialize.
	
	self add: BrLayoutAlignmentAptitude new.	
	self
		addChangeProperty: #(widget layout)
		with: [ BlFlowLayout horizontal ]
]
