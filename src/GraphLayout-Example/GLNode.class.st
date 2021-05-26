Class {
	#name : #GLNode,
	#superclass : #Object,
	#instVars : [
		'id',
		'matrix'
	],
	#category : #'GraphLayout-Example-utils'
}

{ #category : #setter }
GLNode >> connectedNode [

	matrix adjacentTo: self
]

{ #category : #accessing }
GLNode >> id [

	^ id
]

{ #category : #accessing }
GLNode >> id: anObject [

	id := anObject
]

{ #category : #accessing }
GLNode >> matrix: anObject [

	matrix := anObject
]
