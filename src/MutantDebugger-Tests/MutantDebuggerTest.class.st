"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'MutantDebuggerTest',
	#superclass : 'TestCase',
	#instVars : [
		'debugger'
	],
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'running' }
MutantDebuggerTest >> setUp [
	super setUp.

	debugger := MutantDebugger withContext: thisContext
]

{ #category : 'tests' }
MutantDebuggerTest >> testCompareAndDetectChanges [
	| acc |
	acc := BankAccount withFunds: 200.
	debugger takeSnapshot.
	acc withdraw: 20.
	self assert: acc balance equals: 180.
	self should: [ debugger compareAndDetectChanges ] raise: AssertionFailure. 
]

{ #category : 'tests' }
MutantDebuggerTest >> testSerializedSender [
	
	| sender |
	sender := debugger serializedSender.
	self 
		assert: sender equals: (MutantDebuggerSton toString: self)
]

{ #category : 'tests' }
MutantDebuggerTest >> testSnapshotTakesTempVariables [
	| temp |
	temp := 12.
	debugger takeSnapshot. 
	self assert: debugger temporaryVariables associations equals: { #temp -> 12 }
]

{ #category : 'tests' }
MutantDebuggerTest >> testStonSnapshot [

	debugger takeSnapshot.
	self assert: debugger stonSnapshot equals: (MutantDebuggerSton toString: self)
]

{ #category : 'tests' }
MutantDebuggerTest >> testTakenSender [

	| sender |
	sender := debugger 
		takeSender;
		takenSender.
	self
		deny: sender equals: self;
		assert: sender class equals: self class;
		assert: sender selector equals: self selector
]
