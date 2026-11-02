"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'MutantDebuggerTest',
	#superclass : 'TestCase',
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'tests' }
MutantDebuggerTest >> testGenerateAsserts [

	MutantDebugger new
		classesToMutate: { BankAccount };
		testClasses: { BankAccountTest };
		generateAsserts
]

{ #category : 'tests' }
MutantDebuggerTest >> testRun [

	| snapshots |
	snapshots := MutantDebugger new
		             classesToMutate: { BankAccount };
		             testClasses: { BankAccountTest };
		             run.
	snapshots inspect
]

{ #category : 'tests' }
MutantDebuggerTest >> testSuggestedAsserts [

	| differences |
	differences := MutantDebugger new
		               classesToMutate: { BankAccount };
		               testClasses: { BankAccountTest };
		               suggestedAsserts.
	differences inspect
]
