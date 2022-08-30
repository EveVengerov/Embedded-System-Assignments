// Loading outer loop counter
# ORG 5050H

INITIALIZE:	   LXI H,5000
	   MOV D,M
	   DCR D

START:	   LXI H,5000
	   MOV C,D	// Loading inner loop counter
	   INX H
	   DCR D
	   JZ STOP

// Compares adjacent cells and sends to SWAP on no carry otherwise jumps back to START
COMPARE:	   MOV A,M
	   INX H
	   CMP M
	   JNC SWAP
	   DCR C
	   JZ START
	   JMP COMPARE

// Exchange two adjacent memory cells
SWAP:	   MOV B,M
	   MOV M,A
	   DCX H
	   MOV M,B
	   INX H
	   DCR C
	   JNZ COMPARE
	   JZ START

// Terminate program
STOP:	   HLT

// Load data into memory
# ORG 5000H
# DB 08H, 08H,07H,03H,05H,02H,11H,07H,04H
