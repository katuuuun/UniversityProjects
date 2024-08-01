     include 'emu8086.inc'
    .model tiny
    .code
    .org 100h

start: 

	mov ah, 09h                 ;Вывод строки
	lea dx, msg_1               ;Строка
	int 21h                     ;Прерывание

	mov ah, 0Ah                 ;Ввод с клавиатуры
	lea dx, Source              ;Запись в Source
	int 21h
	      
	printn '' 
	
	mov ah, 09h                 ;Вывод строки
	lea dx, msg_Source          ;Строка
	int 21h                     ;Прерывание
	  
	mov ah, 09h                 ;Вывод строки
	lea dx, Source              ;Строка
	add dx, 2                   ;Смещение
	int 21h                     ;Прерывание   
	
    ;prepare transfer
    mov cx, 20       ; Счетчик
	mov si, 1 
	mov bl, 1
	
transfer:
	mov al, Source[si+1]
	cmp bl, 1
	je word1
	cmp bl, 2
	je word2
	cmp bl, 3 
	je word3
	cmp bl, 4
	je word4
	cmp bl, 5
	je word5

    word1:
    cmp al, 32
	je endword
	mov word1_s[si], al
	inc w1_c
	inc si
	jmp exit
	
	word2:
	cmp al, 32
	je endword
	mov word2_s[si], al
	inc w2_c
	inc si
	jmp exit
	
	word3:
	cmp al, 32
	je endword
	mov word3_s[si], al
	inc w3_c
	inc si
	jmp exit
	
	word4:
	cmp al, 32
	je endword
	mov word4_s[si], al
	inc w4_c
	inc si
	jmp exit
	
	word5:
	cmp al, 32
	je endword
	mov word5_s[si], al
	inc w5_c
	inc si
	jmp exit
	
	endword:
	inc bl
	inc si
	inc word_counter
	exit:
	loop transfer     
	
	printn ''
	print 'Enter word number to delete: '
	call SCAN_NUM
	mov bx, cx 
	
	printn ''
	mov ah, 09h                 ;Вывод строки
	lea dx, msg_Converted       ;Строка
	int 21h                     ;Прерывание 
	
	cmp cx, 1
	je skip1
	printn ''
	mov ah, 09h                 ;Вывод строки
	lea dx, word1_s             ;Строка 
	add dx, 1
	int 21h                     ;Прерывание  

skip1:	
	cmp bx, 2
	je skip2	
	print ' '
	mov ah, 09h                 ;Вывод строки
	lea dx, word2_s             ;Строка
	add dx, 2
	add dx, w1_c 
	int 21h                     ;Прерывание 

skip2:
    cmp bx, 3
    je skip3	
	print ' '
	mov ah, 09h                 ;Вывод строки
	lea dx, word3_s             ;Строка
	add dx, 3
	add dx, w1_c 
	add dx, w2_c 
	int 21h                     ;Прерывание

skip3:
	cmp bx, 4
	je skip4
	cmp word_counter, 0
    je skip4
	print ' '
	mov ah, 09h                 ;Вывод строки
	lea dx, word4_s             ;Строка
	add dx, 4
	add dx, w1_c
	add dx, w2_c
	add dx, w3_c 
	int 21h                     ;Прерывание
	
skip4:
    cmp bx, 5
    je skip5
    cmp word_counter, 1
    je skip5	
	print ' '
	mov ah, 09h                 ;Вывод строки
	lea dx, word5_s             ;Строка
	add dx, 5
	add dx, w1_c
	add dx, w2_c
	add dx, w3_c
	add dx, w4_c  
	int 21h                     ;Прерывание
	 
skip5:  
    ret
      
    .data 
msg_1               db "Input string (length=20): ", 0Dh, 0Ah, '$' 
Source              db 21,0,22 dup('$')
Converted           db 21,0,22 dup('$')
word1_s               db   21,0,22 dup('$') 
word2_s               db  21,0,22 dup('$')
word3_s               db  21,0,22 dup('$')
word4_s               db  21,0,22 dup('$')
word5_s               db  21,0,22 dup('$') 
word6_s               db  21,0,22 dup('$')
w1_c dw 0
w2_c dw 0 
w3_c dw 0 
w4_c dw 0 
w5_c dw 0
word_counter dw 0 
msg_Source          db "Source string: ", '$'
msg_Converted       db "Converted string: ", '$'

DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS
end start