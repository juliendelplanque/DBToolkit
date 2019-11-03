Class {
	#name : #DBTVisualizationsPage,
	#superclass : #DBTPage,
	#category : #'DBToolkit-Visualizations'
}

{ #category : #accessing }
DBTVisualizationsPage class >> pageName [
	^ 'Visualizations'
]

{ #category : #accessing }
DBTVisualizationsPage class >> priority [
	^ 1
]

{ #category : #rendering }
DBTVisualizationsPage >> renderContentOn: html [
	html render: (DBTVisualizationWidget model: (DBConnectionsManager current connections detect: #isUnderAnalysis ifFound: #fmxSQLModel ifNone: [ FmxSQLMooseModel new]))
]
