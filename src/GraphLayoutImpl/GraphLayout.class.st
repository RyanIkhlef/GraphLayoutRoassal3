Class {
	#name : #GraphLayout,
	#superclass : #AbstractGraphLayout,
	#instVars : [
		'debugIndex'
	],
	#category : #GraphLayoutImpl
}

{ #category : #'instance creation' }
GraphLayout class >> on: aCanvas [ 
	super on: aCanvas
]

{ #category : #'as yet unclassified' }
GraphLayout >> computeNeighborPositions: aNode [

	| neighbors point |
	neighbors := self neighbors: aNode.
	point := Point x: 0 y: 0.
	neighbors do: [ :node | point := point + node position ].

	^ point
]

{ #category : #'as yet unclassified' }
GraphLayout >> deg: aNode [

	| neighbors |
	neighbors := self neighbors: aNode.
	^ neighbors size
]

{ #category : #initialization }
GraphLayout >> draw [

	"Algorithme de dessin inspiré des travaux de William Tutte 'How to draw a Graph' 1963"

	| position sousEnsemble cpt size rad center angleIncr angle |
	"Choix d'un sous ensemble de sommet."
	sousEnsemble := OrderedCollection new.
	cpt := 1.
	size := nodes size / 2.
	nodes do: [ :node | 
		cpt <= size ifTrue: [ sousEnsemble addLast: node ].
		cpt := cpt + 1 ].

	" Choix d'une position initiale pour chacun des noeuds du sous ensemble.
	  Pour représenter ces noeuds, nous avons décidé de copier de la représentation d'un graphe circulaire (Voir RSCircleLayout#doExecute: elements) "
	position := Point x: 0 y: 0.
	rad := size * 11.
	center := Point x: rad y: rad.
	angleIncr := 2 * Float pi / nodes size.
	angle := 0.

	sousEnsemble do: [ :node | 
		| point |
		point := center + (Point r: rad theta: angle).
		angle := angle + angleIncr.
		translator translateTopLeftOf: node to: point ].

	"Pour chaque sommet on calcule la position du noeud par rapport à ses voisins."
	position := Point x: 0 y: 0.

	nodes do: [ :node | 
		(sousEnsemble includes: node) ifFalse: [ 
			| deg |
			deg := self deg: node.
			position := deg > 0
				            ifTrue: [ Point x: 1 / deg y: 1 / deg ]
				            ifFalse: [ Point x: 1 y: 1 ].
			position := position * (self computeNeighborPositions: node).
			translator translateTopLeftOf: node to: position ] ]
	
	"Correction des noeuds proches ?"
	"self rearrangeNodes"
]

{ #category : #'as yet unclassified' }
GraphLayout >> neighbors: aNode [
	^ aNode connectedLines.
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
				((x <= 30 and: x > 0) and: (y <= 30 and: y > 0))
					ifTrue: [ 
					translator translateTopLeftOf: node2 to: node2 position - 30 ]
					ifFalse: [ 
						((x < 0 and: x >= -30) and: (y < 0 and: y >= -30)) ifTrue: [ 
							translator translateTopLeftOf: node to: pos + 30 ] ] ] ] ]
]
