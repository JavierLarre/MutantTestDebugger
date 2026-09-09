Class {
	#name : 'MutantDebuggerStonWriter',
	#superclass : 'STONWriter',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'writing' }
MutantDebuggerStonWriter >> writeObject: anObject [

	anObject class = MutantDebugger 
	ifFalse: [ 
		super writeObject: anObject ]
	ifTrue: [ 
		self writeObject: anObject do: [ self encodeMap: #() ] ]
]
