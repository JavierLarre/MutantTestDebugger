Class {
	#name : 'MDMutantEvaluation',
	#superclass : 'MTMutantEvaluation',
	#category : 'MutantDebugger-MuTalk',
	#package : 'MutantDebugger',
	#tag : 'MuTalk'
}

{ #category : 'private' }
MDMutantEvaluation >> valueStoppingOnError: aBoolean [

	MDSnapshots uniqueInstance currentMutation: mutation.
	^ [ super valueStoppingOnError: aBoolean ] ensure: [ MDSnapshots uniqueInstance stopCollectingMutations ]
]
