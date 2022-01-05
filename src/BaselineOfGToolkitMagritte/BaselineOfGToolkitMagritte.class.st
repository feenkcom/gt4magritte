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
			with: [ spec repository: 'github://feenkcom/magritte:feenk01/source' ]. 

		spec
			package: 'GToolkit-Magritte'
			with: [ spec requires: #( Magritte ) ] ]
]
