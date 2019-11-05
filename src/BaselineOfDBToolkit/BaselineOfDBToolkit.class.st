Class {
	#name : #BaselineOfDBToolkit,
	#superclass : #BaselineOf,
	#category : #BaselineOfDBToolkit
}

{ #category : #baselines }
BaselineOfDBToolkit >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'DBToolkit'
					with: [ spec
						requires: #('MaterialDesignLite' 'TelescopeCytoscape' 'PrismCodeDisplayer' 'FAMIXNGSQL') ];
				package: 'DBToolkit-ConnectionsManager'
					with: [ spec requires: #('DBToolkit' 'DBConnectionsManager') ];
				package: 'DBToolkit-Visualizations'
					with: [ spec
						requires: #('DBToolkit' 'DBConnectionsManager' TelescopeCytoscape) ].
			spec
				baseline: 'FAMIXNGSQL'
				with: [ spec repository: 'github://juliendelplanque/FAMIXNGSQL/src' ].
			spec
				baseline: 'MaterialDesignLite'
				with: [ spec repository: 'github://DuneSt/MaterialDesignLite:v2.x.x/src' ].
			spec
				baseline: 'DBConnectionsManager'
				with: [ spec
						repository: 'github://juliendelplanque/DBConnectionsManager/repository' ].
			spec
				baseline: 'TelescopeCytoscape'
				with: [ spec
						repository: 'github://TelescopeSt/TelescopeCytoscape:v2.x.x/src' ].
			spec
				baseline: 'PrismCodeDisplayer'
				with: [ spec repository: 'github://DuneSt/PrismCodeDisplayer:v1.x.x/src' ] ]
]
