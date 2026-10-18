"
A MDSnapshotInyectorTest is a test class for testing the behavior of MDSnapshotInyector
"
Class {
	#name : 'MDSnapshotInyectorTest',
	#superclass : 'TestCase',
	#instVars : [
		'inyector',
		'debugger'
	],
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'running' }
MDSnapshotInyectorTest >> setUp [
	super setUp.

	inyector := MDSnapshotInyector new.
	debugger := MDSnapshots uniqueInstance 
]

{ #category : 'running' }
MDSnapshotInyectorTest >> tearDown [

	inyector restoreTestCases.
	debugger reset.
	super tearDown 
]

{ #category : 'tests' }
MDSnapshotInyectorTest >> testCodeWasInyected [
	
	inyector testCases: { BankAccountTest selector: #testDeposit }.
	inyector inyectCodeIntoTestCases .
	self assert: (BankAccountTest >> #testDeposit ) parseTree body statements last equals: inyector nodeToInyect 
]

{ #category : 'tests' }
MDSnapshotInyectorTest >> testCodeWasRestored [
	| compiledMethod |
	compiledMethod := BankAccountTest >> #testDeposit.
	inyector testCases: { BankAccountTest selector: #testDeposit }.
	inyector inyectCodeIntoTestCases.
	inyector restoreTestCases.
	self assert: (BankAccountTest >> #testDeposit ) equals: compiledMethod 
]
