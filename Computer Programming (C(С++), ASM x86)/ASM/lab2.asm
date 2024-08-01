 include 'emu8086.inc'
 .model tiny
 .code 
 .org 100h

start:
mov cl, 8
LEA SI, mas
xor bl,bl




CALL pthis
DB 13, 10, '/', 0 

              
RET 
 
 
.data
mas dw 8
msg1 DB 'Enter x1: ', 0
x4 dd 0
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS
END 