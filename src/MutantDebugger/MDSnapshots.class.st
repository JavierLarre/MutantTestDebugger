"
I take snapshots of objects before and after test execution to compare mutation differences
"
Class {
	#name : 'MDSnapshots',
	#superclass : 'Object',
	#instVars : [
		'context',
		'sender',
		'originalSnapshots',
		'mutatedSnapshots',
		'isTestMutated',
		'currentMutation'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'class initialization' }
MDSnapshots class >> initialize [

	uniqueInstance := nil
]

{ #category : 'accessing' }
MDSnapshots class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'instance creation' }
MDSnapshots class >> withContext: aContext [

	^ self new
		context: aContext;
		yourself
]

{ #category : 'initialization' }
MDSnapshots >> context: aContext [
	context := aContext 
]

{ #category : 'accessing' }
MDSnapshots >> currentMutation [

	^ currentMutation
]

{ #category : 'accessing' }
MDSnapshots >> currentMutation: anObject [

	self startCollectingMutations.
	currentMutation := anObject
]

{ #category : 'as yet unclassified' }
MDSnapshots >> differences [

	| differences |
	differences := Dictionary new.
	mutatedSnapshots keysAndValuesDo: [ :mutation :snapshots |
			snapshots keysAndValuesDo: [ :testCase :snapshot |
					differences
						at: mutation put: (MDSnapshotDifference new
								 mutation: mutation;
								 mutatedSnapshot: snapshot;
								 originalSnapshot: (originalSnapshots at: testCase));
						yourself ] ].
	^ differences select: #isDifferent
]

{ #category : 'initialization' }
MDSnapshots >> initialize [

	super initialize.
	context := thisContext.
	isTestMutated := false.
	mutatedSnapshots := Dictionary new.
	originalSnapshots := Dictionary new
]

{ #category : 'accessing' }
MDSnapshots >> mutatedSnapshots [

	^ mutatedSnapshots
]

{ #category : 'accessing' }
MDSnapshots >> mutatedSnapshots: anObject [

	mutatedSnapshots := anObject
]

{ #category : 'accessing' }
MDSnapshots >> newSnapshot [

	^ MDSnapshot new
		  sender: sender;
		  temporaryVariables: context temporaryVariables;
		  yourself
]

{ #category : 'accessing' }
MDSnapshots >> originalSnapshots [

	^ originalSnapshots
]

{ #category : 'accessing' }
MDSnapshots >> originalSnapshots: anObject [

	originalSnapshots := anObject
]

{ #category : 'initialization' }
MDSnapshots >> reset [

	self initialize
]

{ #category : 'accessing' }
MDSnapshots >> sender [

	^ sender 
]

{ #category : 'accessing' }
MDSnapshots >> sender: anObject [

	sender := anObject
]

{ #category : 'accessing' }
MDSnapshots >> serializedSender [

	"todo: buscar método más eficiente"
	^ STON toString: sender
]

{ #category : 'accessing' }
MDSnapshots >> serializedTemporaries [

	^ STON toString: context temporaryVariables 
]

{ #category : 'as yet unclassified' }
MDSnapshots >> startCollectingMutations [

	isTestMutated := true
]

{ #category : 'ston persistence' }
MDSnapshots >> stonOn: aStonWriter [

	| tempContext |
	tempContext := context.
	context := nil.
	^ [ super stonOn: aStonWriter ] ensure: [ context := tempContext ] 
]

{ #category : 'as yet unclassified' }
MDSnapshots >> stopCollectingMutations [

	isTestMutated := false
]

{ #category : 'api' }
MDSnapshots >> takeSnapshotInTest: aTestCase [

	| snapshots |
	sender := aTestCase.
	snapshots := isTestMutated
		ifTrue: [ mutatedSnapshots at: currentMutation ifAbsentPut: [ Dictionary new ] ]
		ifFalse: [ originalSnapshots ].
	snapshots at: aTestCase put: self newSnapshot
]
