##################### DATA SEGMENT ##################### 
	.data							# section for data
prompt:
	.asciiz 	"Please enter three numbers: \n"	# string for communicate
sum_msg:
	.asciiz		"The sum is "				# string for communicate
newline:
	.asciiz		"\n"					# string for communicate
	
##################### CODE SEGMENT ##################### 
	.text							# section for code
	.globl main						# Declare as global the label main
main:
	la	$a0, prompt					# load the address of prompt to $a0
	li	$v0, 4						# load const 4 to $v0
	syscall							# syscall for print string
	
	li	$v0, 5						# load const 5 to $v0
	syscall 						# syscall for read int
	move 	$t0, $v0					# copy int($v0) to $t0 
	
	li	$v0, 5						# load const 5 to $v0
	syscall 						# syscall for read int
	move 	$t1, $v0					# copy int($v0) to $t1
	
	li	$v0, 5						# load const 5 to $v0
	syscall 						# syscall for read int
	move 	$t2, $v0					# copy int($v0) to $t2
	
	#addu	$t0, $t0, $t1					# $t0 = $t0 + $t1
	#addu	$t0, $t0, $t2					# $t0 = $t0 + $t2
	
	la	$a0, sum_msg					# load the address of sum_msg to $a0
	li	$v0, 4						# load const 4 to $v0
	syscall							# syscall for print string
	
	move	$a0, $t0					# copy int($t0) to $a0 (output sum)
	li	$v0, 1						# load const 1 to $v0
	syscall							# syscall for print int
	
	la	$a0, newline					# load the address of newline to $a0
	li	$v0, 4						# load const 4 to $v0
	syscall							# syscall for print string

	li	$v0, 10						# load const 10 to $v0
	syscall							# syscall for exit
