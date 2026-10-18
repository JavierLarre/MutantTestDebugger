"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'MDSnapshotsTest',
	#superclass : 'TestCase',
	#instVars : [
		'debugger'
	],
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'running' }
MDSnapshotsTest >> setUp [
	super setUp.

	debugger := MDSnapshots withContext: thisContext.
	"debugger sender: self class >> self selector"
]

{ #category : 'running' }
MDSnapshotsTest >> tearDown [
	
	MDSnapshots uniqueInstance reset.
	super tearDown 
]

{ #category : 'tests' }
MDSnapshotsTest >> testSerializedSender [
	
	debugger sender: self.
	self 
		assert: debugger serializedSender equals: (STON toString: self)
]
