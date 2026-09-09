"
A MutantDebuggerTest is a test class for testing the behavior of MutantDebugger
"
Class {
	#name : 'MutantDebuggerTest',
	#superclass : 'TestCase',
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'as yet unclassified' }
MutantDebuggerTest >> testTakeVariables [
	| temp |
	temp := 12.
	self assertCollection: MutantDebugger new takeVariables hasSameElements: { #temp }
]
