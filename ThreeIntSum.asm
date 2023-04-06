# Tilte: Sum three integers
# Filename: ThreeIntSum.asm
# Author: Mario Cerulo
# Date: 06/04/2023
# Input: three integers
# Output: the sum of the three integers

####################### Code Segment #######################
.text 
.global main

main:
	# Read the first integer
	# ReadInt code: 5
	li a7, zero, 5
	ecall
	add s0, zero, a0	# Save the input in s0 register
	
	# Read the second integer
	ecall 
	add s1, zero, a0	# Save the input in s1 register
	
	# Read the third integer
	ecall
	add s2, zero, a0	# Save the input in s2 register
	
	# Sum the three integers
	add s3, s0, s1	# s3 = s0 + s1
	add s3, s3, s2	# s3 = s3 + s2
	
	# Print the sum
	# PrintInt code: 1
	li a7, zero, 1
	add a0, zero, s3 # s0 = s3
	ecall
	
	# Exit the program
	# Exit code: 0
	li a7, zero, 10
	ecall
	