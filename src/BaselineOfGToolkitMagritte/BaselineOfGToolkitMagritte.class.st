Class {
	#name : #BaselineOfGToolkitMagritte,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitMagritte
}

{ #category : #accessing }
BaselineOfGToolkitMagritte class >> gtDependencyAnalysisPreloadedBaselines [

	^ super gtDependencyAnalysisPreloadedBaselines copyWith:
		  BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfGToolkitMagritte >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Magritte'
			with: [ spec repository: 'github://magritte-metamodel/magritte:efbb0333a9550d153c6299177546234003cce2a8/source' ]. 

		spec
			package: 'GToolkit-Magritte'
			with: [ spec requires: #( Magritte ) ] ]
]
