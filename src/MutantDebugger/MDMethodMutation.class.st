Class {
	#name : 'MDMethodMutation',
	#superclass : 'MTMethodMutation',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'private' }
MDMethodMutation >> runTestsStoppingOnError: aBoolean [

	| result |
	testCaseReferences do: [ :testCaseReference |
			testCaseReference testCaseClass superclass: MDTestSnapshotter.
			testCaseReference testCase mutant: self ].
	MutantDebugger uniqueInstance startCollectingMutations.
	result := [ super runTestsStoppingOnError: aBoolean ] ensure: [
			          MutantDebugger uniqueInstance stopCollectingMutations.
			          testCaseReferences do: [ :testCaseReference | testCaseReference testCaseClass superclass: TestCase ] ].
	^ result
]
