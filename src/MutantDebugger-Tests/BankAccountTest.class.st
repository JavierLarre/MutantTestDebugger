Class {
	#name : 'BankAccountTest',
	#superclass : 'TestCase',
	#instVars : [
		'account'
	],
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'running' }
BankAccountTest >> setUp [
	super setUp.

	account := BankAccount new
]

{ #category : 'tests' }
BankAccountTest >> testDeposit [

	account deposit: 100.
	self assert: account balance equals: 100
]

{ #category : 'tests' }
BankAccountTest >> testInitialFunds [

	self assert: account balance equals: 0
]

{ #category : 'tests' }
BankAccountTest >> testWithdraw [

	account 
		deposit: 100;
		withdraw: 100.
	self assert: account balance equals: 0 
]

{ #category : 'tests' }
BankAccountTest >> testWithdrawTooMuch [

	self should: [ account withdraw: 1 ] raise: Error 
]
