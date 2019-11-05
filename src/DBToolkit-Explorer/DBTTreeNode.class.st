Class {
	#name : #DBTTreeNode,
	#superclass : #Object,
	#instVars : [
		'name',
		'children'
	],
	#category : #'DBToolkit-Explorer'
}

{ #category : #accessing }
DBTTreeNode >> children [
	^ children
]

{ #category : #accessing }
DBTTreeNode >> children: anObject [
	children := anObject
]

{ #category : #accessing }
DBTTreeNode >> name [
	^ name
]

{ #category : #accessing }
DBTTreeNode >> name: anObject [
	name := anObject
]
