# ORG 5500H

// For initialise respective registers with the multiplicand and multipier of the first term
INITIALIZE:	LDA  5000H	// Loading the Multiplicand into Accumulator
	
	MOV L,A	// Loading HL register pair with H as 00H and L as value in Accumulator
	MVI H,00H
	LXI D,0000H	// Initializing DE register pair with 0000H
	LDA 5001H	// Load Accumulator with Multiplier
	MVI C,08H	// Loading counter C with 8 for 8-bit multiplication
	CALL MULTIPLY // Multiplies A and B
	XCHG	     // Exchanging value at DE register pair with HL,HL now has the first 16 bit addition term
	SHLD 5005H     // Load multiplication result at 5007H and 5008H memory location	
	CALL ADD            // Adds C with A*B
	CALL DVIDE        // Divides A*B+C with 4 and stores the Higher 8 bit result in 5006H and lower 8-bit in 5005H
	HLT
	
// For Multiplication
MULTIPLY:
	RAR	//Rotate the content of the accumulator by one bit towards right with carry flag having LSB
	JNC CONTINUE// Go to Continue on no carry 
	PUSH H	// Store current value of HL in stack
	DAD D	// Add contents of DE to HL
	MOV D,H	// Store the added value in DE
	MOV E,L
	POP H	// loading HL with the stored stack value
	DAD H	// Shifting the contents of HL towards left by one bit
	DCR C
	RZ
	JMP MULTIPLY

// Shift the content of HL register pair, decrement counter and send control back to START
CONTINUE:
	DCR C
	RZ	// Exit loop on counter C = 0
	DAD H
	JMP MULTIPLY// End of Multiplication

ADD:	 
	LDA 5002H 	//Loading second 8 bit addition term into accumulator
	ADD L	// Add lower part of first term with accumulator
	STA 5007H 	//Store lower part addition at 5005H memory location 
	MVI A, 00H 	//Load accumulator with 00H data bit
	ADC H	//Add higher part of first addition term with accumulator with carry of the lower part addition
	STA 5008H	//Store the higher part addition result at 5006H memory location
	RET

DVIDE:	LHLD 5007H  // Loads the 16-bit first term
	MOV A,L	// Store lower part of 16-bit number
	LXI D,0000H      // Counter to count number of subtractions
	CALL LOOP
	MOV A,B
	STA 500BH 	//Store Remainder
	XCHG
	SHLD  5009H // Store Quotient 
	RET

	LOOP:	// Outer loop performs subtraction 
	CPI 04H
	CC LOOP2	// Calls inner loop when accumulator has value less than 04H
	
	
	SUI 04H	// Subtracting 4 from the accumulator
	INX D	// Incrementing counter
	//RZ	// Returns the control to subroutine call in DVIDE
	JMP LOOP


	LOOP2: 	// Inner loop for generating borrow
	MOV B,A
	MOV A,H
	CPI 00H
	JZ EXIT 	// Returns to LOOP when H register is zero
	DCR A	// Decrementing by one bit the higher 8bit part of the 16 bit number 
	MOV H,A
	MOV A,B	
	//CPI 00H 	// To reset flag register
	RET
	EXIT:
	POP H	// Pop out Program counter pointing at next instruction after subroutine call to LOOP2 in LOOP
	RET	//Return to next instruction after call LOOP in DVIDE

// Loading 5000H,5001H and 5002H with 8-bit numbers  A,B and C 
# ORG 5000H
# DB FFH,C3H,8AH
	
	
