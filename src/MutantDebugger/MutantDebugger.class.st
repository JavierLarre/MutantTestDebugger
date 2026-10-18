Class {
	#name : 'MutantDebugger',
	#superclass : 'Object',
	#instVars : [
		'classesToMutate',
		'testClasses',
		'snapshots'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'accessing' }
MutantDebugger >> classesToMutate [

	^ classesToMutate
]

{ #category : 'accessing' }
MutantDebugger >> classesToMutate: anObject [

	classesToMutate := anObject
]

{ #category : 'initialization' }
MutantDebugger >> initialize [

	super initialize.
	snapshots := MDSnapshots uniqueInstance
		             reset;
		             yourself
]

{ #category : 'running' }
MutantDebugger >> run [

	| analysis inyector |
	analysis := MTAnalysis new
		            evaluationClass: MDMutantEvaluation;
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            yourself.
	inyector := MDSnapshotInyector fromTestClasses: testClasses.
	snapshots stopCollectingMutations.

	^ [
		  inyector
			  inyectCodeIntoTestCases;
			  runInstrumentedTestCases.
		  analysis run.
		  snapshots ] ensure: [ inyector restoreTestCases ]
]

{ #category : 'accessing' }
MutantDebugger >> testClasses [

	^ testClasses
]

{ #category : 'accessing' }
MutantDebugger >> testClasses: anObject [

	testClasses := anObject
]
