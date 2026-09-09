Class {
	#name : 'BankAccount',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'funds'
	],
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'as yet unclassified' }
BankAccount >> deposit: amount [
	funds := funds + amount 
]

{ #category : 'accessing' }
BankAccount >> funds [

	^ funds
]

{ #category : 'initialization' }
BankAccount >> initialize [ 
	super initialize.
	funds := 0.
	owner := ''
]

{ #category : 'accessing' }
BankAccount >> owner [

	^ owner
]

{ #category : 'accessing' }
BankAccount >> owner: anObject [

	owner := anObject
]

{ #category : 'as yet unclassified' }
BankAccount >> withdraw: amount [
	funds < amount ifTrue: [ self error: 'insufficent funds' ].
	funds := funds - amount 
]
