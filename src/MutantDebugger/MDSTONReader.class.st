Class {
	#name : 'MDSTONReader',
	#superclass : 'STONReader',
	#category : 'MutantDebugger-STON',
	#package : 'MutantDebugger',
	#tag : 'STON'
}

{ #category : 'parsing' }
MDSTONReader >> parseNamedInstVarsFor: anObject [

	anObject class allInstVarNames do: [ :instVarName | 
		anObject instVarNamed: instVarName put: nil ].
	super parseNamedInstVarsFor: anObject.
]
