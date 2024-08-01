.data
    prompt_num: .asciiz "Enter a number: "
    prompt_min: .asciiz "Enter the minimum value: "
    prompt_max: .asciiz "Enter the maximum value: "
    result_msg: .asciiz "Sum: "
    invalid_msg: .asciiz "Invalid number! Number is out of range."

.text
.globl main

# ��������� ��������
.globl inputNumber
.globl computeDigitSum
.globl printErrorMessage
.globl printResult

main:
    # ����� ��������� ��� ����� ������������ ��������
    la $a0, prompt_min
    jal inputNumber
    move $t0, $v0       # ��������� ����������� �������� � $t0

    # ����� ��������� ��� ����� ������������� ��������
    la $a0, prompt_max
    jal inputNumber
    move $t1, $v0       # ��������� ������������ �������� � $t1

    # ����� ��������� ��� ����� �����
    la $a0, prompt_num
    jal inputNumber
    move $a0, $v0       # ��������� ��������� ����� � $a0

    # �������� ��������� �����
    blt $a0, $t0, invalid_number
    bgt $a0, $t1, invalid_number

    # ����� ��������� ��� ���������� ����� ���� �����
    move $a0, $v0       # �������� ��������� ����� � $a0 ��� ���������� �����
    jal computeDigitSum
    move $a0, $v0       # �������� ����� � $a0 ��� ������
    la $a0, result_msg
    jal printResult

    # ���������� ���������
    li $v0, 10
    syscall

# ��������� ��� ����� �����
# ��������� ��������: ����� ������ �����������
# ����������: ��������� ����� � $v0
inputNumber:
    li $v0, 4           # ��������� ����� ��� ������ ������
    syscall             # ����� ������ �����������
    li $v0, 5           # ��������� ����� ��� ����� ������ �����
    syscall             # ���� �����
    jr $ra              # ������� �� ���������

# ��������� ��� ���������� ����� ���� �����
# ��������� ��������: ����� ��� ����������
# ����������: ����� ���� ����� � $v0
computeDigitSum:
    move $t2, $a0       # ��������� ������� ����� � $t2
    li $t3, 10          # �������� ��� ���������� ����
    li $t1, 0           # ������������� �����

digit_loop:
    div $t2, $t3        # ������� �� 10
    mfhi $t0            # ������� � $t0
    add $t1, $t1, $t0   # ���������� � �����
    mflo $t2            # ����� ����� ��� �������
    bnez $t2, digit_loop   # ��������� �� 0

    move $v0, $t1       # ���������� ����� � $v0
    jr $ra              # ������� �� ���������

# ��������� ��� ������ ��������� �� ������
printErrorMessage:
    li $v0, 4           # ��������� ����� ��� ������ ������
    la $a0, invalid_msg
    syscall             # ����� ���������
    jr $ra              # ������� �� ���������

# ��������� ��� ������ ����������
# ��������� ��������: ����� ������ ����������
printResult:
    li $v0, 4           # ��������� ����� ��� ������ ������
    syscall             # ����� ������ ����������
    li $v0, 1           # ��������� ����� ��� ������ ������ �����
    syscall             # ����� ����������
    jr $ra              # ������� �� ���������

invalid_number:
    jal printErrorMessage
    j exit_program

exit_program:
    li $v0, 10
    syscall



# example for procedure
	.text
	.globl main
main:
	la $a0, prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0
	
	li $v0, 5
	syscall
	move $a1, $v0
	
	jal find_sum
	move $t0, $v0
	
find_sum:
	move $v0, $a0
	addu $v0, $v0, $a1
	jr $ra

#example for stack

test:
	#save $s0 register on the stack
	sub $sp, $sp, 4 #reserve 4 bytes of stack
	sw $s0, 0($sp)	#save registers
	#now these register can be used
	
	#restore $s0 register from stack
	lw $s0, 0($sp)
	add $sp, $sp, 4
