Class {
	#name : 'MDMutantEvaluation',
	#superclass : 'MTMutantEvaluation',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'private' }
MDMutantEvaluation >> valueStoppingOnError: aBoolean [

	MDSnapshots uniqueInstance currentMutation: mutation.
	^ [ super valueStoppingOnError: aBoolean ] ensure: [ MDSnapshots uniqueInstance stopCollectingMutations ]
]
