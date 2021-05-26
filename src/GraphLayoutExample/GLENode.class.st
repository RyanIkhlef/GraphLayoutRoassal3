Class {
	#name : #GLENode,
	#superclass : #Object,
	#instVars : [
		'id',
		'matrix'
	],
	#category : #GraphLayoutExample
}

{ #category : #'as yet unclassified' }
GLENode >> connectedNode [

	matrix adjacentTo: self
]

{ #category : #accessing }
GLENode >> id [

	^ id
]

{ #category : #accessing }
GLENode >> id: anObject [

	id := anObject
]

{ #category : #accessing }
GLENode >> matrix: anObject [

	matrix := anObject
]
