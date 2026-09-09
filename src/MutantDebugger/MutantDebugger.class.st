"
I take snapshots of objects before and after test execution to compare mutation differences
"
Class {
	#name : 'MutantDebugger',
	#superclass : 'Object',
	#instVars : [
		'temporaryVariables',
		'context',
		'sender'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'accessing' }
MutantDebugger class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'instance creation' }
MutantDebugger class >> withContext: aContext [

	^ self new
		context: aContext;
		yourself
]

{ #category : 'comparing' }
MutantDebugger >> compareAndDetectChanges [
	self context: thisContext sender.
	self assert: sender = self serializedSender.
	self assert: temporaryVariables = (STON toString: context temporaryVariables) 
]

{ #category : 'initialization' }
MutantDebugger >> context: aContext [
	context := aContext 
]

{ #category : 'accessing' }
MutantDebugger >> serializedSender [

	^ MutantDebuggerSton toString: context receiver
]

{ #category : 'accessing' }
MutantDebugger >> stonSnapshot [

	^ sender 
]

{ #category : 'private' }
MutantDebugger >> takeSender [

	sender := self serializedSender
]

{ #category : 'api' }
MutantDebugger >> takeSnapshot [ 
	self 
		context: thisContext sender;
		takeSender;
		takeTemporaryVariables 
]

{ #category : 'private' }
MutantDebugger >> takeTemporaryVariables [

	
	temporaryVariables := STON toString: context temporaryVariables 
]

{ #category : 'accessing' }
MutantDebugger >> takenSender [
	^ STON fromString: sender
]

{ #category : 'accessing' }
MutantDebugger >> temporaryVariables [ 

	^ STON fromString: temporaryVariables 
]
