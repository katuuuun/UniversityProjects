 include 'emu8086.inc'
 .model tiny 
 .org 100h

;Enter vars
LEA SI, msg1 ; ��������� ������ �����
CALL print_string ;
CALL scan_num ; � CX.
MOV x1, CX ; �� cx � x1.


PRINTN ''
LEA SI, msg2 ; ��������� ������ �����
CALL print_string ;
CALL scan_num ; � CX.
MOV x2, CX ; �� CX � x2.

PRINTN ''
LEA SI, msg3 ; ��������� ������ �����
CALL print_string ;
CALL scan_num ; � CX.
MOV x3, CX ; �� CX � x3.
               
PRINTN ''
LEA SI, msg4 ; ��������� ������ �����
CALL print_string ;
CALL scan_num ; � CX.
MOV x4, CX ; �� CX � x4.

mov ax, x1
mov dx, x2
sub ax, dx ; � dx �������� x2
;mov bx, x1 ; � bx �������� ���������
mov cl, 3
imul cl ; bx * 3
mov dx, x4  ; x4 � dx
SAL dx, 1 ; � dx->x4*2
add ax, dx ; ��������� � bx
mov dx, 3
sub dx, x3 ; ����������� � dx
idiv dl
SAR AL, 2
mov ah, 0
CALL pthis
DB 13, 10, 'Solution: ', 0 
cbw
CALL print_num ; ���������� �� AX
              
RET 

msg1 DB 'Enter x1: ', 0
msg2 DB 'Enter x2: ', 0
msg3 DB 'Enter x3: ', 0
msg4 DB 'Enter x4: ', 0
x1 dd 0
x2 dd 0
x3 dd 0
x4 dd 0
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS
END 