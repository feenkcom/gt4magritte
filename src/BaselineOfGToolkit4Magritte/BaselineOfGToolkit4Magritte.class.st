Class {
	#name : #BaselineOfGToolkit4Magritte,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Magritte
}

{ #category : #baseline }
BaselineOfGToolkit4Magritte >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'MagritteForGToolkit' with: [
				spec repository: 'github://feenkcom/magritte:v4.0.1/source' ].
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.480/src' ].
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.510/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.626/src' ].

		spec package: 'GToolkit-Magritte-Core' with: [
			spec requires: #('MagritteForGToolkit' 'Brick' 'GToolkitCompleter') ].
		spec package: 'GToolkit-Magritte-Examples' with: [
			spec requires: #('GToolkit-Magritte-Core' 'GToolkitCoder') ].
	]
]
