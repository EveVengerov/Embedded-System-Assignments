#ORG 5000H
	MVI A,80H
	OUT 03H

RECT:
	MVI A,00H
	OUT OOH
	MVI C,FFH
	CALL DELAY
	MVI A,FFH
	OUT 00H
	MVI C,FFH
	CALL DELAY
	JMP RECT

DELAY:	DCR C
	RZ 
	

TRI:
	MVI A,00H

INCR:	OUT 00H
	INR A
	CPI FFH
	JZ DECR
	JMP INCR

DECR:	OUT OOH
	DCR A
	CPI 00H
	JZ INCR
	JMP DECR
	
SAW:
	MVI A,00H
INCR:	OUT 00H
	INR A
	CPI FFH
	JZ SAW
	JMP INCR
