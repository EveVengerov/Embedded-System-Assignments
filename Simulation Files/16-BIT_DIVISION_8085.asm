# ORG 5000H

INITIALIZE:	   LDA 4000
	   MOV L,A	// Load L register with High-order part of dividend
	   MVI H,00	// Load H register with 00H
	   LDA 4002	// Load Accumulator with Divisor
	   MOV B,A	// Load B with Divisor
	   MVI C,08	// Load counter with 8 for 8-bit division
	   CALL START	// Loop to divide high-order dividend with divisor
	   LDA 4001
	   MOV L,A	// Load L register with Low-order part of dividend
	   MVI C,08	// Load counter with 8 for 8-bit division
	   XCHG
	   DAD H	// Shifting Quotient towards left by one-bit before next division
	   XCHG
	   CALL START	// Loop to divide high-order dividend with divisor
	   MOV A,H
	   STA 4006	// Load memoery location 4006H with Remainder
	   XCHG
	   SHLD 4003	// Load memoery location 4003H with low-order Quotient and 4004H with High-order Quotient
	   HLT

// Loop to perform 8-bit with 8-bit division
START:	   DAD H	// Shift HL register pair towards left by 1
	   MOV A,H
	   SUB B
	   CNC INCREMENT	// I f Accumulator >= Divisor go to INCREMENT
	   DCR C
	   RZ
	   XCHG
	   DAD H	// Shift DE register pair towards left by 1
	   XCHG
	   JMP START

INCREMENT:	   MOV H,A
	   INX D
	   RET
# ORG 4000H

// Dividend: C2C7H, Divisor: 09H
# DB F8H,11H,14H
