Class {
	#name : #GLExample,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'matrix'
	],
	#category : #'GraphLayout-Example-example'
}

{ #category : #examples }
GLExample class >> exampleWithGraphData1 [

	self new
		matrix: GLMatrix graphData1;
		open
]

{ #category : #examples }
GLExample class >> exampleWithGraphData2 [

	self new
		matrix: GLMatrix graphData2;
		open
]

{ #category : #examples }
GLExample class >> exampleWithGraphData3 [

	self new
		matrix: GLMatrix graphData3;
		open
]

{ #category : #examples }
GLExample class >> exampleWithGraphData4 [

	self new
		matrix: GLMatrix graphData4;
		open
]

{ #category : #examples }
GLExample class >> exampleWithGraphDataFriendList [

	self new
		matrix: GLMatrix graphDataFriendList;
		open
]

{ #category : #examples }
GLExample class >> exampleWithGraphDataLargeSize [

	self new
		matrix: GLMatrix graphDataLargeSize;
		open
]

{ #category : #examples }
GLExample class >> exampleWithGraphDataLittleSize [

	self new
		matrix: GLMatrix graphDataLittleSize;
		open
]

{ #category : #examples }
GLExample class >> exampleWithGraphDataMediumSize [

	self new
		matrix: GLMatrix graphDataMediumSize;
		open
]

{ #category : #initialization }
GLExample >> build [

	self buildNodes.
	self connectNodes.
	self setLayout
]

{ #category : #initialization }
GLExample >> buildNode: class [

	^ RSBox new
		  model: class;
		  draggable;
		  popup;
		  yourself
]

{ #category : #initialization }
GLExample >> buildNodes [

	canvas addAll:
		(matrix nodes collect: [ :node | self buildNode: node ]).
	
]

{ #category : #initialization }
GLExample >> connectNodes [

	RSEdgeBuilder line
		shapes: canvas nodes;
		connectToAll: [ :node | matrix adjacentTo: node ]
]

{ #category : #initialization }
GLExample >> initialize [
	super initialize.
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
]

{ #category : #initialization }
GLExample >> matrix: aGLEMatrix [
	matrix := aGLEMatrix 
	
]

{ #category : #initialization }
GLExample >> open [
	self build.
	canvas open
]

{ #category : #initialization }
GLExample >> setLayout [
	GraphLayout on: canvas
]
