Class {
	#name : #AbstractGraphLayout,
	#superclass : #RSAbstractGraphLayout,
	#instVars : [
		'nodes',
		'alreadyLayoutedNodes'
	],
	#category : #'GraphLayout-core'
}

{ #category : #'instance creation' }
AbstractGraphLayout class >> on: aCanvas [ 
	| instance |
	instance := self new.
	instance nodes: aCanvas nodes.
	instance executeOnElements: aCanvas nodes.
]

{ #category : #initialization }
AbstractGraphLayout >> doExecute: elements [

	self draw
]

{ #category : #initialization }
AbstractGraphLayout >> doPost: elements [

	alreadyLayoutedNodes := OrderedCollection new
]

{ #category : #initialization }
AbstractGraphLayout >> draw [

	self subclassResponsibility
]

{ #category : #initialization }
AbstractGraphLayout >> initialize [
	super initialize.
	alreadyLayoutedNodes ifNil: [ alreadyLayoutedNodes := OrderedCollection new. ]. 


]

{ #category : #accessing }
AbstractGraphLayout >> nodes [
	^ nodes
]

{ #category : #accessing }
AbstractGraphLayout >> nodes: aRSGroup [
	nodes := aRSGroup.
]
