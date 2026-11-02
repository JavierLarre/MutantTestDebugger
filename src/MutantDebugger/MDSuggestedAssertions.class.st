Class {
	#name : 'MDSuggestedAssertions',
	#superclass : 'Object',
	#instVars : [
		'originalSender',
		'mutatedSender',
		'differentVariables'
	],
	#category : 'MutantDebugger-Assertions',
	#package : 'MutantDebugger',
	#tag : 'Assertions'
}

{ #category : 'instance creation' }
MDSuggestedAssertions class >> originalSender: anObject mutatedSender: anotherObject [ 

	^ self new
		originalSender: anObject;
		mutatedSender: anotherObject;
		yourself
]

{ #category : 'accessing' }
MDSuggestedAssertions >> differentVariables [

	self searchDifferentVariables.
	^ differentVariables
]

{ #category : 'initialization' }
MDSuggestedAssertions >> initialize [

	differentVariables := Dictionary new.
]

{ #category : 'accessing' }
MDSuggestedAssertions >> mutatedSender [

	^ mutatedSender
]

{ #category : 'accessing' }
MDSuggestedAssertions >> mutatedSender: anObject [

	mutatedSender := anObject
]

{ #category : 'accessing' }
MDSuggestedAssertions >> originalSender [

	^ originalSender
]

{ #category : 'accessing' }
MDSuggestedAssertions >> originalSender: anObject [

	originalSender := anObject
]

{ #category : 'as yet unclassified' }
MDSuggestedAssertions >> searchDifferentVariables [

	| differentNames |
	originalSender species = mutatedSender species ifFalse: [ ^ differentVariables ].
	differentNames := originalSender class allInstVarNames select: [ :instVarName |
		                  (MDSTON toString: (originalSender instVarNamed: instVarName))
		                  ~= (MDSTON toString: (mutatedSender instVarNamed: instVarName)) ].
	differentNames do: [ :instVarName |
			differentVariables
				at: instVarName
				put:
					(self class
						 originalSender: (originalSender instVarNamed: instVarName)
						 mutatedSender: (mutatedSender instVarNamed: instVarName)) differentVariables ]
]
