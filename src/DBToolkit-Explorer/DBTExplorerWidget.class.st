Class {
	#name : #DBTExplorerWidget,
	#superclass : #MDLWidget,
	#instVars : [
		'model',
		'selectedEntity'
	],
	#category : #'DBToolkit-Explorer'
}

{ #category : #'instance creation' }
DBTExplorerWidget class >> model: model [
	^ self new
		model: model;
		yourself
]

{ #category : #'as yet unclassified' }
DBTExplorerWidget >> entitiesTree [
	^ DBTTreeNode new
		name: 'Root';
		children:
			{(DBTTreeNode new
				name: 'Tables';
				children: ((self model allWithType: FmxSQLTable) entities reject: #isStub);
				yourself).
			(DBTTreeNode new
				name: 'Views';
				children: ((self model allWithType: FmxSQLView) entities reject: #isStub);
				yourself).
			(DBTTreeNode new
				name: 'Stored procedures';
				children:
					((self model allWithType: FmxSQLStoredProcedure) entities
						reject: #isStub);
				yourself)};
		yourself
]

{ #category : #accessing }
DBTExplorerWidget >> model [
	^ model
]

{ #category : #accessing }
DBTExplorerWidget >> model: anObject [
	model := anObject
]

{ #category : #rendering }
DBTExplorerWidget >> renderContentOn: html [
	html mdlGrid
		with: [ 
			html mdlCell
				size: 2;
				with: [ self renderEntitiesTreeOn: html ].
			html mdlCell
				size: 4;
				with: [ self renderSourceCodeOn: html ].
			html mdlCell
				size: 4;
				with: [  ] ]
]

{ #category : #rendering }
DBTExplorerWidget >> renderEntitiesTreeOn: html [
	html mdlGrid
		with: [
			html mdlCell
				size: 12;
				with: [ html heading level3; with: 'Entity kind' ].
			html mdlCell
				size: 12;
				with: [ html div
		style: 'height: 100%; width: 100%;'; flag: #TODO;
		shadow: 2;
		with:
			((MDLNestedList
				elements: self entitiesTree children
				children: [ :entity | 
					entity class = DBTTreeNode
						ifTrue: [ entity children ]
						ifFalse: [ #() ] ])
				format: #name;
				iconBlock: [ :entity :canvas |
					entity class = DBTTreeNode
						ifFalse: [ 
							canvas mdlChipContact
								mdlBackgroundColorAccent;
								with: (entity className allButFirst: 'FmxSQL' size) first asString ] ];
				"helpBlock: #comment;"
				"selectedEntity: selectedElement;"
				actionBlock: [ :entity | selectedEntity := entity ];
				childrenSortBlock: #name ascending;
				beCompact;
				yourself) ] ]
]

{ #category : #rendering }
DBTExplorerWidget >> renderSourceCodeOn: html [
	html
		render:
			(PrismComponent new
				sourceCode: [ (PrismComponent >> #renderContentOn:) sourceCode ];
				language: #smalltalk;
				yourself)
]
