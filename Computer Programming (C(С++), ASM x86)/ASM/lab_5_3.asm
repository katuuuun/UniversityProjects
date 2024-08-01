
        .model  tiny          ; ������ ������ ��� ���
        .code                 ; ������ �������� ����
        .org 100h             ; ��������� �������� IP = 100h

        mov ax, @data         ; ����� �������� ������
        mov es, ax            ; ���������� � ES

        mov ah, 13h           ; ����� ������� BIOS
        mov al, 1h            ; �������� � BL, ����������� ������ � ����� ������ ����� ������
        mov dh, 0h            ; ������� ��� ������: ������
        mov dl, 0h            ; ������� ��� ������: �������       
        mov cx, len_1          ; ����� ������ � CX
        mov bl, 00001111b        
        lea bp, msg_1          ; ����� ������ � DX
		int 10h               ; ����� ������ � �������
		add dh, 1h
		mov cx, len_3          ; ����� ������ � CX
        mov bl, 00001111b        
        lea bp, msg_3          ; ����� ������ � DX
		int 10h               ; ����� ������ � �������
 
start:	 
        mov ah, 0h            ; ����� ������� BIOS (83/84-�������)
        int 16h               ; ���� �������. ASCII-��� � AH, ���� ��� � AL
        
        mov bx, ax
        cmp bl, 1Bh           ; ESC?
        je exit               
        cmp bl, 0Dh           ; Enter?
        je exit               

        mov ah, 13h           ; ����� ������� BIOS
        mov al, 1h            ; �������� � BL, ����������� ������ � ����� ������ ����� ������
        mov cx, 9             ; ����� ������ � CX
        mov dh, row           ; ������� ��� ������: ������
        mov dl, 3h            ; ������� ��� ������: �������

        cmp bx, 1051h        ; ������ Shift + Q
        je Q
        
        cmp bx, 1157h        ; ������ Shift + W
        je W

        cmp bx, 1245h        ; ������ Shift + E
        je E

        cmp bx, 1352h        ; ������ Shift + R
        je R
        
        jmp start             ; ����������� ����
    
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
        int 10h               ; ����� ������  
        inc row
        jmp start

exit:   
        mov ah, 13h           ; ����� ������� BIOS
        mov al, 1h            ; �������� � BL, ����������� ������ � ����� ������ ����� ������
        mov dh, row           ; ������� ��� ������: ������
        mov dl, 0h            ; ������� ��� ������: �������       
        mov cx, len_2         ; ����� ������ � CX
        xor bh, bh        
        mov bl, 00001111b        
        lea bp, msg_2         ; ����� ������ � DX
		int 10h               ; ����� ������ � �������
        
        mov ah, 8h            ; ����� ������� DOS
        int 21h               ; �������� ������� �������

        ret                   ; ������� ���������� ��  
       
        .data
msg_1   db "��������� ��������������� ��������� ������: "
len_1   dw $-msg_1
msg_3   db "�Shift + Q�, �Shift + W�, �Shift + E�, �Shift + R�"
len_3   dw $-msg_3             
msg_2   db "��� ������ ������� ����� �������..."
len_2   dw $-msg_2  
text_Q db "Shift + Q"  
text_W db "Shift + W"
text_E db "Shift + E"
text_R db "Shift + R"
row     db 2
        end start			   
