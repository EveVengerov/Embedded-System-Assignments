# ORG 5500H

// For initialise respective registers with data  
INITIALIZE:	LDA  5000H	// Loading the Multiplicand into Accumulator
	MOV L,A	// Loading HL register pair with H as 00H and L as value in Accumulator
	MVI H,00H
	LXI D,0000H	// Initializing DE register pair with 0000H DE stores the Product
	LDA 5001H	// Load Accumulator with Multiplier
	MVI C,08H	// Loading counter C with 8 for 8-bit multiplication
	CALL START
	XCHG	// Exchanging value at DE register pair with HL
	SHLD 5003H// Loading content of the HL Pair at memory location as,  L at 5003H and H at 5004H
	HLT

	
// For Multiplication
START:	RAR	//Rotate the content of the accumulator by one bit towards right with carry flag having LSB
	JNC CONTINUE// Go to Continue on no carry 
	PUSH H	// Store current value of HL in stack
	DAD D	// Add contents of DE to HL(DE contains partial poduct, HL contains Multiplicand)
	MOV D,H	// Store the added value in DE
	MOV E,L
	POP H	// loading HL with the stored stack value 
// Shift the content of HL register pair, decrement counter and send control back to START
CONTINUE:
	DAD H
	DCR C
	RZ 	// Exit loop on counter C = 0
	JMP START

// End of Multiplication


// Loading 5000H,5001H Memory location with Multiplicand and Multiplier
# ORG 5000H
# DB 58H,07H
	
	
