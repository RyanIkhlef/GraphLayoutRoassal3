Class {
	#name : #BaselineOfGraphLayout,
	#superclass : #BaselineOf,
	#category : #BaselineOfGraphLayout
}

{ #category : #baselines }
BaselineOfGraphLayout >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'GraphLayout';
			package: 'GraphLayout-Example'
			with: [ spec requires: #( 'GraphLayout' ) ] ]
]
