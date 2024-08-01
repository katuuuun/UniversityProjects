
        .model  tiny          ; ������ ������ ��� ���
        .code                 ; ������ �������� ����
        .org 100h             ; ��������� �������� IP = 100h

        mov ax, @data         ; ����� �������� ������
        mov es, ax            ; ���������� � ES

        mov ah, 13h           ; ����� ������� BIOS
        mov al, 1h            ; �������� � BL, ����������� ������ � ����� ������ ����� ������
        mov dh, 0h            ; ������� ��� ������: ������
        mov dl, 0h            ; ������� ��� ������: �������       
        mov cx, len_1         ; ����� ������ � CX
        mov bl, 15            ; ������ ����� �� ������ ����   
        lea bp, msg_1         ; ����� ������ � DX
		int 10h               ; ����� ������ � �������
        mov dl, 2h            ;��������� ������� ��� ������: �������
start:	 
        mov ah, 0h            ; ����� ������� BIOS (83/84-�������)
        int 16h               ; ���� �������. ASCII-��� � AH, ���� ��� � AL
 
        mov cx, ax
        cmp cl, 1Bh           ; ESC?
        je exit               
        cmp cl, 0Dh           ; Enter?
        je exit               
        
        mov ah, 13h           ; ����� ������� BIOS
        mov al, 1h            ; �������� � BL, ����������� ������ � ����� ������ ����� ������
        xor bh, bh
        mov bl, 14            ; ������ ����� �� ������ ����     
        mov dh, row           ; ������� ��� ������: ������
        
        cmp cl, 5Ah        ; ������ ������� �����
        jle big
        
        cmp cl, 7Ah        ; ������ ��������� �����
        jle small

        
        jmp start             
    
    big:
        cmp cl, 40h
        jle start
        add cl, 32
        mov bigchar, cl
        mov cx, 1 
        lea bp, bigchar       ; ����� ������ � DX
        int 10h               ; ����� ������  
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
        lea bp, smallchar     ; ����� ������ � DX
        int 10h               ; ����� ������  
        inc dl
        cmp dl, 23
        jge next
        jmp start

exit:   
        mov ah, 13h           ; ����� ������� BIOS
        mov al, 1h            ; �������� � BL, ����������� ������ � ����� ������ ����� ������
        inc row
        mov dh, row           ; ������� ��� ������: ������
        mov dl, 0h            ; ������� ��� ������: �������       
        mov cx, len_2         ; ����� ������ � CX
        xor bh, bh        
        mov bl, 0Ch           ; ������� ����� �� ������ ����
        lea bp, msg_2         ; ����� ������ � DX
		int 10h               ; ����� ������ � �������

        mov ah, 8h            ; ����� ������� DOS
        int 21h               ; �������� ������� �������

        ret                   ; ������� ���������� ��  
       
        .data
msg_1   db "��������� ��������������� �������� � ��������� ����� � ������ ��������"             
len_1   dw $-msg_1
msg_2   db "��� ������ ������� ����� �������"     
len_2   dw $-msg_2 
bigchar db "a"   
smallchar db "a"  
row     db 1
        end start			   