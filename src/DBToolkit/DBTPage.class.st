"
Description
--------------------

I am an abstract component. My subclasses represent the main pages of the application.

Each page should have a name that will be used in the URLs and a priority for the menus.
"
Class {
	#name : #DBTPage,
	#superclass : #DBTComponent,
	#category : #'DBToolkit-Core'
}

{ #category : #testing }
DBTPage class >> isAbstract [
	^ self = DBTPage
]

{ #category : #accessing }
DBTPage class >> pageName [
	"Title of the page that will be used in menus and URLs."

	^ self subclassResponsibility
]

{ #category : #accessing }
DBTPage class >> pagesToDisplay [
	^ (self allSubclasses reject: #isAbstract) sorted: #priority ascending
]

{ #category : #accessing }
DBTPage class >> pathName [
	"Use to define the URL name"

	^ self pageName copyWithout: $  
]

{ #category : #accessing }
DBTPage class >> priority [
	^ self subclassResponsibility
]

{ #category : #accessing }
DBTPage >> pathName [
	^ self class pathName
]
