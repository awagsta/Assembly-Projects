.include "/usr/local/include/atmega328p.def"

.EQU	PRESET, 131
	
	.section .data
delay2_count: .byte 0

	.section .text
	.global	 delay2_init
	.global  delay2
	.global  timer2_reset
delay2_init:
	eor	r1, r1	; cheap zero
	ldi	r16, (0 << CS02) | (0 << CS00 ) | (0 << CS01) ; zero out timer
	out	TCCR0B, r16 ; set timer clock to 0
	ldi	r16, (1 << CS01) | (1 << CS00) ; set timer clock/64
	out	TCCR0B, r16
	ldi	r16, 1 << TOV0 ; clear interrupt flag
	out	TIFR0, r16
	ldi	r16, PRESET ; set initial value for timer
	out	TCNT0, r16
	sts	delay2_count, r1 ; set initial value of counter to 0
	call	delay2
	ret

delay2:
	in	r16, TIFR0 ; check the flag
	sbrs	r16, TOV0  ; skip the next instruction if count overflow
	rjmp	delay2
	lds	r24, delay2_count ; load r24 with counter
	inc	r24 ; increment delay counter
	sts	delay2_count, r24 ; store the inc delay
	lds	r24, delay2_count
	cpi	r24, 4 ; value of 2,3 or 4. ~1/2ms delay per integer
	brne	timer2_reset ; comparison fails. reset timer
	sts	delay2_count, r1
	ret

timer2_reset:
	ldi	r16, 1 << TOV0 ; clear interrupt flag
	out	TIFR0, r16
	ldi	r16, PRESET ; load initial value for timer
	out	TCNT0, r16
	jmp	delay2
