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
	