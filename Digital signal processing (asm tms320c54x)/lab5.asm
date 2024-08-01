   .INCLUDE "SIN112.TAB"
   .mmregs
   .def _c_int00
_c_int00:
	ld #0, DP
	rsbx sxm
	stm #sint, AR1		; load sin tabel
	stm #Signal, AR2	; load signal
	stm #N, BK
	
	stm #0, T
	call onebit			; generate start bit
	call onebit			; generate start bit
	call zerobit		; generate start bit	
	ld #Msg, 16, B
	stm #Msg_ln, AR3	

loop:					; generate message
	BITT BH
	stm #cnt, AR4
	stm #S0, AR0		; step for 0
	XC 2, TC
	stm #S1, AR0		; step for 1
	
loop_bit:
	ld *AR1+0%, A
	stl A, *AR2+
	banz loop_bit, *AR4-
	
	addm #1, *(0x000E)
	banz loop, *AR3-
	call onebit			; generate stop bit
	call onebit			; generate stop bit

; -- Lab7 --	
	ssbx sxm
	ssbx frct
	stm #Signal_buf, AR2	; buf signal
	stm #Signal, AR3		
	stm #Signal_mult, AR4	; signal from mult
	stm #x_n1, AR5			; x(n-1)
	stm #len, AR6			; len
	call Phase_Shift_Module	

; -- Lab8 --
	ssbx OVM
	ssbx frct
	stm #1111111111100001b, PMST	;set the SST bit
; in the processor operating mode refister PMST
	stm #filert_cas1, AR6			; first cascade
	stm #Signal_mult, AR2
	stm #len, AR5
	call demodulate					; call procedure
		
	stm #filert_cas2, AR6			; second cascade
	stm #filert_cas1, AR2			; first cascade
	stm #len, AR5
	call demodulate2				; call procedure
	
;------------detector	
	stm #filert_cas2, AR1
	rpt #72-1
	ld *AR1+, A
	stm #Msg_ln, AR2
point_loop:
	ld #0, B
	XC 1, AGT
	ld #1, B
	stm #Msg_out, *AR3
	nop
	ld *AR3, A
	nop
	sftl A, 1
	add A, B
	stl B, #Msg_out
	;dst B, Msg_out
	rpt #cnt-1
	ld *AR1+, A
	banz point_loop, *AR2-
			
	NOP
	NOP
	NOP

onebit:
       stm #S1, AR0
       stm #cnt, AR4
       
loop_one:
      ld *AR1+0%, A
      stl A, *AR2+
      banz loop_one, *AR4-       
      ret
       
       
zerobit:
       stm #S0, AR0
       stm #cnt, AR4
       
loop_zero:
      ld *AR1+0%, A
      stl A, *AR2+
      banz loop_zero, *AR4-       
      ret
      		
Phase_Shift_Module:
loop_proc:
	ld *AR5+, 13, A 	; load in H and x(n-1)/8
	mac *AR5-, #beta, A ; A = A + x(n-1)*beta/8
	sth A, -1, *AR2+ 
	delay *AR5       	; update
	mvdd *AR3+, *AR5 	; update
	mpya *AR5 		 	; B = x(n)*y(n)
	sub #0x5DC, 16, B
	sth B, *AR4+
	banz loop_proc, *AR6-
	ret   
			
; First cascade
demodulate:
First_cascade_loop:
		xor A, A
		ld *AR2+, 16, A
		sth A, *(xn)

		mac *(xn), #a0_0, A		; a0*x(n)
		mac *(xn1), #a1_0, A	; a1*x(n-1)
		mac *(xn2), #a2_0, A	; a2*x(n-2)
		stm #b1_0, T
		mas *(yn1), A			; -b1/2*y(n-1)
		stm #b2_0, T
		mas *(yn2), A			; -b2*y(n-2)
		stm #b1_0, T	
		mas *(yn1), A			; -b1/2*y(n-1)
		
		delay *(yn1)			; update
		sth A, *(yn1)
		delay *(xn1)			; update
		delay *(xn)				; update
		sth A, *AR6+
		banz First_cascade_loop, *AR5-		

		ret
; Second cascade
demodulate2:
Second_cascade_loop:
		xor A, A
		ld *AR2+, 16, A
		sth A, *(xn)

		mac *(xn), #a0_1, A		; a0*x(n)
		mac *(xn1), #a1_1, A	; a1*x(n-1)
		mac *(xn2), #a2_1, A	; a2*x(n-2)
		stm #b1_1, T
		mas *(yn1), A			; -b1/2*y(n-1)
		stm #b2_1, T
		mas *(yn2), A			; -b2*y(n-2)
		stm #b1_1, T	
		mas *(yn1), A			; -b1/2*y(n-1)
		
		delay *(yn1)			; update
		sth A, *(yn1)
		delay *(xn1)			; update
		delay *(xn)				; update
		sth A, *AR6+
		banz Second_cascade_loop, *AR5-		
		ret   
       
	.align
	.data
N 				.set 	112
cnt     		.set 	14
S0      		.set 	18
S1      		.set 	12
Ln      		.set 	336
len				.set 	294
Msg				.set 	0xFF00
Msg_out			.set 	0x0000
Msg_ln 			.set 	15
beta    		.set 	5092
; skif coef
a0_0			.set	1043				
a1_0			.set	1281				
a2_0			.set	1043				
b1_0			.set	-23796			
b2_0			.set	18190				
a0_1			.set	4427			
a1_1			.set	-1319				
a2_1			.set	4427			
b1_1			.set	-25804					
b2_1			.set	26462			
x_n1			.word	0		; x(n-1)
x_n2			.word	0		; x(n-2)
xn 				.word   0		; x(n)
xn1				.word	0		; x(n-1)
xn2				.word	0		; x(n-2)
yn1     		.word	0		; y(n-1)
yn2				.word	0		; y(n-2)
Signal     		.space 	len*16	
Signal_buf 		.space 	len*16		
Signal_mult 	.space 	len*16		
filert_cas1		.space 	len*16			
filert_cas2		.space 	len*16			
		
  

