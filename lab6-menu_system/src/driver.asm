    bits 64
    global main
    extern printf
    extern get_kb
    extern enterNum
    extern menu
    extern printloop

    section .data
message db "Hello", 10, 0
cmpMsg db "X was entered. Exiting program", 10, 0
failMessage db "Invalid menu choice. re-enter your choice.", 10, 0
boundsMessage db "Number was not between 0 - 20. Please Re-enter a number.", 10, 0

    section .bss
userNum RESB 32

    section .text

main:
    
    ;function setup
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    mov     rdi, message
    mov     al, 0
    call    printf

    call    menu

    ; attempt to call get kb
getChoice:
    call    get_kb
    
    ; compare input to menu choices
    cmp     al, 'x'
    jz      L1
    cmp	    al, 'X'
    jz      L1

    cmp     al, 'n'
    jz      L2
    cmp     al, 'N'
    jz      L2

    cmp     al, 'f'
    jz      L3
    cmp     al, 'F'
    jz      L3

    mov     rdi, failMessage
    mov     al, 0
    call    printf

    jmp     getChoice

    ;print this message if x was entered
L1:
    mov     rdi, cmpMsg
    mov     al, 0
    call    printf
    jmp     end

    ; store the character the user input
L2:
    call    enterNum
    mov     [userNum], eax

    ; ensure the number is between 0 and 20
    cmp     eax, DWORD 20
    jg      boundsError
    cmp     eax, DWORD 0

    ; if it is not, throw up a bounds error
    jl      boundsError
    jmp     getChoice

boundsError:
    mov    rdi, boundsMessage
    mov    al, 0
    call   printf
    jmp    L2

    ; loop and print the list of characters
L3:
    mov    edx, [userNum]
    mov    ecx, 0
    call   printloop
    jmp    getChoice

end:
    ;function return
    mov     eax, 0
    add     rsp, 32
    pop     rbp
    ret



