Class {
	#name : 'MDSTONReader',
	#superclass : 'STONReader',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'parsing' }
MDSTONReader >> parseNamedInstVarsFor: anObject [

	anObject class allInstVarNames do: [ :instVarName | 
		anObject instVarNamed: instVarName put: nil ].
	super parseNamedInstVarsFor: anObject.
]
