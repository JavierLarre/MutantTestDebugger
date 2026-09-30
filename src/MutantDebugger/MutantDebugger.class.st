"
I take snapshots of objects before and after test execution to compare mutation differences
"
Class {
	#name : 'MutantDebugger',
	#superclass : 'Object',
	#instVars : [
		'context',
		'sender',
		'isCollecting',
		'snapshots'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'accessing' }
MutantDebugger class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'instance creation' }
MutantDebugger class >> withContext: aContext [

	^ self new
		context: aContext;
		yourself
]

{ #category : 'initialization' }
MutantDebugger >> context: aContext [
	context := aContext 
]

{ #category : 'initialization' }
MutantDebugger >> initialize [ 
	super initialize.
	context := thisContext.
	isCollecting := false.
	snapshots := Dictionary new.
	sender := nil.
]

{ #category : 'accessing' }
MutantDebugger >> newSnapshot [

	^ MDSnapshot new
		sender: self serializedSender;
		temporaryVariables: self serializedTemporaries
]

{ #category : 'accessing' }
MutantDebugger >> sender [

	^ sender 
]

{ #category : 'accessing' }
MutantDebugger >> sender: anObject [

	sender := anObject
]

{ #category : 'accessing' }
MutantDebugger >> serializedSender [

	"todo: buscar método más eficiente"
	^ STON toString: sender
]

{ #category : 'accessing' }
MutantDebugger >> serializedTemporaries [

	^ STON toString: context temporaryVariables 
]

{ #category : 'accessing' }
MutantDebugger >> snapshots [

	^ snapshots 
]

{ #category : 'as yet unclassified' }
MutantDebugger >> startCollectingMutations [

	isCollecting := true
]

{ #category : 'ston persistence' }
MutantDebugger >> stonOn: aStonWriter [

	| tempContext |
	tempContext := context.
	context := nil.
	^ [ super stonOn: aStonWriter ] ensure: [ context := tempContext ] 
]

{ #category : 'as yet unclassified' }
MutantDebugger >> stopCollectingMutations [

	isCollecting := false
]

{ #category : 'api' }
MutantDebugger >> takeSnapshotFromMutant: aMethodMutation inTest: aTestCase [

	sender := aTestCase .
	snapshots at: aMethodMutation at: aTestCase put: self newSnapshot
]
