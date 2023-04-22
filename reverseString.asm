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

# Tilte: Reverse a string
# Filename: reverseString.asm
# Author: Mario Cerulo
# Date: 18/04/2023
# Description: Takes a string and print it reversed
# Input: A string
# Output: the string reversed

##################################### Data Segment #####################################
.data
input_prompt: .asciz "inserisci una stringa: "
output_prompt: .asciz "La stringa invertita è: "

string: .space 31
reversed_string: .space 31

##################################### Code Segment #####################################
.text
.global main

main:
	# Print the input prompt
	li 		a7, 4
	la 		a0, input_prompt
	ecall

	# Get the string
	li		a7, 8
	la		a0, string
	li		a1, 31
	ecall
	
	li		s1, 0						# Lenght of the string
	la		s0, string
	mv		t1, s0

str_len:
	lbu		t2, (t1)					# Load a char
	beqz	t2, reverse					# Check if a null-byte
	addi	s1, s1, 1					# Increment the lenght
	addi	t1, t1, 1					
	j		str_len

reverse:
	li		t0, 0						# Counter initialized to zero
	la		t3, reversed_string
	mv 		t1, s0
	add		t3, t3, s1					# Position t3 on the end of the string
	addi	t3, t3, -2

# for(i = 0, j = len - 1; i < len; i++, j--)
loop:	
	addi 	t0, t0, 1
	beq 	t0, s1, exit

	# Copy into the second string
	lbu 	t4, (t1)
	sb		t4, (t3)
	
	addi 	t1, t1, 1
	addi	t3, t3, -1
	j 		loop

exit:
	# Add a 0 byte to the end of the string
	add		t3, t3, s1
	sb		zero, 1(t3)

	# Print the output prompt
	li		a7, 4
	la 		a0, output_prompt
	ecall

	# Print the reversed string
	li		a7, 4
	la		a0, reversed_string
	ecall

	# Exit
	li 		a7, 10
	ecall
