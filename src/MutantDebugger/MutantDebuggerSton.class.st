Class {
	#name : 'MutantDebuggerSton',
	#superclass : 'STON',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'accessing' }
MutantDebuggerSton class >> writer [ 
	^ MutantDebuggerStonWriter new
]
