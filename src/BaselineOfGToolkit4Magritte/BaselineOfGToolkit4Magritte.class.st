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
				spec repository: 'github://feenkcom/magritte:v4.0.17/source' ].
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.1278/src' ].
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.1330/src' ].
		spec
			baseline: 'GToolkitBasicUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.325/src' ].

		spec package: 'GToolkit4Magritte-Core' with: [
			spec requires: #('MagritteForGToolkit' 'Brick' 'GToolkitCompleter' 'GToolkitBasicUtility') ].
		spec package: 'GToolkit4Magritte-Examples' with: [
			spec requires: #('GToolkit4Magritte-Core') ].
	]
]
