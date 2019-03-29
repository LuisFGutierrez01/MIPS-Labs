# Luis Gutierrez

.data
Array:  .word 43, -5, 11, 12, 64, -7, 14, 71, 70, 13, -27
string:  .asciiz "\n" 

# Tranfer the C code of selection sort to MIPS code. Do not modify the existing code and structure!

.text 
main:	
	la $t0, Array
	li $t1, 0			# this is i?, and the beginning of the array
	li $t7,11   			# array length n=11 (hard coded)
	mul $t7, $t7, 4 		# 4*n (pointer)
	subi $t8, $t7, 4 	# 4*(n-1) (pointer)

OuterLoop:
	add $t2, $t1, 4		# sets the j pointer at the beginning of the outer loop
	
# write your code here for Selection Sort	
InnerLoop:
	# loads data from arrays at i and j and compares them, sorts them if they are off
	lw 	$a0, Array($t1)		# a[ i ]
	lw  	$a1, Array($t2)		# a[ j ]
	bgt 	$a0, $a1, Sort			# if a[ i ] > a[ j ]
	
AfterSort:
	# increments j, and sends it to the next iteration if still within bounds
	addi $t2, $t2, 4				# j++ pointer
	blt  	$t2, $t7, InnerLoop		# if j < n 		
	
	# increments i, and sends it to the next iteration if still within bounds
	addi 	$t1, $t1, 4			# i ++ pointer
	blt	$t1, $t8, OuterLoop	# if i < n-1
	addi $t1, $zero, 0				# sets i pointer to 0
	j PrintResults					#skips the last sort if you are done with the loop
	
# sorting algorithm
Sort:
	addi $t3, $a0, 0 			# temp = a[ i ]
	sw	$a1, Array($t1)		# a[ i ] = a[ j ]
	sw 	$t3 , Array($t2)		# a[ j ] = temp
	j AfterSort
	
# write your code here to print the sorted array/result 
PrintResults:
	lw	$a0, Array($t1)		# loads a [ i ] into $a0 
	li	$v0, 1				# displays $a0
	syscall

  	la	 $a0, string
   	li	 $v0, 4				#prints a new string
	syscall

	addi $t1, $t1, 4			# next iteration of i
	blt	$t1, $t7, PrintResults	# loops if still within bounds
	 
# exit	
addi $v0, $zero, 10
syscall 

		

