Class {
	#name : 'MDSTON',
	#superclass : 'STON',
	#category : 'MutantDebugger-STON',
	#package : 'MutantDebugger',
	#tag : 'STON'
}

{ #category : 'accessing' }
MDSTON class >> reader [

	^ MDSTONReader new 
]

{ #category : 'accessing' }
MDSTON class >> writer [
	"Shortcut to create a new STONWriter instance"

	^ MDSTONWriter new
]
