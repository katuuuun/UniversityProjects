; This program calculate Sin and cos for different gar and periods
; according the formula of the method of the double angels
	.mmregs
	.def 	_c_int00
_c_int00:
	stm 	#RV, SP				; create stack
	ssbx	frct
	rsbx	sxm					; of sign expansion mode
	rsbx	ovm					; of overflow correction mode
	xor 	A, A				; A = 0
	stm		#a_base, AR6		; AR6 = 2pi/N
	ld		*AR6, 16, B			; load 2pi/N to B
	stm 	#gar-1, AR6			; cycle calculate a_base
loop_calc_a:
	add		B, A				; calc a_base for gar 3
	banz 	loop_calc_a, *AR6-	; loop
	
	stm 	#Ck, AR6			; Ck to AR6
    stm 	#Sk, AR7			; Sk to AR7
	call calc_double_angel		; function calc sin and cos
	
	ssbx	sxm					; on sign expansion mode
	ssbx	ovm					; on overflow correction mode
	stm 	#o_signal+1,AR3		; o_signal to AR3
	stm 	#period-1, AR6		; number of period
loop_period:	
	pshm 	AR6					; number to stack
	nop
	stm 	#N-1, AR6			; number of points
	stm 	#Ck, AR4			; Ck to AR4
    stm 	#Sn, AR2			; Sn to AR2
    
loop_sin:	
	call 	calc_n				; calc Sn and Cn
	sth 	A, *AR3+			; save o_signal
	banz 	loop_sin, *AR6-		; loop
	popm 	AR6					; number from stack
	nop
	banz 	loop_period, *AR6-	; loop
	
	nop

calc_n:
    mpy 	*AR4-, *AR2+, A		; AR4 * AR2 = A
    macr 	*AR4+, *AR2, A		; AR4 * AR2 + A = A and rounds the result of the multiply
    mpy 	*AR4-, *AR2-, B     ; AR4 * AR2 = B
    masr 	*AR4+, *AR2, B  	; B - AR4 * AR2 = B and rounds the result of the multipl
    sth 	A, *AR2+			; save sin
    sth 	B, *AR2-			; save cos
	ret		

calc_double_angel:
	;sin ?
	exp 	A					; T = number of leading bits of A - 8
	st		T, *AR4				; AR4 = T
	ld		#5, B				; B = 5
	sub		*AR4, B				; B = 5 - T
	stl		B, AR4				; AR4 = B
	ld		AR4, T				; T = AR4 = 5 - T
	NORM 	A					; A << T times
	sftl	A, -3, A			; A = A/8 - normolize
	sth		A, *AR7				; save sin
	; cos ? = 1 - A^2/2
	squr	A, B				; B = sin^2
	sftl	B, -1, B			; B = sin^2/2
	ld		#7FFFh, 16, A		; A = 1
	sth		B, *AR4				; AR4 = sin^2/2
	sub		*AR4, 16, A			; A = 1 - sin^2/2
	sth		A, *AR6				; save cos
	ret

	.data
	.align 64
RV	.bes	32*16				; stack

	.align
gar		.set	3				; N gar		
N   	.set	120				; length 1 gar
period 	.set 	2h				; number of periods

a_base 	.word   6B3h			; 2pi/N *2^15

Sk		.word	0				; Sk = 0
Ck		.word	7FFFh			; Ck = 7FFF because cos(0)?
Sn		.word	0				; Sn = 0
Cn		.word	7FFFh			; Cn = 7FFF because cos(0)?
o_signal	.word	0


