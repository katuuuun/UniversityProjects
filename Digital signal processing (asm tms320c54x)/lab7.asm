; This program calculate Sin and cos for different gar and periods
; according the formula of the method of the sum of two angels
	.mmregs
	.def 	_c_int00
_c_int00:
	rsbx 	ovm					; off ovm
	stm		#0xFFE0, PMST		; PMST to base state	
	stm 	#RV, SP				; create stack
	ssbx 	FRCT				; on even number mode bit in ST1
	ld		#S1, DP				; data page
	stm 	#signal+1,AR3		; o_signal to AR3
	stm 	#3-1, AR5			; number of gar
	stm 	#15-1, AR6			; start gar
loop_signal:
	
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
	
	st 		#0, Sk				; clear
	st 		#0, Sn			    ; clear	
	st 		#7FFFh, Ck			; base scale
	st 		#7FFFh, Cn			; base scale
	stm		#gar, AR6			; AR6 = current gar
	ld		*AR6, A				; A = current gar
	add		#15, A				; inc current gar
	addm    #15, gar			; inc current gar in mem
	stlm 	A, AR6				; save current gar
	
	banz 	loop_signal, *AR5-
	
	nop
	; -- Lab3 --
filter_start:
	orm     #1, *(PMST)			; inc PMST
	ssbx	FRCT				; on even number mode bit in ST1
	stm 	#signal,	 AR2	; save signal to AR2
	stm 	#xn,		 AR3	; save x(n)
	stm 	#b1_1,		 AR4	; save 1 coeff
	stm 	#5,			 BK		; number of elements in ring buf
	stm 	#N,			 AR7	; length of signal
	
	call sect_proc				;section 1
	
	stm 	#signal,	 AR2	; save signal to AR2
	stm 	#b1_2,		 AR4	; save 1 coeff
	stm 	#N,		  	 AR7	; length of signal
	stm 	#xn,		 AR3	; save x(n)
	st		#0, 		 xn1	; clear
	st		#0, 		 xn2	; clear
	st		#0, 		 yn		; clear	
	st		#0,			 yn1	; clear
	st		#0,			 yn2	; clear
	call sect_proc 				;section 2
	
	stm 	#signal,     AR2	; save signal to AR2
	stm 	#b1_3,       AR4	; save 1 coeff
	stm 	#N,	         AR7	; length of signal
	stm 	#xn,		 AR3	; save x(n)
	st		#0, 		 xn1	; clear
	st		#0, 		 xn2	; clear
	st		#0, 		 yn		; clear
	st		#0, 		 yn1	; clear
	st		#0, 		 yn2	; clear
	call sect_proc				;section 3

	
	nop
	nop
	nop

calc_n:
    mpy 	*AR4-, *AR2+, A		; AR4 * AR2 = A
    macr 	*AR4+, *AR2,  A		; AR4 * AR2 + A = A and rounds the result of the multiply
    mpy 	*AR4-, *AR2-, B     ; AR4 * AR2 = B
    masr 	*AR4+, *AR2,  B  	; B - AR4 * AR2 = B and rounds the result of the multipl
    sth 	A, 	   *AR2+		; save sin
    sth 	B,     *AR2-		; save cos
	ret		


sect_proc:
	mvdd 	*AR2,  *AR3			; save x(n)
	ltd 	xn2					; T = x(n-2); skip1 = x(n-2)
	mpy 	*AR4+%, A			; A = T * a2_i
	ltd 	xn1					; T = x(n-1); x(n-2) = x(n-1)
	mac 	*AR4+%, A			; A = A + T * a1_i
	ltd 	xn					; T = x(n); x(n-1) = x(n)
	mac 	*AR4+%, A			; A = A + T * a0_i
	ltd 	yn2					; T = y(n-2); skip2 = y(n-2)
	mas 	*AR4+%, A			; A = A - T * b2_i
	ltd 	yn1					; T = y(n-1); y(n-2) = y(n-1)
	mac 	*AR4+%, A			; A = A - T * b1_i
	sth 	A, 		yn			; y(n) = A	
	delay 	yn					; y(n-1) = y(n)
	sth 	A, 		*AR2+		; signal = A
	banz 	sect_proc, *AR7-	; loop
	ret

	.data
	.align 64
RV	.bes	32*16				; stack

	.align
gar		.word	15				; N gar		
N   	.set	720-1			; length 1 gar
S1		.word	06B2h			; start sin
C1		.word	7FD3h			; start cos
Sk		.word	0				; Sk = 0
Ck		.word	7FFFh			; Ck = 7FFF because cos(0)?
Sn		.word	0				; Sn = 0
Cn		.word	7FFFh			; Cn = 7FFF because cos(0)?

	.align 16
; skif coef
;section 1
a2_1	.word 3083	 ;0.0940676
a1_1	.word 5679	 ;0.1733036
a0_1	.word 3083   ;0.0940676
b2_1	.word 8847	 ;0.2699994
b1_1	.word 29772  ;-0.9085605


;section 2
musor1	.word 0 	 ;0
musor2	.word 0 	 ;0
musor3	.word 0 	 ;0
b2_2	.word 17410  ;0.5313026
b1_2	.word 21663  ;-0.6610967
a2_2	.word 9164   ;0.2796484
a1_2	.word 10188  ;0.3109091
a0_2	.word 9164   ;0.2796484

;section 3
musor4	.word 0		 ;0
musor5	.word 0		 ;0
musor6	.word 0		 ;0
b2_3	.word 27552  ;0.8408148
b1_3	.word 15715  ;-0.4795873
a2_3	.word 16509  ;0.5038124
a1_3	.word 11076  ;0.3380209
a0_3	.word 16509  ;0.5038124

musor7	.word 0 	 ;0
musor8	.word 0		 ;0
musor9	.word 0		 ;0
;signal history
xn		.word 0
xn1		.word 0
xn2		.word 0
skip1	.word 0
yn		.word 0
yn1		.word 0
yn2		.word 0
skip2	.word 0

yn1m	.word 0
yn1m1	.word 0
yn1m2	.word 0
lisina	.word 0
yn2m	.word 0
yn2m1	.word 0
yn2m2	.word 0
lenina	.word 0


signal .word 0,0
reserved .space 240*3*16
