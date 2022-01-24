Class {
	#name : #BaselineOfGToolkit4Magritte,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Magritte
}

{ #category : #accessing }
BaselineOfGToolkit4Magritte class >> gtDependencyAnalysisPreloadedBaselines [

	^ super gtDependencyAnalysisPreloadedBaselines copyWith:
		  BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfGToolkit4Magritte >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'MagritteForGToolkit'
			with: [ spec repository: 'github://feenkcom/magritte:feenk01/source' ]. 

		spec
			package: 'GToolkit-Magritte'
			with: [ spec requires: #( 'MagritteForGToolkit' ) ] ]
]
