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
				spec repository: 'github://feenkcom/magritte:v4.0.11/source' ].
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.979/src' ].
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.1027/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.1312/src' ].

		spec package: 'GToolkit4Magritte-Core' with: [
			spec requires: #('MagritteForGToolkit' 'Brick' 'GToolkitCompleter') ].
		spec package: 'GToolkit4Magritte-Examples' with: [
			spec requires: #('GToolkit4Magritte-Core' 'GToolkitCoder') ].
	]
]
