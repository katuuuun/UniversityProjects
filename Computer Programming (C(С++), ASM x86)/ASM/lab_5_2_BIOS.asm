
        .model  tiny          ; модель памяти для СОМ
        .code                 ; начало сегмента кода
        .org 100h             ; начальное значение IP = 100h

        mov ax, @data         ; адрес сегмента данных
        mov es, ax            ; помещается в ES

        mov ah, 13h           ; номер функции BIOS
        mov al, 1h            ; атрибуты в BL, переместить курсор в конец строки после вывода
        mov dh, 0h            ; позиция для вывода: строка
        mov dl, 0h            ; позиция для вывода: столбец       
        mov cx, len_1         ; длина строки в CX
        mov bl, 15            ; желтый текст на черном фоне   
        lea bp, msg_1         ; адрес строки в DX
		int 10h               ; вывод строки в консоль
        mov dl, 2h            ;начальная позиция для вывода: столбец
start:	 
        mov ah, 0h            ; номер функции BIOS (83/84-клавиши)
        int 16h               ; ввод клавиши. ASCII-код в AH, скан код в AL
 
        mov cx, ax
        cmp cl, 1Bh           ; ESC?
        je exit               
        cmp cl, 0Dh           ; Enter?
        je exit               
        
        mov ah, 13h           ; номер функции BIOS
        mov al, 1h            ; атрибуты в BL, переместить курсор в конец строки после вывода
        xor bh, bh
        mov bl, 14            ; желтый текст на черном фоне     
        mov dh, row           ; позиция для вывода: строка
        
        cmp cl, 5Ah        ; нажата большая буква
        jle big
        
        cmp cl, 7Ah        ; нажата маленькая буква
        jle small

        
        jmp start             
    
    big:
        cmp cl, 40h
        jle start
        add cl, 32
        mov bigchar, cl
        mov cx, 1 
        lea bp, bigchar       ; адрес строки в DX
        int 10h               ; вывод строки  
        inc dl 
        cmp dl, 23
        jge next
        jmp start
        
    next:
         mov dl, 2h
         inc row
         jmp start
         
    small:
        cmp cl, 60h
        jle start
        mov smallchar, cl     
        mov cx, 1 
        lea bp, smallchar     ; адрес строки в DX
        int 10h               ; вывод строки  
        inc dl
        cmp dl, 23
        jge next
        jmp start

exit:   
        mov ah, 13h           ; номер функции BIOS
        mov al, 1h            ; атрибуты в BL, переместить курсор в конец строки после вывода
        inc row
        mov dh, row           ; позиция для вывода: строка
        mov dl, 0h            ; позиция для вывода: столбец       
        mov cx, len_2         ; длина строки в CX
        xor bh, bh        
        mov bl, 0Ch           ; красный текст на черном фоне
        lea bp, msg_2         ; адрес строки в DX
		int 10h               ; вывод строки в консоль

        mov ah, 8h            ; номер функции DOS
        int 21h               ; ожидание нажатия клавиши

        ret                   ; возврат управления ОС  
       
        .data
msg_1   db "Программа преобразовывает строчные и прописные буквы в только строчные"             
len_1   dw $-msg_1
msg_2   db "Для выхода нажмите любую клавишу"     
len_2   dw $-msg_2 
bigchar db "a"   
smallchar db "a"  
row     db 1
        end start			   