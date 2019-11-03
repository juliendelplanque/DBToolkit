Extension { #name : #DBConnectionDescription }

{ #category : #'*DBToolkit-ConnectionsManager' }
DBConnectionDescription >> analysisStatus [
	^ self privateState at: #analysisStatus ifAbsent: [ 
		self beNotUnderAnalysis.
		self analysisStatus ]
]

{ #category : #'*DBToolkit-ConnectionsManager' }
DBConnectionDescription >> beNotUnderAnalysis [
	self privateState at: #analysisStatus put: 'visibility_off'
]

{ #category : #'*DBToolkit-ConnectionsManager' }
DBConnectionDescription >> beUnderAnalysis [
	self privateState at: #analysisStatus put: 'visibility'
]

{ #category : #'*DBToolkit-ConnectionsManager' }
DBConnectionDescription >> isUnderAnalysis [
	^ self analysisStatus = 'visibility'
]
