Class {
	#name : 'MDSnapshotDifference',
	#superclass : 'Object',
	#instVars : [
		'mutation',
		'mutatedSnapshot',
		'originalSnapshot'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'as yet unclassified' }
MDSnapshotDifference >> accessorsFrom: association variable: variable [

	| accessor associations |
	accessor := '(' , variable , ' instVarNamed: #' , association key , ')'.
	associations := association value associations.
	^ associations isEmpty
		  ifTrue: [ accessor ]
		  ifFalse: [ self accessorsFrom: associations first variable: accessor ]
]

{ #category : 'as yet unclassified' }
MDSnapshotDifference >> differentVariables [

	^ self differentVariablesBetween: mutatedSnapshot deserializedSender and: originalSnapshot deserializedSender 
]

{ #category : 'as yet unclassified' }
MDSnapshotDifference >> differentVariablesBetween: anObject and: anotherObject [

	| differentNames differentVariables |
	differentVariables := Dictionary new.
	anObject species = anotherObject species ifFalse: [ ^ differentVariables ].
	differentNames := anObject class allInstVarNames select: [ :instVarName |
		                  (MDSTON toString: (anObject instVarNamed: instVarName))
		                  ~= (MDSTON toString: (anotherObject instVarNamed: instVarName)) ].
	differentNames do: [ :instVarName |
			differentVariables
				at: instVarName
				put: (self differentVariablesBetween: (anObject instVarNamed: instVarName) and: (anotherObject instVarNamed: instVarName)) ].
	^ differentVariables
]

{ #category : 'as yet unclassified' }
MDSnapshotDifference >> generateAssert [

	| testCase ast methodName methodNode differentVariables |
	testCase := originalSnapshot sender.
	ast := testCase class parseTreeForSelector: testCase selector.
	methodName := testCase selector , 'SuggestedFrom' , mutation operator class name.
	differentVariables := self differentVariables.
	methodNode := Smalltalk compiler
		              source:
			              'test self assert: ' , (self accessorsFrom: differentVariables associations first variable: 'self') , ' equals: '
			              , (self suggestionValue: differentVariables associations first from: originalSnapshot deserializedSender) printString;
		              parse.
	ast selector: methodName.
	ast addNode: methodNode statements first.
	testCase class compile: ast formattedCode
]

{ #category : 'testing' }
MDSnapshotDifference >> isDifferent [

	^ originalSnapshot ~= mutatedSnapshot
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutatedSnapshot [

	^ mutatedSnapshot
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutatedSnapshot: anObject [

	mutatedSnapshot := anObject
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutation [

	^ mutation
]

{ #category : 'accessing' }
MDSnapshotDifference >> mutation: anObject [

	mutation := anObject
]

{ #category : 'accessing' }
MDSnapshotDifference >> originalSnapshot [

	^ originalSnapshot
]

{ #category : 'accessing' }
MDSnapshotDifference >> originalSnapshot: anObject [

	originalSnapshot := anObject
]

{ #category : 'printing' }
MDSnapshotDifference >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: mutation;
		nextPutAll: ', ';
		print: originalSnapshot;
		nextPutAll: ')' 
]

{ #category : 'as yet unclassified' }
MDSnapshotDifference >> suggestionValue: association [

	^ association value isEmpty
		  ifTrue: [ association key ]
		  ifFalse: [ self suggestionValue: association value associations first ]
]

{ #category : 'as yet unclassified' }
MDSnapshotDifference >> suggestionValue: association from: anObject [

	^ association value isEmpty
		  ifTrue: [ anObject instVarNamed: association key ]
		  ifFalse: [ self suggestionValue: association value associations first from: (anObject instVarNamed: association key) ]
]
