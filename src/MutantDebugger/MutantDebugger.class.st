Class {
	#name : 'MutantDebugger',
	#superclass : 'Object',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'as yet unclassified' }
MutantDebugger >> takeVariables [

	^ thisContext sender temporaryVariableNames 
]
