# ORG 5000H
	   MVI A,98	// Set Port A and Cupper as input, CLower as output
	   OUT 03	// Write control word 8255-I to control Word
	
	   MVI A,02	// Clear the accumulator
	   OUT 01	// Send the content of Acc to Port B to select IN1

// START PULSE fo ALE
	   MVI A,02	// Load the accumulator with 02H
	   OUT 02	// ALE and SOC will be 0
	   XRA A	// Clear the accumulator
	   OUT 02	// ALE and SOC will be low.

// START PULSE FOR START OF CONVERSION
	   MVI A,01
	   OUT 02
	   XRA A
	   OUT 02

EOC:	   IN 02	// Read from EOC (PC4)
	   ANI 10	// To check C4 is 1.
	   JZ EOC	// If C4 is not 1, go to EOC

// OE Enabled
	   MVI A,04
	   OUT 02
	   IN 00	// Read digital output of ADC
	   STA 6000	// Save result at 6000H
	   HLT	// Stop the program
