.include "/usr/local/include/atmega328p.def"

.EQU	PRESET, 6
	
	.section .data
delay_count: .byte 0

	.section .text
	.global	 delay50_init
	.global  delay50
	.global  timer50_reset
delay50_init:
	eor	r1, r1	; cheap zero
	ldi	r16, (0 << CS02) | (0 << CS00 ) | (0 << CS01) ; zero out timer
	out	TCCR0B, r16 ; set timer clock to 0
	ldi	r16, (1 << CS02) ; set timer clock/256
	out	TCCR0B, r16 ; set the clock again
	ldi	r16, 1 << TOV0 ; clear interrupt flag
	out	TIFR0, r16
	ldi	r16, PRESET ; set initial value for timer
	out	TCNT0, r16
	sts	delay_count, r1 ; set inital value of counter to 0
	call	delay50
	ret

delay50:
	in	r16, TIFR0 ; check the flag
	sbrs	r16, TOV0  ; skip the next instruction if count overflow
	rjmp	delay50
	lds	r24, delay_count ; load r24 with the counter
	inc	r24 ; increment delay counter
	sts	delay_count, r24 ; store the incremented delay
	lds	r24, delay_count  
	cpi	r24, 5 ; compare with 5. 4 ms x 5 = 20 ms
	brne	timer50_reset
	sts	delay_count, r1
	ret

timer50_reset:
	ldi	r16, 1 << TOV0 ; clear interrupt flag
	out	TIFR0, r16
	ldi	r16, PRESET	; inital value for timer
	out	TCNT0, r16
	jmp	delay50
