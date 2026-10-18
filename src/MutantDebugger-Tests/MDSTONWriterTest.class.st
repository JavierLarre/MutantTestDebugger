"
A MDSTONWriterTest is a test class for testing the behavior of MDSTONWriter
"
Class {
	#name : 'MDSTONWriterTest',
	#superclass : 'TestCase',
	#instVars : [
		'writer'
	],
	#category : 'MutantDebugger-Tests',
	#package : 'MutantDebugger-Tests'
}

{ #category : 'running' }
MDSTONWriterTest >> setUp [
	super setUp.

	writer := MDSTONWriter new
]

{ #category : 'tests' }
MDSTONWriterTest >> testBlacklistedVariablesArentWritten [

	| serializedBank bank blacklist |
	blacklist := { #owner } asSet.
	writer blacklist: blacklist.
	bank := BankAccount new
		        owner: 'blacklist';
		        yourself.

	serializedBank := String streamContents: [ :stream |
			                  writer
				                  on: stream;
				                  nextPut: bank ].

	self assert: serializedBank equals: 'BankAccount{#funds:0}'
]

{ #category : 'tests' }
MDSTONWriterTest >> testSubclassesAreAlsoAffected [

	| serializedBank blacklist |
	blacklist := { #testSelector } asSet.
	writer blacklist: blacklist.

	serializedBank := String streamContents: [ :stream |
			                  writer
				                  on: stream;
				                  nextPut: self ].
			
	self deny: (serializedBank includesSubstring: '#testSubclassesAreAlsoAffected')
]
