"
Description
--------------------

Abstract superclass of all Seaside components of DBToolkit. 

I provide some conveniance methods to be used during the redering of the components.
"
Class {
	#name : #DBTComponent,
	#superclass : #WAComponent,
	#category : #'DBToolkit-Core'
}

{ #category : #convenience }
DBTComponent >> display: aComponentInstance [
	"Set a component instance as the component to display by the root component."

	self rootComponent componentToDisplay: aComponentInstance
]

{ #category : #convenience }
DBTComponent >> displayInstanceOf: aComponentClass [
	"Set a component class as the component to display by the root component."

	self rootComponent displayInstanceOf: aComponentClass
]

{ #category : #accessing }
DBTComponent >> rootComponent [
	^ self session rootComponent
]
