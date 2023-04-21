# MIT License

# Copyright (c) 2023 Mario Cerulo

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

########################################################################################

# Title: Convert a string to uprecase
# Filename: StringToUppercase.asm
# Author: Mario Cerulo
# Date: 18/04/2023
# Description: Converts a given string to uppercase
# Input: A string of ascii characters
# Output: An uppercase string of ascii characters

##################################### Data Segment #####################################
.data 
input_prompt: .asciz "Inserisci una stringa: "
output_prompt: .asciz "La stringa risultante è: "
string: .space 31 				# 30 chars + the null char

##################################### Code Segment #####################################
.text
.global main

main:
	# Ask for a string
	li 		a7, 4
	la 		a0, input_prompt
	ecall

	# Get the string
	li 		a7, 8
	la 		a0, string
	li 		a1, 31
	ecall

	la 		t0, string 			# Load the address of the string in t0
	li 		t1, 'a'
	li 		t2, 'z'

loop:
	lbu 	t3, 0(t0) 			# Load a char in t3
	beqz 	t3, exit_loop 		# If the char is the null character exit the loop
	blt 	t3, t1, no_change 	# If the char is lower than 'a' don't change it
	bgt 	t3, t2, no_change 	# If the char is higher than 'z' dont change it
	addi 	t3, t3, -32 		# Convert to uppercase
	sb 		t3, (t0) 			# Save the result to the string

no_change:
	addi 	t0, t0, 1 			# Increment the pointer
	j 		loop 				# jump to the loop

exit_loop:
	# Print the output prompt
	li 		a7, 4
	la 		a0, output_prompt
	ecall

	# Print the string
	la 		a0, string
	ecall
	
	# Exit 
	li 		a7, 10
	ecall
