.data
    prompt_num: .asciiz "Enter a number: "
    prompt_min: .asciiz "Enter the minimum value: "
    prompt_max: .asciiz "Enter the maximum value: "
    result_msg: .asciiz "Sum: "
    invalid_msg: .asciiz "Invalid number! Number is out of range."

.text
.globl main

# Прототипы процедур
.globl inputNumber
.globl computeDigitSum
.globl printErrorMessage
.globl printResult

main:
    # Вызов процедуры для ввода минимального значения
    la $a0, prompt_min
    jal inputNumber
    move $t0, $v0       # Сохраняем минимальное значение в $t0

    # Вызов процедуры для ввода максимального значения
    la $a0, prompt_max
    jal inputNumber
    move $t1, $v0       # Сохраняем максимальное значение в $t1

    # Вызов процедуры для ввода числа
    la $a0, prompt_num
    jal inputNumber
    move $a0, $v0       # Сохраняем введенное число в $a0

    # Проверка диапазона числа
    blt $a0, $t0, invalid_number
    bgt $a0, $t1, invalid_number

    # Вызов процедуры для вычисления суммы цифр числа
    move $a0, $v0       # Передаем введенное число в $a0 для вычисления суммы
    jal computeDigitSum
    move $a0, $v0       # Передаем сумму в $a0 для вывода
    la $a0, result_msg
    jal printResult

    # Завершение программы
    li $v0, 10
    syscall

# Процедура для ввода числа
# Принимает аргумент: адрес строки приглашения
# Возвращает: введенное число в $v0
inputNumber:
    li $v0, 4           # Системный вызов для вывода строки
    syscall             # Вывод строки приглашения
    li $v0, 5           # Системный вызов для ввода целого числа
    syscall             # Ввод числа
    jr $ra              # Возврат из процедуры

# Процедура для вычисления суммы цифр числа
# Принимает аргумент: число для вычисления
# Возвращает: сумму цифр числа в $v0
computeDigitSum:
    move $t2, $a0       # Сохраняем входное число в $t2
    li $t3, 10          # Делитель для вычисления цифр
    li $t1, 0           # Инициализация суммы

digit_loop:
    div $t2, $t3        # Деление на 10
    mfhi $t0            # Остаток в $t0
    add $t1, $t1, $t0   # Добавление к сумме
    mflo $t2            # Новое число для деления
    bnez $t2, digit_loop   # Повторяем до 0

    move $v0, $t1       # Возвращаем сумму в $v0
    jr $ra              # Возврат из процедуры

# Процедура для вывода сообщения об ошибке
printErrorMessage:
    li $v0, 4           # Системный вызов для вывода строки
    la $a0, invalid_msg
    syscall             # Вывод сообщения
    jr $ra              # Возврат из процедуры

# Процедура для вывода результата
# Принимает аргумент: адрес строки результата
printResult:
    li $v0, 4           # Системный вызов для вывода строки
    syscall             # Вывод строки результата
    li $v0, 1           # Системный вызов для вывода целого числа
    syscall             # Вывод результата
    jr $ra              # Возврат из процедуры

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
