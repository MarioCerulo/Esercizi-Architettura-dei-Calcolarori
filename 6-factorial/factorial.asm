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

# Title: factorial array
# Filename: factorial.asm
# Author: Mario Cerulo
# Date: 23/04/2023
# Description: Given an array of N int output the array made by the factorial
# of the given numbers
# Input: the number of int, the ints to be inserted in the array
# Output: an array made by the factorial of the int

##################################### Data Segment #####################################
.data
dimension_prompt: .asciz "Quanti numeri vuoi inserire? "
numbers_prompt: .asciz "Inserisci i numeri:\n"
output_prompt: .asciz "I fattoriali sono: "
separator: .asciz " - "

array: .word 20

##################################### code Segment #####################################
.text
.global main

main:
	# Ask how many numbers insert
	li		a7, 4
	la		a0, dimension_prompt
	ecall

	# Input of the number of ints to insert
	li		a7, 5
	ecall
	mv		s0, a0						# Dimension of the array

	li 		t0,	0						# Counter initialized to 0
	la		s1, array

	li		a7, 4
	la		a0, numbers_prompt
	ecall

fill_array:
	addi	t0, t0, 1

	# Input of a number
	li		a7, 5
	ecall
	sw		a0, (s1)					# Save the number in the array

	addi	s1, s1, 4
	beq		t0, s0, factorial
	j		fill_array

factorial:
	li		t0, 0
	la		s1, array

outer_loop:
	addi	t0, t0, 1
	li		t1, 0						# Counter of inner loop set to zero
	lw		t2, (s1)
	li		t3, 1						# Factorial number
	jal		ra, inner_loop
	sw		t3, (s1)					# Save the factorial in the array
	addi	s1, s1, 4					# Move to the next int
	beq		t0, s0, print
	j outer_loop

# for(i = 0; i = x; i++)
inner_loop:
	addi	t1, t1, 1
	mul		t3, t3, t1					# fact = fact*i
	beq		t1, t2, exit_loop
	j		inner_loop

exit_loop:
	jalr	zero, ra, 0

print:
	li		t0, 0
	la		s1, array

	# Print the output prompt
	li		a7, 4
	la		a0, output_prompt
	ecall

print_loop:
	addi	t0, t0, 1
	
	# Print an element of the array
	li		a7, 1
	lw		a0, (s1)
	ecall

	beq		t0, s0, exit				# Exit condition

	# Print the separator
	li 		a7, 4
	la		a0, separator
	ecall

	addi	s1, s1, 4
	j		print_loop

exit:
	li a7, 10
	ecall
