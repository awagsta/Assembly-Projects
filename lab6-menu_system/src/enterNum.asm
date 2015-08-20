bits 64
global enterNum
extern printf
extern read_int

section .text
enterNum:
        push    rbp
        mov     rbp, rsp
        
        ; prompt the user for a message
        mov     rdi, enterMessage
        mov     al, 0
        call    printf
        
        ; store the input integer on rax and echo it back
        call    read_int
        push    rax
        mov     rsi, rax
        mov     edi, intEcho
        mov     al, 0
        call    printf

        pop     rax
        mov     rsp, rbp
        pop     rbp
        ret 

section .data
enterMessage db "Please enter an integer", 10,0
intEcho db "%i was entered", 10, 0
