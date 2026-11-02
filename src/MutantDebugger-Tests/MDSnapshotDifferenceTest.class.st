"
A MDSnapshotDifferenceTest is a test class for testing the behavior of MDSnapshotDifference
"
Class {
	#name : 'MDSnapshotDifferenceTest',
	#superclass : 'TestCase',
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'tests' }
MDSnapshotDifferenceTest >> testGenerateAssert [

	| difference testCase mutatedTestCase |
	testCase := (BankAccountTest selector: #testDeposit)
		            account: BankAccount new;
		            yourself.
	mutatedTestCase := testCase copy.
	mutatedTestCase account: (BankAccount new
			 owner: nil;
			 yourself).
	difference := MDSnapshotDifference new
		              originalSnapshot: (MDSnapshot new sender: testCase);
		              mutatedSnapshot: (MDSnapshot new sender: mutatedTestCase);
		              mutation: (MTMethodMutation
				               for: BankAccount >> #initialize
				               using: MTAssignmentNullifierOperator new
				               nodeNumber: 2
				               ofClass: BankAccount
				               withData: OCAssignmentNode new);
		              yourself.
	difference generateAssert.
	self
		assert: (BankAccountTest includesSelector: #testDepositSuggestedFromMTAssignmentNullifierOperator)
		description: 'test was not generated or was generated with the wrong name'.
	self
		assert: (BankAccountTest sourceCodeAt: #testDepositSuggestedFromMTAssignmentNullifierOperator)
		equals: 'testDepositSuggestedFromMTAssignmentNullifierOperator

	account deposit: 100.
	self assert: account balance equals: 100.
	self assert: ((self instVarNamed: #account) instVarNamed: #owner) equals: '''''
]
