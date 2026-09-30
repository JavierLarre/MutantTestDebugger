Class {
	#name : 'MDTestSnapshotter',
	#superclass : 'TestCase',
	#instVars : [
		'mutant'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'accessing' }
MDTestSnapshotter class >> mutant: aMethodMutation [
	
	^ self new
		mutant: aMethodMutation;
		yourself
]

{ #category : 'accessing' }
MDTestSnapshotter >> mutant [

	^ mutant
]

{ #category : 'accessing' }
MDTestSnapshotter >> mutant: anObject [

	mutant := anObject
]

{ #category : 'ston persistence' }
MDTestSnapshotter >> stonOn: aStonWriter [

	| tempMutant |
	tempMutant := mutant.
	mutant := nil.
	[ super stonOn: aStonWriter ] ensure: [ mutant := tempMutant ] 
]

{ #category : 'running' }
MDTestSnapshotter >> tearDown [
	MutantDebugger uniqueInstance takeSnapshotFromMutant: mutant inTest: self.
	super tearDown
]
