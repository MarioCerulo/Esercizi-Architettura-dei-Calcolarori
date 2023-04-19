# Title: Sort an array of three integers
# Filename: bubbleSort.asm
# Author: Mario Cerulo
# Date: 18/04/2023
# Description: Sort an array using the bubble sort algorithm
# Input: Three numbers
# Output: A sorted array

##################################### Data Segment #####################################
.data
array: .word 3 # Array of 3 elements 

input_prompt: .asciz "Inserisci tre interi:\n"
output_prompt: .asciz "I numeri ordinati sono:\n"
separator: .asciz " - "

##################################### Code Segment #####################################
.text 
.global main

main:
	la 		s0, array	# Load the address of the array

	# Print the input prompt
	li 		a7, 4
	la 		a0, input_prompt
	ecall

	# Input
	li 		a7, 5
	ecall
	sw		a0, 0(s0)	# Save the first int in the first position of the array
	ecall
	sw		a0, 4(s0)	# Save the second int in the second position of the array
	ecall
	sw		a0, 8(s0)	# Save the third int in the third position of the array

	li 		t0, 0 		# Counter of the outer loop initialized to 0
	li		t2, 3		# Upper bound of the loop

outer_loop:
	addi 	t0, t0, 1 
	beq		t0, t2, exit
	li		t1, 0		# Counter of the inner loop initialized to 0
	mv		t3, s0

inner_loop:
	addi 	t1, t1, 1	# Increasing the counter of the inner loop
	beq		t1, t2, outer_loop
	lw		t4, 4(t3)
	lw		t5, 0(t3)
	blt		t4, t5, swap
	addi	t3, t3, 4	# Position t3 on the second element of the array
	j inner_loop

swap:
	lw 		t4, 0(t3)
	lw 		t5, 4(t3)
	sw		t5, 0(t3)
	sw		t4, 4(t3)
	addi	t3, t3, 4	# Position t3 on the second element of the array
	j inner_loop

exit:

	# Print the output prompt
	li a7, 4
	la a0, output_prompt
	ecall

	# Print the array
	li a7, 1
	lw a0, 0(s0)
	ecall

	li a7, 4
	la a0, separator
	ecall
	
	li a7, 1
	lw a0, 4(s0)
	ecall

	li a7, 4
	la a0, separator
	ecall

	li a7, 1
	lw a0, 8(s0)
	ecall

	# Exit
	li a7, 10
	ecall
