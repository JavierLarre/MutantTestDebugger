Class {
	#name : 'MDMutantEvaluation',
	#superclass : 'MTMutantEvaluation',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'private' }
MDMutantEvaluation >> testResults [

	"MDSnapshots uniqueInstance currentMutation: mutation.
	^ [ super testResults ] ensure: [ MDSnapshots uniqueInstance stopCollectingMutations ]"
	^ super testResults 
]

{ #category : 'private' }
MDMutantEvaluation >> valueStoppingOnError: aBoolean [

	MDSnapshots uniqueInstance currentMutation: mutation.
	^ [ super valueStoppingOnError: aBoolean ] ensure: [ MDSnapshots uniqueInstance stopCollectingMutations ]
]
