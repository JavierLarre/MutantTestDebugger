Class {
	#name : 'MDSnapshot',
	#superclass : 'Object',
	#instVars : [
		'temporaryVariables',
		'sender',
		'serializedSender'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'comparing' }
MDSnapshot >> = aSnapshot [

	^ serializedSender = aSnapshot serializedSender and: [ temporaryVariables = aSnapshot temporaryVariables ]
]

{ #category : 'as yet unclassified' }
MDSnapshot >> deserializedSender [

	^ MDSTON fromString: serializedSender 
]

{ #category : 'initialization' }
MDSnapshot >> initialize [

	super initialize.
	sender := Object new.
	temporaryVariables := STON toString: Dictionary new.
	serializedSender := STON toString: sender
]

{ #category : 'printing' }
MDSnapshot >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: sender;
		nextPutAll: ')'
]

{ #category : 'accessing' }
MDSnapshot >> sender [

	^ sender
]

{ #category : 'accessing' }
MDSnapshot >> sender: anObject [

	sender := anObject.
	serializedSender := self serialized: anObject 
]

{ #category : 'as yet unclassified' }
MDSnapshot >> serialized: anObject [

	^ MDSTON toString: anObject
]

{ #category : 'accessing' }
MDSnapshot >> serializedSender [

	^ serializedSender
]

{ #category : 'accessing' }
MDSnapshot >> temporaryVariables [

	^ temporaryVariables
]

{ #category : 'accessing' }
MDSnapshot >> temporaryVariables: anObject [

	temporaryVariables := self serialized: anObject
]
