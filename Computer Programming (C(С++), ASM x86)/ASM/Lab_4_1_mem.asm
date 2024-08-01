        include emu8086.inc 
        .model  tiny          ; модель памяти для СОМ
        .code                 ; начало сегмента кода
        .org 100h             ; начальное значение IP = 100h

start:	 
        mov ah, 9h            
        lea dx, msg1          
        int 21h               
 
        call scan_num         ; ввод числа C
        mov C, cx 

        printn ''
              
        lea dx, msg2          
        int 21h               
                
        call scan_num         ; ввод числа D
        mov D, cx 

        printn ''
        
        lea dx, msg3          ; адрес строки в DX
        int 21h               ; вывод строки в консоль
        
        call calc_proc        ; вызов процедуры
                
        call PRINT_NUM        ; вывод результата в консоль   

        ret                   ; возврат управления ОС  
        
calc_proc proc
    ;передача параметров через общую память
        mov dx, D           ; поместить D в aX
        mov bx, C           ; поместить C в bX
        mov ax, D           ; поместить C в bX  
        imul dx 
        mov dx, D
        imul dx
        mov cx, ax     ; in cx d^3
        mov ax, D
        mov dl, 3
        div dl         ; d/3 in ax
        add ax, bx     ; 
        imul ax 
        add ax, cx 
        ret                   ; выход из процедуры
calc_proc endp

        .data
msg1    db "Введите число C:", 0Dh, 0Ah, "$" 
msg2    db "Введите число D:", 0Dh, 0Ah, "$"  
msg3    db "Ответ: ", "$"
C       dw 0
D       dw 0

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM   
DEFINE_PRINT_NUM_UNS
        
        end start