Class {
	#name : #MDLIconColumnDescription,
	#superclass : #MDLTableColumnDescription,
	#category : #'DBToolkit-ConnectionsManager'
}

{ #category : #rendering }
MDLIconColumnDescription >> render: row on: html [
	html mdlTableCell
		id: (self generateIdUsing: html);
		class: 'mdl-table-widget__cell--icon';
		with: [
			html mdlIcon
			with: (self evaluation value: row) ]
]

{ #category : #rendering }
MDLIconColumnDescription >> renderHeadingOn: html [
	(super renderHeadingOn: html)
		class: 'mdl-table-widget__cell--icon';
		with: self title.
]
