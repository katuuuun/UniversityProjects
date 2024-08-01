##################### DATA SEGMENT ##################### 
		.data								# section for data
array:      	
		.space 100   							# Create array
size_prompt:	
		.asciiz 	"Enter the size of the array (max 100): "	# string for communicate
elem_prompt:	
		.asciiz 	"Enter element "				# string for communicate
result_msg: 	
		.asciiz 	"The sum of the array elements is: "		# string for communicate

##################### CODE SEGMENT ##################### 
		.text								# section for code
main:
    # Entry array size
    li $v0, 4									# load const 4 to $v0
    la $a0, size_prompt								# load the address of size_prompt to $a0
    syscall									# syscall for print string
    li $v0, 5									# load const 5 to $v0
    syscall									# syscall for read int
    move $t0, $v0         	 						# copy int to $t0 (read array size)

    # Fill array
    la $t1, array								# load the array address to $t1
    li $t2, 0              							# load the const 0 to $t2(array index = 0)
    
fill_array_loop:
    beq $t2, $t0, sum_array 							# branch to sum_array if $t2 == $t0
    li $v0, 4									# load const 4 to $v0
    la $a0, elem_prompt								# load the address of elem_prompt to $a0
    syscall									# syscall for print string
    li $v0, 5									# load const 5 to $v0
    syscall									# syscall for read int
    sw $v0, 0($t1)          							# store the word in $v0 from array
    addi $t1, $t1, 4        							# $t1 = $t1 + 4 (inc array pointer)
    addi $t2, $t2, 1        							# $t2 = $t2 + 4 (inc array index)
    j fill_array_loop								# jump to fill_array_loop

sum_array:
    li $t3, 0              							# load the const 0 to $t3 (sum array = 0)
    la $t1, array								# load the array addres to $t1
    li $t2, 0              							# load the const 0 to $t2 (array index = 0)
    
sum_loop:
    beq $t2, $t0, print_result  						# branch to print_result if $t2 == $t0
    lw $t4, 0($t1)          							# store the word in $t4 from array 
    add $t3, $t3, $t4       							# $t3 = $t3 + $t4 (calculate sum)
    addi $t1, $t1, 4        							# $t1 = $t1 + 4 (inc array pointer)
    addi $t2, $t2, 1        							# $t2 = $t2 + 4 (inc array index)
    j sum_loop									# jump to sum_loop

print_result:
    li $v0, 4									# load const 4 to $v0
    la $a0, result_msg								# load the address of result_msg to $a0
    syscall									# syscall for print string
    li $v0, 1									# load const 1 to $v0
    move $a0, $t3           							# copy $t3 to $a0 (sum to $a0)
    syscall									# syscall for print int

    li $v0, 10									# load const 10 to $v0
    syscall									# syscall for exit
