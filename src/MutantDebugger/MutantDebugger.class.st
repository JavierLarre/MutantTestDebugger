Class {
	#name : 'MutantDebugger',
	#superclass : 'Object',
	#instVars : [
		'temporaryVariables',
		'context',
		'sender'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'as yet unclassified' }
MutantDebugger >> compareAndDetectChanges [
	self setContext: thisContext sender.
	self assert: sender = self serializedSender.
	self assert: temporaryVariables = (STON toString: context temporaryVariables) 
]

{ #category : 'as yet unclassified' }
MutantDebugger >> serializedSender [

	^ MutantDebuggerSton toString: context receiver
]

{ #category : 'initialization' }
MutantDebugger >> setContext: aContext [
	context := aContext 
]

{ #category : 'accessing' }
MutantDebugger >> snapshotTaken [
	^ STON fromString: sender
]

{ #category : 'as yet unclassified' }
MutantDebugger >> stonSnapshot [

	^ sender 
]

{ #category : 'as yet unclassified' }
MutantDebugger >> takeSender [

	sender := self serializedSender
]

{ #category : 'accessing' }
MutantDebugger >> takeSnapshot [ 
	self 
		setContext: thisContext sender;
		takeSender;
		takeTemporaryVariables 
]

{ #category : 'as yet unclassified' }
MutantDebugger >> takeTemporaryVariables [

	
	temporaryVariables := STON toString: context temporaryVariables 
]

{ #category : 'as yet unclassified' }
MutantDebugger >> temporaryVariables [ 

	^ STON fromString: temporaryVariables 
]
