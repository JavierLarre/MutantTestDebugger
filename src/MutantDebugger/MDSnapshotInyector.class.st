Class {
	#name : 'MDSnapshotInyector',
	#superclass : 'Object',
	#instVars : [
		'testCases'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'instance creation' }
MDSnapshotInyector class >> fromTestClasses: aTestClassCollection [

	^ self withTestCases: (aTestClassCollection flatCollect: [ :testClass | testClass suite tests ])
]

{ #category : 'instance creation' }
MDSnapshotInyector class >> withTestCases: aTestCaseCollection [
	^ self new
		testCases: aTestCaseCollection;
		yourself
]

{ #category : 'as yet unclassified' }
MDSnapshotInyector >> codeToInyect [

	MDSnapshots uniqueInstance takeSnapshotInTest: self
]

{ #category : 'initialization' }
MDSnapshotInyector >> initialize [ 

	testCases := Dictionary new
]

{ #category : 'as yet unclassified' }
MDSnapshotInyector >> inyectCodeIntoTestCase: aTestCase [
	| parseTree |
	parseTree := (testCases at: aTestCase) parseTree.
	parseTree addNode: self nodeToInyect.
	aTestCase class compile: parseTree formattedCode
]

{ #category : 'applying' }
MDSnapshotInyector >> inyectCodeIntoTestCases [
	testCases keysDo: [ :testCase | self inyectCodeIntoTestCase: testCase ]
]

{ #category : 'as yet unclassified' }
MDSnapshotInyector >> nodeToInyect [

	^ (self class >> #codeToInyect) parseTree body statements first
]

{ #category : 'as yet unclassified' }
MDSnapshotInyector >> restoreTestCases [

	testCases keysAndValuesDo: [ :testCase :compiledMethod |
		testCase class compile: compiledMethod parseTree formattedCode ]
]

{ #category : 'as yet unclassified' }
MDSnapshotInyector >> runInstrumentedTestCases [

	(TestSuite named: self class name asString)
			  addTests: testCases keys;
			  run.
]

{ #category : 'accessing' }
MDSnapshotInyector >> testCases [

	^ testCases
]

{ #category : 'accessing' }
MDSnapshotInyector >> testCases: aTestCaseCollection [

	aTestCaseCollection do: [ :testCase | 
		testCases at: testCase put: testCase class >> testCase selector ]
]
