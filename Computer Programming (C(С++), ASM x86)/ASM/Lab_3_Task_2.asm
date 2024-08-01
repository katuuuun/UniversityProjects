                       
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
	mov ax, 0E0Dh
    int 10h
    mov al, 0Ah
    int 10h
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
          
          
    ;; enter symbol 
    ; send message (enter)
	mov ah, 09h
	lea dx, msg_enter_symbol
	int 21h
	; input symbol
    mov ah, 0Ah
	lea dx, symbol
	int 21h
	; next line
	mov ax, 0E0Dh
    int 10h
    mov al, 0Ah
    int 10h
	; send message (symbol is)
	mov ah, 09h
	lea dx, msg_show_sybmbol
	int 21h
    ; output symbol
	mov ah, 09h
	lea dx, symbol
	add dx, 2
	int 21h
    ; next line
	mov ax, 0E0Dh
    int 10h
    mov al, 0Ah
    int 10h
    
    
    ;; Comparison strings
    ; send message (indexes are)
	mov ah, 09h
	lea dx, msg_comp
	int 21h
	; find indexes
    mov cx, 10+3
    lea di, S
    mov al, symbol[2]
                   
loop_label:
    mov al, symbol[2]
    repne scasb
    jnz exit
       
    mov ax, 10
    sub ax, cx
    call print_num
    print ' '
    
    cmp cx, 0
    jae loop_label
exit:
  
    ;mov cx, 10
    ;mov si, 0
;comp:    
	;mov al, S[si+2]
	;cmp al, symbol[2]
	;je comp_label
    ;jmp non_comp_label
;comp_label:
    ;mov ax, si
    ;call print_num
    ;print ' '
;non_comp_label:
	;inc si
    ;loop comp

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