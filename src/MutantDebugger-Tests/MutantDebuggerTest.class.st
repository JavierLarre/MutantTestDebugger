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
MutantDebuggerTest >> testRun [

	| snapshots |
	snapshots := MutantDebugger new
		             classesToMutate: { BankAccount };
		             testClasses: { BankAccountTest };
		             run.
	snapshots snapshotsDifferences inspect
]
