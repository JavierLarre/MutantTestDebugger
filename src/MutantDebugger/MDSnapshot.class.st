Class {
	#name : 'MDSnapshot',
	#superclass : 'Object',
	#instVars : [
		'temporaryVariables',
		'sender'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'initialization' }
MDSnapshot >> initialize [ 
	super initialize.
	sender := STON toString: Object new.
	temporaryVariables := STON toString: Dictionary new
]

{ #category : 'accessing' }
MDSnapshot >> sender [

	^ sender
]

{ #category : 'accessing' }
MDSnapshot >> sender: anObject [

	sender := anObject
]

{ #category : 'accessing' }
MDSnapshot >> temporaryVariables [

	^ temporaryVariables
]

{ #category : 'accessing' }
MDSnapshot >> temporaryVariables: anObject [

	temporaryVariables := anObject
]
