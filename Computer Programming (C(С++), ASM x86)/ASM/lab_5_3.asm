
        .model  tiny          ; модель памяти для СОМ
        .code                 ; начало сегмента кода
        .org 100h             ; начальное значение IP = 100h

        mov ax, @data         ; адрес сегмента данных
        mov es, ax            ; помещается в ES

        mov ah, 13h           ; номер функции BIOS
        mov al, 1h            ; атрибуты в BL, переместить курсор в конец строки после вывода
        mov dh, 0h            ; позиция для вывода: строка
        mov dl, 0h            ; позиция для вывода: столбец       
        mov cx, len_1          ; длина строки в CX
        mov bl, 00001111b        
        lea bp, msg_1          ; адрес строки в DX
		int 10h               ; вывод строки в консоль
		add dh, 1h
		mov cx, len_3          ; длина строки в CX
        mov bl, 00001111b        
        lea bp, msg_3          ; адрес строки в DX
		int 10h               ; вывод строки в консоль
 
start:	 
        mov ah, 0h            ; номер функции BIOS (83/84-клавиши)
        int 16h               ; ввод клавиши. ASCII-код в AH, скан код в AL
        
        mov bx, ax
        cmp bl, 1Bh           ; ESC?
        je exit               
        cmp bl, 0Dh           ; Enter?
        je exit               

        mov ah, 13h           ; номер функции BIOS
        mov al, 1h            ; атрибуты в BL, переместить курсор в конец строки после вывода
        mov cx, 9             ; длина строки в CX
        mov dh, row           ; позиция для вывода: строка
        mov dl, 3h            ; позиция для вывода: столбец

        cmp bx, 1051h        ; нажата Shift + Q
        je Q
        
        cmp bx, 1157h        ; нажата Shift + W
        je W

        cmp bx, 1245h        ; нажата Shift + E
        je E

        cmp bx, 1352h        ; нажата Shift + R
        je R
        
        jmp start             ; бесконечный цикл
    
    Q:
        xor bh, bh
        mov bl, 11110000b          
        lea bp, text_Q        
        int 10h                
        inc row
        jmp start
    W:
        xor bh, bh
        mov bl, 00001101b          
        lea bp, text_W        
        int 10h                
        inc row
        jmp start
    E:
        xor bh, bh
        mov bl, 10101000b          
        lea bp, text_E        
        int 10h                
        inc row
        jmp start
    R:
        xor bh, bh
        mov bl, 00011111b           
        lea bp, text_R        
        int 10h               ; вывод строки  
        inc row
        jmp start

exit:   
        mov ah, 13h           ; номер функции BIOS
        mov al, 1h            ; атрибуты в BL, переместить курсор в конец строки после вывода
        mov dh, row           ; позиция для вывода: строка
        mov dl, 0h            ; позиция для вывода: столбец       
        mov cx, len_2         ; длина строки в CX
        xor bh, bh        
        mov bl, 00001111b        
        lea bp, msg_2         ; адрес строки в DX
		int 10h               ; вывод строки в консоль
        
        mov ah, 8h            ; номер функции DOS
        int 21h               ; ожидание нажатия клавиши

        ret                   ; возврат управления ОС  
       
        .data
msg_1   db "Программа преобразовывает сочетания клавиш: "
len_1   dw $-msg_1
msg_3   db "«Shift + Q», «Shift + W», «Shift + E», «Shift + R»"
len_3   dw $-msg_3             
msg_2   db "Для выхода нажмите любую клавишу..."
len_2   dw $-msg_2  
text_Q db "Shift + Q"  
text_W db "Shift + W"
text_E db "Shift + E"
text_R db "Shift + R"
row     db 2
        end start			   
