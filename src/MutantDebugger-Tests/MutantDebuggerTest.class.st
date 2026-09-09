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

	debugger := MutantDebugger withContext: thisContext.
	"debugger sender: self class >> self selector"
]

{ #category : 'tests' }
MutantDebuggerTest >> testCompareAndDetectChanges [
	| acc |
	acc := BankAccount withFunds: 200.
	acc withdraw: 20.
	self assert: acc balance equals: 181.
	"debugger takeSnapshot: 13 hasMutation: false"
	"debugger takeSnapshot: 13 hasMutation: true"
	"cuando tengamos para comparar, guardamos las diferencias y borramos el STON grande"
	"self assert: acc direction houseNumber equals: 12."
	"self assert: ((acc instVarNamed: #direction) instVarName: #houseNumber) equals: 12"
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
