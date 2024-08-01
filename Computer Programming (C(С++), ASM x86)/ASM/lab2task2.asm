        include 'emu8086.inc'
        .model  tiny         
        .code                 
        .org 100h             
start:	 
        mov cx, size          ; значение счётчика цикла в CX
        lea si, mas           ; адрес массива в SI
        xor bx,bx             ; обнуление регистра BX. BX - текущее значение элемента массива 
        
init:                          
        mov sizestep, cx
        CALL scan_num          ; в CX.  
        mov bx, cx
        PRINTN 'next '
        mov cx, sizestep     
        mov [si],bx           ; запись значения BX в текущий элемента массива
        add bx, 2             ; инкремент BX
        add si, 2             ; переход к следующему элементу массива
        loop init             ; повторить цикл пока C!=0
               
        mov cx, size
        lea si, mas
        mov ah,09h            ; функция вывода строки по адресу DX в консоль
        lea dx,msg1           ; адрес строки в DX
        int 21h               ; вывод на экран сообщения msg1
        
        mov cx, size
        lea si, mas
        
even_numbers:         
        mov bx, [si]
        test  bx, 1          
        jnz   Odd             ; ZF=0? !=0
        jz Even               ; =0
     Odd:         
        jmp exit
    Even:
        inc [evens]
        jmp exit
    exit:
        add bx, 2
        add si, 2
        loop even_numbers         
                
        lea si, mas           ; адрес массива в SI
        mov cx, size 
        
show:
        mov ax,[si]           ; считывание элемента массива в AX
        call PRINT_NUM
        PRINT ' '
        add si, 2
        add ax, 2                
        loop show             ; повторить цикл пока C!=0
        PRINTN ''
        
        mov ah,09h            
        lea dx,msg            
        int 21h               
        
        mov ax, evens
        call PRINT_NUM
		ret					 
		
		.data
msg     db      "Even numbers: ", 0Dh, 0Ah, "$"		
msg1    db      "Source array: ", 0Dh, 0Ah, "$"
size    dw      10            ; размер массива	
mas     dw      10 dup (0)    ; исходный массив
evens    dw 0
sizestep dw 0 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
		end start			  