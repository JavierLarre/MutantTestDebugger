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

{ #category : 'running' }
MutantDebuggerTest >> tearDown [
	
	MutantDebugger uniqueInstance snapshots removeAll.
	super tearDown 
]

{ #category : 'tests' }
MutantDebuggerTest >> testMutationSnapshot [
	| compiledMethod operator modifiedSource methodMutation testCase |
	compiledMethod := BankAccount >> #deposit:.
	testCase := BankAccountTest selector: #testPlusDeposit.
	operator := MTReplacePlusWithMinusMutantOperator new.
	modifiedSource := operator
		                  modifiedSourceFor: compiledMethod
		                  number: 1.
	methodMutation := MDMethodMutation 
		                  for: compiledMethod
		                  using: operator
		                  nodeNumber: 1
		                  ofClass: BankAccount .
	methodMutation testCaseReferences:
		{ (MTTestCaseReference for: testCase) }.
	methodMutation runMutantStoppingOnError: true in: nil.

	self 
		assert: (MutantDebugger uniqueInstance snapshots at: methodMutation at: testCase) sender 
		equals: 'BankAccountTest{#testSelector:#testPlusDeposit,#account:BankAccount{#owner:'''',#funds:-300}}'
]

{ #category : 'tests' }
MutantDebuggerTest >> testPutSnapshot [

	| testCase |
	testCase := MDTestSnapshotter new
		mutant: self;
		tearDown;
		yourself.
	
	self 
	assert: (MutantDebugger uniqueInstance snapshots at: self at: testCase) sender 
	equals: (STON toString: testCase)
]

{ #category : 'tests' }
MutantDebuggerTest >> testSerializedSender [
	
	debugger sender: self.
	self 
		assert: debugger serializedSender equals: (STON toString: self)
]
