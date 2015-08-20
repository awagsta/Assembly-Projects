bits 64
global menu
extern printf

section .text
menu:
    push    rbp
    mov     rbp, rsp

    mov     rdi, menuPrompt1
    mov     al, 0
    call    printf

    mov     rdi, menuPrompt2
    mov     al, 0
    call    printf

    mov     rdi, menuPrompt3
    mov     al, 0
    call    printf
    
    mov     rsp, rbp
    pop     rbp
    ret

    section .data
menuPrompt1 db "N - Enter an Integer Between 0 - 20", 10, 0
menuPrompt2 db "F - Display the first N+1 numbers (beginning with 0) on the console", 10, 0
menuPrompt3 db "X - Quit the program", 10, 0
