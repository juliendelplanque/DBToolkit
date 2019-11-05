"
Description
--------------------

I am the root component of DBToolkit. I will contain every components of the application to display.

I have a header.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	componentInstances:			<aDictionary>	A dictionary keeping for each component class, an instance. This instance can be use when the user change of page to come pack to a previous page.
	componentToDisplay:		<aComponent>	The current page to display as the root content.
	header:						<aComponent>	The header of the page.

"
Class {
	#name : #DBTRoot,
	#superclass : #DBTComponent,
	#instVars : [
		'header',
		'componentToDisplay',
		'componentInstances'
	],
	#category : #'DBToolkit-Core'
}

{ #category : #testing }
DBTRoot class >> canBeRoot [
	^ true
]

{ #category : #initialization }
DBTRoot class >> initialize [
		self environment at: #WADevelopmentConfiguration ifPresent: [ :class | WAAdmin applicationDefaults removeParent: class instance ]. "Remove development tools."
	^ (WAAdmin register: self asApplicationAt: 'DBToolkit')
		preferenceAt: #sessionClass put: DBTSession;
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: DBTLibrary;
		addLibrary: CYSFileLibrary;
		addLibrary: PrismLibrary;
		yourself
]

{ #category : #'world menu' }
DBTRoot class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'DBToolkit')
		order: 20;
		with: [ (aBuilder item: #'Open in default browser')
				order: 2;
				iconName: #nautilus;
				help: 'Open in the default web browser';
				action: [ self open ] ]
]

{ #category : #'instance creation' }
DBTRoot class >> open [
	<script>
	| port |
	WAServerManager default adaptors
		ifEmpty: [ (ZnZincServerAdaptor port: (port := 8085)) start ]
		ifNotEmpty: [ :adaptors | 
			adaptors
				detect: #isRunning
				ifFound: [ :anAdaptor | port := anAdaptor server port ]
				ifNone: [ (ZnZincServerAdaptor port: (port := 8085)) start ] ].
	WebBrowser openOn: 'http://localhost:' , port asString , '/DBToolkit'
]

{ #category : #hooks }
DBTRoot >> children [
	^ { self header. self componentToDisplay }
]

{ #category : #accessing }
DBTRoot >> componentInstances [
	"I return a dictionary with browsers as keys and their instances as value if they were instantiated at least once."

	^ componentInstances
]

{ #category : #accessing }
DBTRoot >> componentInstances: aDictionary [
	componentInstances := aDictionary
]

{ #category : #accessing }
DBTRoot >> componentToDisplay [
	"Component instance to display in the application."
	
	^ componentToDisplay
]

{ #category : #accessing }
DBTRoot >> componentToDisplay: aComponent [
	componentToDisplay := aComponent
]

{ #category : #components }
DBTRoot >> defaultHeader [
	^ DBTHeader new
]

{ #category : #updating }
DBTRoot >> displayInstanceOf: aComponentClass [
	self componentToDisplay: (self componentInstances at: aComponentClass ifAbsentPut: [ aComponentClass new ])
]

{ #category : #accessing }
DBTRoot >> header [
	^ header
]

{ #category : #accessing }
DBTRoot >> header: aComponent [
	header := aComponent
]

{ #category : #hooks }
DBTRoot >> initialRequest: aRequest [
	| consumer pageName |
	super initialRequest: aRequest.
	consumer := self requestContext consumer.
	
	"If we are at end, nothing to manage"
	consumer atEnd ifTrue: [ ^ self ].
	
	pageName := consumer peek asLowercase. "Do not make URLs case sensitive in that case"
	
	"Try to find a page corresponding"
	self header possiblePages
		detect: [ :each | each pathName asLowercase = pageName ]
		ifFound: [ :class | 
			self displayInstanceOf: class.

			"If we find a page, we pop the subpart of the path corresponding to the page."
			consumer next ]
]

{ #category : #initialization }
DBTRoot >> initialize [
	super initialize.
	self header: self defaultHeader.
	self session rootComponent: self.
	self componentInstances: Dictionary new.
	self displayInstanceOf: self header possiblePages first
]

{ #category : #rendering }
DBTRoot >> renderContentOn: html [
	html
		mdlLayout: [ html render: self header.
			html mdlLayoutContent
				class: 'mdl-color-text--grey-600';
				with: [ html mdlGrid
						noSpacing;
						style: 'height: 100%;';
						with: [ html mdlCell
								class: 'dbtoolkit';
								size: 12;
								with: [ html render: self componentToDisplay ] ]] ]
]

{ #category : #updating }
DBTRoot >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'A toolkit to handle relational databases'.
	anHtmlRoot meta
		attributeAt: 'name' put: 'viewport';
		content: 'width=device-width, initial-scale=1'
]

{ #category : #updating }
DBTRoot >> updateUrl: aUrl [
	super updateUrl: aUrl.
	aUrl addToPath: (self componentToDisplay pathName)
]
