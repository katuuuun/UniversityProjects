; This program calculate Sin and cos for different gar and periods
; according the formula of the method of the sum of two angels
	.mmregs
	.def 	_c_int00
_c_int00:
	stm 	#RV, SP				; create stack
	ssbx 	FRCT
	ld		#S1, DP				; data page
	stm 	#o_signal+1,AR3		; o_signal to AR3
	stm 	#3-1, AR6			; cycle calculate Sk and Ck

loop_gar:	
    stm 	#C1,AR4				; C1 to AR4
    stm 	#Sk,AR2				; Sk to AR2
	call	calc_n				; calc Sk and Ck
	banz 	loop_gar, *AR6-		; loop
	
	stm 	#2-1, AR6			; number of period
loop_period:	
	pshm 	AR6					; number to stack
	nop
	stm 	#120-1, AR6			; number of points
	stm 	#Ck,AR4				; C1 to AR4
    stm 	#Sn,AR2				; Sk to AR2
    
loop_sin:	
	call 	calc_n				; calc Sn and Cn
	sth 	A, *AR3+			; save o_signal
	banz 	loop_sin, *AR6-		; loop
	
	popm 	AR6					; number from stack
	nop
	banz 	loop_period, *AR6-	; loop
	
	nop
	nop
	nop

calc_n:
    mpy 	*AR4-, *AR2+, A		; AR4 * AR2 = A
    ;rnd A  					; not repeatable
    macr 	*AR4+, *AR2, A		; AR4 * AR2 + A = A and rounds the result of the multiply
    mpy 	*AR4-, *AR2-, B     ; AR4 * AR2 = B
    masr 	*AR4+, *AR2, B  	; B - AR4 * AR2 = B and rounds the result of the multipl
    sth 	A,*AR2+				; save sin
    sth 	B,*AR2-				; save cos
    
	ret		

	.data
	.align 64
RV	.bes	32*16				; stack

	.align
gar		.word	3				; N gar		
N   	.word	120				; length 1 gar
;S1		.word	1408h
;C1		.word	7E60h
S1		.word	06B2h			; start sin
C1		.word	7FD3h			; start cos
Sk		.word	0				; Sk = 0
Ck		.word	7FFFh			; Ck = 7FFF because cos(0)?
Sn		.word	0				; Sn = 0
Cn		.word	7FFFh			; Cn = 7FFF because cos(0)?
o_signal	.word	0


