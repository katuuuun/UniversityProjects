                       
include 'emu8086.inc'


    .model tiny
    .code
    .org 100h

 
start:
	                   
	mov ax, @data
	mov ds, ax
	
	;; enter string
	; send message (enter)
	mov ah, 09h
	lea dx, msg_enter_S
	int 21h
	; input symbols to S
	mov ah, 0Ah
	lea dx, S
	int 21h
	; next line
	printn ''
	;mov ax, 0E0Dh
    ;int 10h
    ;mov al, 0Ah
    ;int 10h
	; send message (S is)
	mov ah, 09h
	lea dx, msg_show_S
	int 21h
	; output symbols from S
	mov ah, 09h
	lea dx, S
	add dx, 2
	int 21h
	; next line
	mov ax, 0E0Dh
    int 10h
    mov al, 0Ah
    int 10h
	
	
	;; S operations
	; S8 <-> S9
	mov ah, S[8+1]
	mov al, S[9+1]
	mov S[8+1], al
	mov S[9+1], ah 
	
	; S3 <- S1 - (S4 - S7) 
	mov al, S[1+1]
	mov ah, S[4+1]
	sub ah, S[7+1]
	sub al, ah
	mov S[3+1], al
	
	; copy string (W <- S)
	mov cx, 10+3
	lea si, S
	lea di, W
	rep movsb
	;mov cx, 10
	;mov si, 1
;copy:
	;mov al, S[si+1]
	;mov W[si+1], al
	;inc si
	;loop copy
	
	; send message (W is)
	mov ah, 09h
	lea dx, msg_show_W
	int 21h
	
	; output symbols from W 
	mov ah, 09h
	lea dx, W
	add dx, 2
	int 21h
    
    ; next line
	printn ''
	;mov ax, 0E0Dh
    ;int 10h
    ;mov al, 0Ah
    ;int 10h   

    ret
      
    .data
       
; messanges   
msg_enter_S         db "Input 10 symbol text: ", 0Dh, 0Ah, '$'
msg_show_S          db "Text S is: ", '$'
msg_show_W          db "Text W is: ", '$'
msg_enter_symbol    db "Input symbol: ", 0Dh, 0Ah, '$'
msg_show_sybmbol    db "Symbol is: ", '$'
msg_comp            db "indexes of target symbol: ", '$'
         
; variables
S           db 11,0,12 dup('$')
W           db 11,0,12 dup('$')        
symbol      db 2,0,3 dup('$') 

; defines
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS

    end start