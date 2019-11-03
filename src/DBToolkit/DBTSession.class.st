"
Description
--------------------

Simple session for the DBToolkit. I save the root component to help with the application management. Each components will be able to access the root component via myself.

Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	rootComponent:		<aComponent>		The root component of the demo. Should be an instance of the root component of the application.

"
Class {
	#name : #DBTSession,
	#superclass : #WASession,
	#instVars : [
		'rootComponent'
	],
	#category : #'DBToolkit-Core'
}

{ #category : #accessing }
DBTSession >> rootComponent [
	^ rootComponent
]

{ #category : #accessing }
DBTSession >> rootComponent: aRootComponent [
	rootComponent := aRootComponent
]
