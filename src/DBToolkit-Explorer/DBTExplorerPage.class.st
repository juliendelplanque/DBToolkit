Class {
	#name : #DBTExplorerPage,
	#superclass : #DBTPage,
	#category : #'DBToolkit-Explorer'
}

{ #category : #accessing }
DBTExplorerPage class >> pageName [
	^ 'Explorer'
]

{ #category : #accessing }
DBTExplorerPage class >> priority [
	^ 2
]

{ #category : #rendering }
DBTExplorerPage >> renderContentOn: html [
	html render: (DBTExplorerWidget model: (DBConnectionsManager current connections detect: #isUnderAnalysis ifFound: #fmxSQLModel ifNone: [ FmxSQLMooseModel new]))
]
