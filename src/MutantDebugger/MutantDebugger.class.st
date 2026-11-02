Class {
	#name : 'MutantDebugger',
	#superclass : 'Object',
	#instVars : [
		'classesToMutate',
		'testClasses',
		'snapshots'
	],
	#category : 'MutantDebugger-Facade',
	#package : 'MutantDebugger',
	#tag : 'Facade'
}

{ #category : 'accessing' }
MutantDebugger >> classesToMutate [

	^ classesToMutate
]

{ #category : 'accessing' }
MutantDebugger >> classesToMutate: anObject [

	classesToMutate := anObject
]

{ #category : 'as yet unclassified' }
MutantDebugger >> generateAsserts [

	| differences |
	differences := self run.
	differences do: #generateAssert
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
						mutantGenerationStrategy: MTAllMutantGenerationStrategy new;
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
		  snapshots differences ] ensure: [ inyector restoreTestCases ]
]

{ #category : 'as yet unclassified' }
MutantDebugger >> suggestedAsserts [

	| differences |
	differences := self run.
	^ differences collect: #differentVariables
]

{ #category : 'accessing' }
MutantDebugger >> testClasses [

	^ testClasses
]

{ #category : 'accessing' }
MutantDebugger >> testClasses: anObject [

	testClasses := anObject
]
