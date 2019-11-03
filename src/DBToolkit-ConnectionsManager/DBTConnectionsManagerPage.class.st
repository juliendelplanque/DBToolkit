Class {
	#name : #DBTConnectionsManagerPage,
	#superclass : #DBTPage,
	#category : #'DBToolkit-ConnectionsManager'
}

{ #category : #accessing }
DBTConnectionsManagerPage class >> pageName [
	^ 'Connections Manager'
]

{ #category : #accessing }
DBTConnectionsManagerPage class >> priority [
	^ 0
]

{ #category : #rendering }
DBTConnectionsManagerPage >> renderContentOn: html [
	html
		render:
			(DBTConnectionsManager
				connectionsManager: DBConnectionsManager current)
]
