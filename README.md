# GToolkit Magritte
Magritte implementation for Glamorous Toolkit.

## Installation

```Smalltalk
[
EpMonitor current disable.
NonInteractiveTranscript stdout install.
[ Metacello new
  baseline: 'GToolkit4Magritte';
  repository: 'github://feenkcom/gt4magritte:main/src';
  load  ] ensure: [ 
  	EpMonitor current enable.
  	GtTranscript installDefault ].

] forkAt: Processor userBackgroundPriority named: 'Magritte Metacello'.
```
