Class {
	#name : #MyExample,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'matrix'
	],
	#category : #MyExample
}

{ #category : #initialization }
MyExample >> build [

	self buildNodes.
	self connectNodes.
	self setLayout
]

{ #category : #initialization }
MyExample >> buildNode: class [

	^ RSBox new
		  model: class;
		  draggable;
		  popup;
		  yourself
]

{ #category : #initialization }
MyExample >> buildNodes [

	canvas addAll:
		(matrix nodes collect: [ :node | self buildNode: node ]).
	
]

{ #category : #initialization }
MyExample >> connectNodes [

	RSEdgeBuilder line
		shapes: canvas nodes;
		connectToAll: [ :node | matrix adjacentTo: node ]
]

{ #category : #initialization }
MyExample >> initialize [
	super initialize.
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
]

{ #category : #initialization }
MyExample >> matrix: aGLEMatrix [
	matrix := aGLEMatrix 
	
]

{ #category : #initialization }
MyExample >> open [
	self build.
	canvas open
]

{ #category : #initialization }
MyExample >> setLayout [
	GraphLayout on: canvas
]
