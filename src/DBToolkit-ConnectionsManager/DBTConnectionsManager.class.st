Class {
	#name : #DBTConnectionsManager,
	#superclass : #MDLWidget,
	#instVars : [
		'connectionsManager'
	],
	#category : #'DBToolkit-ConnectionsManager'
}

{ #category : #'instance creation' }
DBTConnectionsManager class >> connectionsManager: connectionsManager [
	^ self new
		connectionsManager: connectionsManager;
		yourself
]

{ #category : #'as yet unclassified' }
DBTConnectionsManager >> connectionUnderAnalysis: connection [
	self connectionsManager connections do: #beNotUnderAnalysis.
	connection beUnderAnalysis
]

{ #category : #accessing }
DBTConnectionsManager >> connectionsManager [
	^ connectionsManager
]

{ #category : #accessing }
DBTConnectionsManager >> connectionsManager: anObject [
	connectionsManager := anObject
]

{ #category : #rendering }
DBTConnectionsManager >> renderContentOn: html [
html mdlGrid
		with: [ html mdlCell
				size: 12;
				with: [ 
					html div
						style: 'display: flex; justify-content: center;'; flag: #TODO; "Move to stylesheet"
						with: [ 
	html render: (MDLTableWidget new
						addColumn: (MDLIconColumnDescription new
											title: 'Status';
											evaluation: #analysisStatus;
											yourself);
						addStringColumnNamed: 'Connection name' evaluated: #name;
						addStringColumnNamed: 'Hostname' evaluated: #hostname;
						addNumericColumnNamed: 'Port' evaluated: #port;
						addStringColumnNamed: 'Database' evaluated: #databaseName;
						addStringColumnNamed: 'User' evaluated: #userName;
						addButtonColumnWithIconName: 'search' onClick: [ :connection | self connectionUnderAnalysis: connection ] tooltip: 'Set this database connection as being under analysis.';
						collection: self connectionsManager connections;
						yourself) ] ] ]
]
