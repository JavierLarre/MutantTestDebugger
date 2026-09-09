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

	debugger := MutantDebugger new 
]

{ #category : 'as yet unclassified' }
MutantDebuggerTest >> testBankAccount [
	| acc |
	acc := BankAccount withFunds: 200.
	debugger takeSnapshot.
	acc withdraw: 20.
	self assert: acc balance equals: 180.
	self should: [ debugger compareAndDetectChanges ] raise: AssertionFailure. 
]

{ #category : 'as yet unclassified' }
MutantDebuggerTest >> testSnapshotTakesTempVariables [
	| temp |
	temp := 12.
	debugger takeSnapshot. 
	self assert: debugger temporaryVariables associations equals: { #temp -> 12 }
]

{ #category : 'tests' }
MutantDebuggerTest >> testTakeSnapshot [

	debugger takeSnapshot.
	self assert: debugger stonSnapshot equals: (MutantDebuggerSton toString: self)
]
