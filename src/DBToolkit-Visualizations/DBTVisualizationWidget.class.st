Class {
	#name : #DBTVisualizationWidget,
	#superclass : #MDLWidget,
	#instVars : [
		'model'
	],
	#category : #'DBToolkit-Visualizations'
}

{ #category : #'instance creation' }
DBTVisualizationWidget class >> model: model [
	^ self new
		model: model;
		yourself
]

{ #category : #accessing }
DBTVisualizationWidget >> model [
	^ model
]

{ #category : #accessing }
DBTVisualizationWidget >> model: anObject [
	model := anObject
]

{ #category : #rendering }
DBTVisualizationWidget >> renderContentOn: html [
	html render: (MDLTabWidget new
		addTabNamed: 'Tables dependencies' content: self tableDependenciesVisualization;
		yourself)
]

{ #category : #'as yet unclassified' }
DBTVisualizationWidget >> tableDependenciesVisualization [
	^ (TLCytoscapeComponent visualization: (TLCycleDependencies new
		entities: ((self model allWithType: FmxSQLTable) reject: #isStub);
		property: [ :table | 
			(table foreignKeyConstraints collect: [ :const | const outgoingForeignKeyColumnReferences collect: [:ref | ref to columnsContainer ] ]) flattened asSet ];
		heightBlock: [ :each | each queryAllIncoming size ];
		widthBlock: [ :each | each queryAllOutgoing size ];
		yourself))
		style: 'height: 80vh;';
		yourself
]
