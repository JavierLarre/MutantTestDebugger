Extension { #name : 'Context' }

{ #category : '*MutantDebugger' }
Context >> temporaryVariables [ 

	| tempVars |
	tempVars := Dictionary new.
	self temporaryVariableNames do: [ :tempVarName | 
		tempVars at: tempVarName put: (self tempNamed: tempVarName ) ].
	^ tempVars 
]
