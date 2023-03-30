Class {
	#name : #BaselineOfGToolkit4Magritte,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Magritte
}

{ #category : #baselines }
BaselineOfGToolkit4Magritte >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'MagritteForGToolkit'
			with: [ 
			spec repository: 'github://feenkcom/magritte:feenk/source' ].

		spec
			baseline: 'Brick'
			with: [ spec repository: 'github://feenkcom/Brick:main/src' ].

		spec
			baseline: 'GToolkitCompleter'
			with: [ 
				spec repository: 'github://feenkcom/gtoolkit-completer:main/src' ].

		spec 
			baseline: 'GToolkitCoder' 
			with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:main/src' ].

		spec
			package: 'GToolkit4Magritte-Core'
			with: [ 
				spec requires: #( 'MagritteForGToolkit' 'Brick' 'GToolkitCompleter' ) ].
				
		spec
			package: 'GToolkit4Magritte-Examples'
			with: [ spec requires: #( 'GToolkit4Magritte-Core' 'GToolkitCoder' ) ] ]
]
