Class {
	#name : #GtMagritteDummyServer,
	#superclass : #Object,
	#instVars : [
		'name',
		'status',
		'port',
		'announcer',
		'readOnlyMode'
	],
	#category : #'GToolkit4Magritte-Examples-Support - Server'
}

{ #category : #defaults }
GtMagritteDummyServer class >> runningStatus [
	^ #running
]

{ #category : #defaults }
GtMagritteDummyServer class >> stoppedStatus [
	^ #stopped
]

{ #category : #testing }
GtMagritteDummyServer >> ifRunning: runningBlock ifStopped: idleBlock [
	self isRunning ifTrue: [ 
		^ runningBlock cull: self ].
		
	self isStopped ifTrue: [
		^ idleBlock cull: self ]
]

{ #category : #initialization }
GtMagritteDummyServer >> initialize [
	super initialize.
	
	announcer := Announcer new.

	name := 'My Server'.
	status := self class stoppedStatus.
	port := 0.
	readOnlyMode := false.
]

{ #category : #testing }
GtMagritteDummyServer >> isRunning [
	^ self status = self class runningStatus
]

{ #category : #testing }
GtMagritteDummyServer >> isStopped [
	^ self status = self class stoppedStatus
]

{ #category : #accessing }
GtMagritteDummyServer >> name [
	^ name
]

{ #category : #accessing }
GtMagritteDummyServer >> name: anObject [
	name := anObject
]

{ #category : #magritte }
GtMagritteDummyServer >> nameDescription [
	<magritteDescription>
	
	^ MAStringDescription new 
		label: 'Name';
		comment: 'Server name';
		accessor: #name;
		default: 'My server';
		visible: true;
		priority: 1 
]

{ #category : #accessing }
GtMagritteDummyServer >> port [
	^ port
]

{ #category : #accessing }
GtMagritteDummyServer >> port: aNumber [
	port = aNumber ifTrue: [ ^ self ].

	port := aNumber.
	
	announcer announce: (GtMagritteDummyServerPortChangedAnnouncement new 
		server: self;
		port: aNumber)
]

{ #category : #magritte }
GtMagritteDummyServer >> portDescription [
	<magritteDescription>
	
	^ MANumberDescription new 
		label: 'Port';
		comment: 'Server listening port (can be changed only when server is stopped)';
		accessor: #port;
		beInteger;
		default: 0;
		min: 0;
		max: 16rFFFF;
		visible: true;
		priority: 3;
		updateOn: GtMagritteDummyServerPortChangedAnnouncement 
			from: announcer;
		updateDescription: #readOnly:
			as: #isRunning
			on: GtMagritteDummyServerStatusChangedAnnouncement 
			from: announcer
]

{ #category : #accessing }
GtMagritteDummyServer >> readOnlyMode [
	^ readOnlyMode
]

{ #category : #accessing }
GtMagritteDummyServer >> readOnlyMode: anObject [
	readOnlyMode := anObject
]

{ #category : #magritte }
GtMagritteDummyServer >> readOnlyModeRequestDescription [
	<magritteDescription>
	
	^ MABooleanDescription new 
		label: 'Read-only';
		comment: 'Server accepts or reject update requests (can be changed at any time and is auto-accepted)';
		trueString: 'accept update requests';
		falseString: 'reject update requests';
		accessor: #readOnlyMode;
		default: false;
		visible: true;
		priority: 5;
		autoAccept: true
]

{ #category : #actions }
GtMagritteDummyServer >> start [
	self isRunning ifTrue: [ ^ self ].
	self port isZero ifTrue: [ 
		self port: (10000 to: 65000) atRandom ].
	self status: self class runningStatus.
]

{ #category : #magritte }
GtMagritteDummyServer >> startAndStopActionDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new 
		priority: 30;
		blocIcon: self startStopBlocIcon;
		label: self startStopLabel;
		comment: 'Start and stop server';
		beToolbarAction;
		updateDescription: #blocIcon:
			as: #startStopBlocIcon
			on: GtMagritteDummyServerStatusChangedAnnouncement 
			from: announcer;
		updateDescription: #label:
			as: #startStopLabel
			on: GtMagritteDummyServerStatusChangedAnnouncement 
			from: announcer;
		action: (GtMagritteAction new 
			beInFutureProcess;
			action: [ :theServer :aButton :aMemento :aDescription |
				theServer 
					ifRunning: #stop
					ifStopped: #start. ]);
		onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription |
				aStatus isChanged
					ifTrue: [ aDescription enabled: false ]
					ifFalse: [ aDescription enabled: aStatus isValidAndInactive ] ])
]

{ #category : #magritte }
GtMagritteDummyServer >> startStopBlocIcon [
	^ self
		ifRunning: [ BrGlamorousVectorIcons cancel  ] 
		ifStopped: [ BrGlamorousVectorIcons play ]
]

{ #category : #magritte }
GtMagritteDummyServer >> startStopLabel [
	^ self
		ifRunning: [ 'Stop'  ] 
		ifStopped: [ 'Start' ]
]

{ #category : #accessing }
GtMagritteDummyServer >> status [
	^ status
]

{ #category : #accessing }
GtMagritteDummyServer >> status: aStatus [
	status = aStatus ifTrue: [ ^ self ].

	status := aStatus.
	
	announcer announce: (GtMagritteDummyServerStatusChangedAnnouncement new 
		server: self;
		status: aStatus)
]

{ #category : #magritte }
GtMagritteDummyServer >> statusDescription [
	<magritteDescription>
	
	^ MAStringDescription new 
		label: 'Status';
		comment: 'Server status, e.g., running, idle';
		accessor: #status;
		default: 'unknown';
		beReadOnly;
		visible: true;
		priority: 2;
		updateOn: GtMagritteDummyServerStatusChangedAnnouncement from: announcer
]

{ #category : #actions }
GtMagritteDummyServer >> stop [
	self isStopped ifTrue: [ ^ self ].
	self status: self class stoppedStatus.
]

{ #category : #subscriptions }
GtMagritteDummyServer >> when: anAnnouncement send: aSelector to: aReceiver [
	^ announcer weak
		when: anAnnouncement
		send: aSelector
		to: aReceiver
]
