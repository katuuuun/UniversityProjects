        include emu8086.inc 
        .model  tiny          ; ������ ������ ��� ���
        .code                 ; ������ �������� ����
        .org 100h             ; ��������� �������� IP = 100h

start:	 
        mov ah, 9h            
        lea dx, msg1          
        int 21h               
 
        call scan_num         ; ���� ����� C
        mov C, cx 

        printn ''
              
        lea dx, msg2          
        int 21h               
                
        call scan_num         ; ���� ����� D
        mov D, cx 

        printn ''
        
        lea dx, msg3          ; ����� ������ � DX
        int 21h               ; ����� ������ � �������
        
        call calc_proc        ; ����� ���������
                
        call PRINT_NUM        ; ����� ���������� � �������   

        ret                   ; ������� ���������� ��  
        
calc_proc proc
    ;�������� ���������� ����� ����� ������
        mov dx, D           ; ��������� D � aX
        mov bx, C           ; ��������� C � bX
        mov ax, D           ; ��������� C � bX  
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
        ret                   ; ����� �� ���������
calc_proc endp

        .data
msg1    db "������� ����� C:", 0Dh, 0Ah, "$" 
msg2    db "������� ����� D:", 0Dh, 0Ah, "$"  
msg3    db "�����: ", "$"
C       dw 0
D       dw 0

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM   
DEFINE_PRINT_NUM_UNS
        
        end start