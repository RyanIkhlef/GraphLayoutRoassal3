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
			package: 'GraphLayoutExample';
			package: 'GraphLayoutImpl';
			package: 'MyExample' with:  [ spec requires: #('GraphLayoutImpl') ]]
]
