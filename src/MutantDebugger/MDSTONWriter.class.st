Class {
	#name : 'MDSTONWriter',
	#superclass : 'STONWriter',
	#instVars : [
		'blacklist',
		'variables',
		'target'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'accessing' }
MDSTONWriter >> blacklist: anObject [

	blacklist := anObject
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> hasBlacklistedVariable [

	^ self instanceVariableNames includesAny: blacklist
]

{ #category : 'initialization' }
MDSTONWriter >> initialize [

	super initialize.
	blacklist := Set newFrom: #( expectedFailures ).
	variables := Dictionary new
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> instanceVariableNames [

	^ target class allInstVarNames
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> instanceVariableNamesInBlacklist [

	^ self instanceVariableNames intersection: blacklist
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> nullifyVariable: anObject [

	| instanceVariableNames |
	instanceVariableNames := self instanceVariableNames intersection: blacklist.
	variables removeAll.
	instanceVariableNames do: [ :instVarName |
			variables at: instVarName put: (target instVarNamed: instVarName).
			target instVarNamed: instVarName put: nil ]
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> nullifyVariables [

	variables removeAll.
	self instanceVariableNamesInBlacklist do: [ :instVarName |
			variables at: instVarName put: (target instVarNamed: instVarName).
			target instVarNamed: instVarName put: nil ]
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> restoreVariable: anObject [

	variables keysAndValuesDo: [ :instVarName :instVarValue | anObject instVarNamed: instVarName put: instVarValue ]
]

{ #category : 'as yet unclassified' }
MDSTONWriter >> restoreVariables [

	variables keysAndValuesDo: [ :instVarName :instVarValue | target instVarNamed: instVarName put: instVarValue ]
]

{ #category : 'writing' }
MDSTONWriter >> writeObject: anObject [

	target := anObject.
	self hasBlacklistedVariable ifTrue: [ self nullifyVariables ].
	super writeObject: anObject.
	self hasBlacklistedVariable ifTrue: [ self restoreVariables ]
]
