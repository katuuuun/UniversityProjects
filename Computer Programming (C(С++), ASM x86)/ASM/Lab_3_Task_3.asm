                       
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
	lea dx, msg_enter_str
	int 21h
	; input str_1
	mov ah, 0Ah
	lea dx, str_1
	int 21h
	; next line
	mov ax, 0E0Dh
    int 10h
    mov al, 0Ah
    int 10h
	; send message (str_1 is)
	mov ah, 09h
	lea dx, msg_show_str_1
	int 21h
	; output str_1
	mov ah, 09h
	lea dx, str_1
	add dx, 2
	int 21h
	; next line
	mov ax, 0E0Dh
    int 10h
    mov al, 0Ah
    int 10h
	 
	
    ;; replace nums
	; find indexes 
	cld         ; DF = 0
    mov cx, 22
	lea si, str_1
	lea di, str_2
comp:    
	lodsb
	cmp al, '0'
	jae comp_label_1
    jmp non_comp_label

comp_label_1:           ; symbol is '0' or higher
    cmp al, '9'
	jbe comp_label_2
    jmp non_comp_label

comp_label_2:           ; symbol is '9' or lower
    mov al, 'n'
    stosb
    mov al, 'u'
    stosb
    mov al, 'm'
    stosb
    mov al, 'b'
    stosb
    mov al, 'e'
    stosb
    mov al, 'r'
    stosb        
    jmp end_comp_label      

non_comp_label:
    stosb
	
end_comp_label:
	loop comp   
	
	
	;mov cx, 20
	;mov si, 1
	;mov di, 1
;comp:    
	;mov al, str_1[di+1]
	;cmp al, '0'
	;jae comp_label_1
    ;jmp non_comp_label

;comp_label_1:           ; symbol is '0' or higher
    ;cmp al, '9'
	;jbe comp_label_2
    ;jmp non_comp_label

;comp_label_2:           ; symbol is '9' or lower
    ;mov str_2[si+1], 'n'
    ;mov str_2[si+2], 'u'
    ;mov str_2[si+3], 'm'
    ;mov str_2[si+4], 'b'
    ;mov str_2[si+5], 'e'
    ;mov str_2[si+6], 'r'
    ;add si, 6          
    ;jmp end_comp_label      

;non_comp_label:
	;mov str_2[si+1], al
	;inc si
	
;end_comp_label:
    ;inc di
	;loop comp
	
	
	;; output str_2
	; send message (str_2 is)
	mov ah, 09h
	lea dx, msg_show_str_2
	int 21h
	; output str_2
	mov ah, 09h
	lea dx, str_2
	add dx, 2
	int 21h
	; next line
	mov ax, 0E0Dh
    int 10h
    mov al, 0Ah
    int 10h
	
	
	
    ret
      
    .data
       
; messanges   
msg_enter_str       db "Input 20 symbol text: ", 0Dh, 0Ah, '$'
msg_show_str_1      db "Text str_1 is: ", '$'
msg_show_str_2      db "Text str_2 is: ", '$'
         
; variables
str_1           db 21,0,22 dup('$')
str_2           db 101,0,102 dup('$')

; defines
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS

    end start