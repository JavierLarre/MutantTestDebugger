Class {
	#name : 'MTSnapshotOperator',
	#superclass : 'MTParseRewriterMutantOperator',
	#instVars : [
		'mutation'
	],
	#category : 'MutantDebugger',
	#package : 'MutantDebugger'
}

{ #category : 'printing' }
MTSnapshotOperator >> description [ 
	^ 'Injects snapshot before mutation: ', mutation description 
]

{ #category : 'applying' }
MTSnapshotOperator >> expressionToReplace [ 

	^ mutation expressionToReplace 
]

{ #category : 'accessing' }
MTSnapshotOperator >> mutation: aMutation [

	mutation := aMutation 
]

{ #category : 'applying' }
MTSnapshotOperator >> newExpression [ 

	^ String streamContents: [ :stream | 
		stream 
			<< '[ ';
			<< 'MutantDebugger uniqueInstance takeSnapshot. ';
			<< mutation newExpression;
			<< ' ] value' ]
]
