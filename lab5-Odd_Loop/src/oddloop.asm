; For Mac OS-X maintain 16 byte alignment on all calls

        bits 64
        global  main
        extern  printf

        section .text
main:
        ; function setup
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        ;

        lea     rdi, [rel message]
        call    printf

	jmp while_condition
	
loop_body:
    
start_if:
    mov rax, [count]
    ror rax, 1
    jc  is_odd
    jmp end_if
is_odd:
    lea rdi, [countMsg]
    call printf
end_if:
	mov	rsi, [count]
	inc	rsi
	mov	[count], rsi
while_condition:
	
	mov	rsi, [count]
	cmp	rsi, 11
	jl	loop_body

        ; function return
        mov     eax, 0
        add     rsp, 32
        pop     rbp
        ret

        section .data
message  db      "COSC2425 Lab 5- Odd Number List", 10, 0
countMsg db	 "%i", 10, 0
count	 dq	 0
