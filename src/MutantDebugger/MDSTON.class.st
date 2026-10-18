Class {
	#name : 'MDSTON',
	#superclass : 'STON',
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'accessing' }
MDSTON >> writer [

	^ MDSTONWriter new
]
