"
Description
--------------------

I am the reader of the application.
"
Class {
	#name : #DBTHeader,
	#superclass : #DBTComponent,
	#category : #'DBToolkit-Core'
}

{ #category : #accessing }
DBTHeader >> possiblePages [
	^ DBTPage pagesToDisplay
]

{ #category : #rendering }
DBTHeader >> renderContentOn: html [
	html
		mdlLayoutHeader: [ 
			html
				mdlLayoutHeaderRow: [ 
					html mdlNavigationLink
						callback: [ "Just refresh" ];
						with: [ html
								mdlLayoutTitle: 'A toolkit to handle relational databases' ].
					html mdlLayoutSpacer.
					html text: 'Version 0.0.0'. ] ].
	self renderDrawerOn: html
]

{ #category : #rendering }
DBTHeader >> renderDrawerOn: html [
	html
		mdlLayoutDrawer: [ 
			html
				mdlNavigation: [ 
					self possiblePages
						do: [ :aClass | 
							html mdlNavigationLink
								beCurrentIf: aClass = self rootComponent componentToDisplay class;
								callback: [ self displayInstanceOf: aClass ];
								with: aClass pageName ] ] ]
]
