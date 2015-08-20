.include "/usr/local/include/atmega328p.def"

; boiler plate main provided by Professor Roie Black

.equ SERV_PIN, 5

    .section    .text
    .org        0x00
    .extern     delay50_init
    .extern	delay50
    .extern	timer50_reset
    .extern     delay2_init
    .extern	delay2
    .extern	timer2_reset

Start:
; set stack to top of available ram
    ldi         r28, (RAMEND & 0x00ff)
    ldi         r29, (RAMEND >> 8)
    out         SPH, r29
    out         SPL, r28
Init:
    ; set up a register with zero for convenience
    eor         r1, r1          ; cheap zero
    
    ; clear flag register
    out         SREG, r1

    ; set up the system clock
    ldi         r24, 0x80       ; set up prescaler
    sts         CLKPR, r24
    ldi		r17, 0b10000000 ; prep the clock for scaling 
    sts		CLKPR, r17
    ldi		r17, 0b10001000  ; clock/256
    sts		CLKPR, r17

    sbi		DDRB, SERV_PIN  ; set the pin 5 for output
    cbi		PORTB, SERV_PIN ; clear the pin

1:  call        delay50_init
    sbi		PORTB, SERV_PIN ; turn on the pin
    call	delay2_init
    cbi		PORTB, SERV_PIN ; turn off the pin
    rjmp	1b

