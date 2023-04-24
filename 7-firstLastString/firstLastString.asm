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

# Title: first and last string
# Filename: FisrtLastString.asm
# Authot: Mario Cerulo
# Date: 23/04/2023
# Description: scrivere un programma assembly che legge da tastiera 4 stringhe 
# e stampa in output la prima e l’ultima delle stringhe in ordine alfabetico.
# Input: 4 stringhe
# Output: 2 stringhe

##################################### Data Segment #####################################
.data
first_prompt: .asciz "dammi la stringa n.1: "
second_prompt: .asciz "dammi la stringa n.2: "
third_prompt: .asciz "dammi la stringa n.3: "
fourth_prompt: .asciz "dammi la stringa n.4: "

first_output: .asciz "La prima stringa in ordine alfabetico è: "
last_output: .asciz "L'ultima stringa in ordine alfabetico è: "

##################################### Code Segment #####################################
.text
.global main

main:

	# Allocate 100 bytes on the stack
	addi	sp, sp, -100

	# Get the first string
	li		a7, 4
	la		a0, first_prompt
	ecall

	li		a7, 8
	li		a1, 25
	mv		a0, sp
	ecall

	# Get the second string
	li		a7, 4
	la		a0, second_prompt
	ecall

	li		a7, 8
	li		a1, 25
	addi	a0, sp, 25
	ecall

	# Get the third string
	li		a7, 4
	la		a0, third_prompt
	ecall

	li		a7, 8
	li		a1, 25
	addi	a0, sp, 50
	ecall

	# Get the fourth string
	li		a7, 4
	la		a0, fourth_prompt
	ecall

	li		a7, 8
	li		a1, 25
	addi	a0, sp, 75
	ecall

	# Find the first string in alphabetical order
	mv		a0, sp
	jal		ra, first_string

	# Find the last string in alphabetical order
	mv		a0, sp
	jal		ra, last_string

	# Exit
	li		a7, 10
	ecall

first_string:
	# Save the return address on the stack
	addi 	sp, sp, -4
	sw		ra, (sp)

	# Compare the first and the second string
	mv		s0, a0
	addi	a1, sp, 29
	jal		ra, str_cmp
	bltz	a0,	next_str1
	addi	s0, sp, 29

# Compare the first alphabetical string yet to the third string
next_str1:
	mv		a0, s0
	addi	a1, sp, 54
	jal		ra, str_cmp
	bltz	a0, next_str2
	addi	s0, sp, 54

# Compare the first alphabetical string yet to the fourth string
next_str2:
	mv		a0, s0
	addi	a1, sp, 79
	jal		ra, str_cmp
	bltz	a0, print_first
	addi	s0, sp, 79

print_first:
	li 	a7, 4
	la	a0, first_output
	ecall

	mv		a0, s0
	ecall

	lw		ra, (sp)
	addi	sp, sp, 4

	jalr	zero, ra, 0

last_string:
	addi	sp, sp, -4
	sw		ra, (sp)

	# Compare the first and the second string
	mv		s0, a0
	addi	a1, sp, 29
	jal		ra, str_cmp
	bgtz	a0, next_str3
	addi	s0, sp, 29

# Compare the last alphabetical string yet to the third string
next_str3:
	mv		a0, s0
	addi	a1, sp, 54
	jal		ra, str_cmp
	bgtz	a0, next_str4
	addi	s0, sp, 54

# Compare the last alphabetical string yet to the fourth string
next_str4:
	mv 		a0, s0
	addi	a1, sp, 79
	jal		ra, str_cmp
	bgtz	a0, print_last
	addi	s0, sp, 79

print_last:
	li		a7, 4
	la		a0, last_output
	ecall

	mv		a0, s0
	ecall

	# Return to main
	lw		ra, (sp)
	addi	sp, sp, 4

	jalr	zero, ra, 0


str_cmp:

	lbu		t0, (a0)
	lbu		t1, (a1)
	bne		t0, t1, different
	beqz	t0, ended				# If the 2 char are equals and equals to 0 the two strings are the same
	addi	a0, a0, 1
	addi	a1, a1, 1
	j		str_cmp

different:
	blt		t0, t1, less
	bge		t0, t1, greater

# If the two strings are the same return 0
ended:
	li		a0, 0
	jalr	zero, ra, 0

# If the first string is less than the second return -1
less:
	li		a0, -1
	jalr	zero, ra, 0

# If the first string in greater than the second return 1
greater:
	li		a0, 1
	jalr	zero, ra, 0
