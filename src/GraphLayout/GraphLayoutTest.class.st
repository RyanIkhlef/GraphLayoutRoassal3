Class {
	#name : #GraphLayoutTest,
	#superclass : #TestCase,
	#category : #'GraphLayout-test'
}

{ #category : #tests }
GraphLayoutTest >> before [

	| canvas matrix layout |
	canvas := RSCanvas new @ RSCanvasController.
	matrix := self setupData.

	canvas addAll: (matrix nodes collect: [ :node | 
			 RSBox new
				 model: node;
				 draggable;
				 popup ]).

	RSEdgeBuilder line
		shapes: canvas nodes;
		connectToAll: [ :node | matrix adjacentTo: node ].

		
	layout := GraphLayout new.
	layout nodes: canvas nodes.
	^ layout
]

{ #category : #tests }
GraphLayoutTest >> setupData [

	| data |
	data := Dictionary new.
	data
		at: 1 put: { 2 };
		at: 2 put: { 4 };
		at: 3 put: { 5. 4. 6 };
		at: 4 put: { 2 };
		at: 5 put: {  };
		at: 6 put: { 1 }.

	^ GLMatrix new data: data
]

{ #category : #tests }
GraphLayoutTest >> testDraw [
	
	| layout |
	layout := self before.

	layout nodes do: [ :each | self assert: each position equals: 0 @ 0 ].

	layout draw.

	layout nodes do: [ :each | 
		self assert: each position ~= (0 @ 0) equals: true ] " A améliorer." 
]

{ #category : #tests }
GraphLayoutTest >> testRearrangeAsCircleGraph [

	| layout |
	layout := self before.

	layout nodes do: [ :each | self assert: each position equals: 0 @ 0 ].

	layout rearrangeAsCircleGraph: layout nodes.

	layout nodes do: [ :each | 
		self assert: (each position ~= (0 @ 0)) equals: true ] " A améliorer."
]

{ #category : #tests }
GraphLayoutTest >> testRearrangeWithBarycentricAlgorithm [

	| layout subSetOfNodes |
	layout := self before.

	layout nodes do: [ :each | self assert: each position equals: 0 @ 0 ].

	subSetOfNodes := layout subSetOfNodes.
	
	layout rearrangeAsCircleGraph: subSetOfNodes.
	layout rearrangeWithBarycentricAlgorithm: subSetOfNodes.

	layout nodes do: [ :each | 
		self assert: each position ~= (0 @ 0) equals: true ] " A améliorer." 
]

{ #category : #tests }
GraphLayoutTest >> testSubSetOfNodes [

	| layout subSetOfNodes |
	layout := self before.
	subSetOfNodes := layout subSetOfNodes.

	self assert: subSetOfNodes size equals: 3
]
