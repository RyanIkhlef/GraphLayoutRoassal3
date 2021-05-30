Class {
	#name : #GraphLayout,
	#superclass : #AbstractGraphLayout,
	#category : #'GraphLayout-core'
}

{ #category : #'instance creation' }
GraphLayout class >> on: aCanvas [ 
	super on: aCanvas
]

{ #category : #computing }
GraphLayout >> computeNeighborPositions: aNode [

	| neighbors point |
	neighbors := self neighbors: aNode.
	point := Point x: 0 y: 0.
	neighbors do: [ :node | point := point + node position ].

	^ point
]

{ #category : #computing }
GraphLayout >> deg: aNode [

	| neighbors |
	neighbors := self neighbors: aNode.
	^ neighbors size
]

{ #category : #initialization }
GraphLayout >> draw [

	"Algorithme de dessin inspiré des travaux de William Tutte 'How to draw a Graph' 1963"

	| subSetOfNodes |
	
	subSetOfNodes := self subSetOfNodes.
	"self rearrangeAsCircleGraph: subSetOfNodes."
	self rearrangeRandomly: subSetOfNodes.
	self rearrangeWithBarycentricAlgorithm: subSetOfNodes.
	self rearrangeNodes
]

{ #category : #accessing }
GraphLayout >> neighbors: aNode [
	^ aNode connectedLines.
]

{ #category : #initialization }
GraphLayout >> rearrangeAsCircleGraph: subSetOfNodes [

	" Choix d'une position initiale pour chacun des noeuds du sous ensemble.
	  Pour représenter ces noeuds, nous avons décidé de copier de la représentation d'un graphe circulaire (Voir RSCircleLayout#doExecute: elements) "

	| angle position rad angleIncr center size |
	
	size := subSetOfNodes size.
	
	position := Point x: 0 y: 0.
	rad := size * 11.
	center := Point x: rad y: rad.
	angleIncr := 2 * Float pi / nodes size.
	angle := 0.
	
	subSetOfNodes do: [ :node | 
		| point |
		point := center + (Point r: rad theta: angle).
		angle := angle + angleIncr.
		translator translateTopLeftOf: node to: point ]
]

{ #category : #initialization }
GraphLayout >> rearrangeNodes [

	"Check if two nodes are not too near. If it's true, move one of them"

	nodes do: [ :node | 
		| pos |
		pos := node position.
		nodes do: [ :node2 | 
			| x y |
			node = node2 ifFalse: [ 
				x := pos x - node2 position x.
				y := pos y - node2 position y.
				
				]]]
]

{ #category : #initialization }
GraphLayout >> rearrangeRandomly: subSetOfNodes [

	" Choix d'une position initiale pour chacun des noeuds du sous ensemble.
	 Pour représenter ces noeuds, nous prennons une position x,y aléatoire. "

	| size value |
	
	size := subSetOfNodes size.
	value := (nodes size * 40).
	subSetOfNodes do: [ :node | 
		| point |
		point := (Random new nextBetween: (-1*value) and: value)  @ (Random new nextBetween: (-1*value) and: value). 
		translator translateTopLeftOf: node to: point ]
]

{ #category : #initialization }
GraphLayout >> rearrangeWithBarycentricAlgorithm: subSetOfNodes [

	"Pour chaque sommet on calcule la position du noeud par rapport à ses voisins."

	| position |
	position := Point x: 0 y: 0.

	nodes do: [ :node | 
		(subSetOfNodes includes: node) ifFalse: [
			| deg |
			deg := self deg: node.
			position := deg > 0
				            ifTrue: [ Point x: 1 / deg y: 1 / deg  ]
				            ifFalse: [ Point x: 1 y: 1 ].
			position := position * (self computeNeighborPositions: node).
			translator translateTopLeftOf: node to: position ] ]
]

{ #category : #initialization }
GraphLayout >> subSetOfNodes [

	"Choix d'un sous ensemble de sommet."

	| subSetOfNodes size cpt |
	subSetOfNodes := OrderedCollection new.

	cpt := 1.
	size := nodes size / 2.
	nodes do: [ :node | 
		cpt <= size ifTrue: [ subSetOfNodes addLast: node ].
		cpt := cpt + 1 ].
	
	^ subSetOfNodes
]
