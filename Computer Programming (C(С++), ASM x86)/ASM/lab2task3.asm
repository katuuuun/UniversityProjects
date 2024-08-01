        include 'emu8086.inc'
        .model  tiny         
        .code                 
        .org 100h             
start:	 
        mov cx, size          ; �������� �������� ����� � CX
        lea si, mas           ; ����� ������� � SI
        xor bx,bx             ; ��������� �������� BX. BX - ������� �������� �������� ������� 
        
init:                          
        mov sizestep, cx
        CALL scan_num         ; � CX.  
        mov bx, cx
        PRINTN 'next '
        mov cx, sizestep     
        mov [si],bx           ; ������ �������� BX � ������� �������� �������
        add bx, 2             ; ��������� BX
        add si, 2             ; ������� � ���������� �������� �������
        loop init             ; ��������� ���� ���� C!=0
               
        mov cx, size
        lea si, mas  
        
        mov ah,09h            ; ������� ������ ������ �� ������ DX � �������
        lea dx,msg1           ; ����� ������ � DX
        int 21h               ; ����� �� ����� ��������� msg1 
        
        call show
        PRINTN ''
        
        mov cx, size
        lea si, mas
        
negative:
        mov bx, [si]
        neg bx
        mov [si], bx
        add bx, 2
        add si, 2
        loop negative         
              
        mov ah,09h            
        lea dx,msg           
        int 21h              
         
        lea si, mas           
        mov cx, size 
        
show:
        mov ax,[si]           
        call PRINT_NUM
        PRINT ' '
        add si, 2
        add ax, 2                
        loop show             
		ret					 
		
		.data
msg     db      "Converted array: ", 0Dh, 0Ah, "$"		
msg1    db      "Source array: ", 0Dh, 0Ah, "$"
size    dw      10            ; ������ �������	
mas     dw      10 dup (0)    ; �������� ������
sizestep dw 0 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
		end start			  