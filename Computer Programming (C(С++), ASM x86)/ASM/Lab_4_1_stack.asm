        include emu8086.inc 
        .model  tiny          
        .code                 
        .org 100h             

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
        
        lea dx, msg3          
        int 21h               

        ;�������� ����� ����
        push [D]              ; ��������� ��������� D � ����
        push [C]              ; ��������� ��������� C � ����        
        call calc_proc        ; ����� ���������
        add	sp,4		      ; ������������ ����� �� ���� ����������
                
        call PRINT_NUM        ; ����� ���������� � �������   

        ret                   ; ������� ���������� ��  
        
calc_proc proc
        push bp               ; ���������� ������� �������� BP
        mov bp, sp            ; ��������� ��������� ���� BP
        
        mov	dx, [bp+6]	      ; ��������� ���������� D � DX 
        mov	ax, [bp+6]	      ; ��������� ���������� D � AX
        mov	bx, [bp+4]	      ; ��������� ���������� C � BX
      
        imul dx 
        mov dx, [bp+6]
        imul dx
        mov cx, ax     ; in cx d^3
        mov ax, [bp+6]
        mov dl, 3
        div dl         ; d/3 in ax
        add ax, bx     
        imul ax 
        add ax, cx
        pop	bp		          ; �������������� ������� �������� BP 
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