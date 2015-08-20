bits 64
global main
extern printf

section .data
date      dw    1110001101010111b
heat      db    255, 127, 0, 0, 0, 0, 0, 0, 64, 128
cool      db    0, 0, 0, 64, 128, 200, 64, 0, 0, 0
timeData  dw    360, 450, 480, 600, 720, 930, 1080, 1200, 150, 240
newLine   db    "", 10, 0
printInt  db    "%i", 0

section .text

main:
    push   rbp
    mov    rbp, rsp
    
    xor    rax, rax
    mov    ax,  [date]
    mov    rcx, 0

loop_header:
    cmp    QWORD rcx,  10
    jz     end
    
    ; print the packed date format
    mov    rsi, rax
    push   rax
    push   rcx
    mov    rdi, printInt
    mov    al, 0
    call   printf

    ; put the file on a new line
    mov    rdi, newLine
    mov    al, 0
    call   printf

    ; print the time values
    pop    rcx
    xor    rsi, rsi
    xor    rax, rax
    mov    ax,  [timeData + rcx * 2]
    mov    rsi, rax
    mov    rdi, printInt
    push   rcx
    mov    al, 0
    call   printf

    ; move the data to a new line
    mov    rdi, newLine
    mov    al, 0
    call   printf
    

    ; print the heat values
    pop    rcx
    xor    rsi, rsi
    xor    rax, rax
    mov    al, [heat + rcx * 1]
    mov    rsi, rax
    mov    rdi, printInt
    push   rcx
    mov    al, 0
    call   printf
   
    ; print the value on a new line
    mov    rdi, newLine
    mov    al, 0
    call   printf

    ; print the cool values
    pop    rcx
    xor    rsi, rsi
    xor    rax, rax
    mov    al, [cool + rcx * 1]
    mov    rsi, rax
    mov    rdi, printInt
    push   rcx
    mov    al, 0
    call   printf

    ; print the values on a new line
    mov    rdi, newLine
    mov    al, 0
    call   printf

    pop    rcx
    pop    rax
    cmp    QWORD rcx, 7
    jz     addDate
    inc    rcx
    jmp    loop_header

addDate:
    inc    rax
    inc    rcx
    jmp    loop_header

    ;function teardown
end:
    mov    rsp, rbp
    pop    rbp
    ret

