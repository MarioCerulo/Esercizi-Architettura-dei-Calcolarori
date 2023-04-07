# Title: sum N Integer
# Filename: sumNInts.asm
# Author: Mario Cerulo
# Date: 07/04/2023
# Description: Takes how many integers you want to sum and the numbers to sum
# and outputs the sum
# Input: number N of integers, the integers to sum
# Output: The sum of the N integers 

################################## Data Segment ##################################
.data
input_prompt: .asciz "Quanti numeri vuoi inerire? "
numbers_prompt: .asciz "Inserirci un intero: "
output_prompt: .asciz "Somma dei numeri: "

################################## Code Segment ##################################
.text
.global main

main:
	# Prints the input_prompt string
	# PrintString code: 4
	li a7, 4
	la a0, input_prompt
	ecall
	# Read the number of int to sum
	# ReadInt code: 5
	li a7, 5
	ecall 
	add s0, zero, a0
	add s1, zero, zero # Initialize the sum register to 0
	add t0, zero, zero # Initialize the counter to 0
	bne s0, zero, loop # Enter the loop
	beqz s0, exit 
	
	
loop:
	# Increment the counter
	addi t0, t0, 1
	
	# Ask for an int
	li a7, 4
	la a0, numbers_prompt
	ecall
	
	# Read an int
	li a7, 5
	ecall
	
	# Sum of the integers
	add s1, s1, a0
	
	# Loop handling
	beq t0, s0, exit
	bne t0, s0, loop
	
exit:
	# Prints the output prompt
	li a7, 4
	la a0, output_prompt
	ecall
	
	# Prints the sum
	li a7, 1
	add a0, zero, s1
	ecall
	
	# Exit the program
	li a7, 10
	ecall
	
	