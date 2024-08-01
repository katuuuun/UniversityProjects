 include 'emu8086.inc'
 .model tiny 
 .org 100h

;Enter vars
LEA SI, msg1 ; Попросить ввести число
CALL print_string ;
CALL scan_num ; в CX.
MOV x1, CX ; из cx в x1.


PRINTN ''
LEA SI, msg2 ; Попросить ввести число
CALL print_string ;
CALL scan_num ; в CX.
MOV x2, CX ; из CX в x2.

PRINTN ''
LEA SI, msg3 ; Попросить ввести число
CALL print_string ;
CALL scan_num ; в CX.
MOV x3, CX ; из CX в x3.
               
PRINTN ''
LEA SI, msg4 ; Попросить ввести число
CALL print_string ;
CALL scan_num ; в CX.
MOV x4, CX ; из CX в x4.

mov ax, x1
mov dx, x2
sub ax, dx ; в dx осталось x2
;mov bx, x1 ; в bx осталось вычитание
mov cl, 3
imul cl ; bx * 3
mov dx, x4  ; x4 в dx
SAL dx, 1 ; в dx->x4*2
add ax, dx ; числитель в bx
mov dx, 3
sub dx, x3 ; знаменатель в dx
idiv dl
SAR AL, 2
mov ah, 0
CALL pthis
DB 13, 10, 'Solution: ', 0 
cbw
CALL print_num ; напечатать из AX
              
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