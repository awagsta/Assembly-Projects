bits 64
global main
extern read_int
extern printf

section .data
dayMask   equ   0000000000011111b
monthMask equ   0000000111100000b
yearMask  equ   1111111000000000b
message   db    "Temperatures and Date:", 10, 0
slash     db    "/", 0
printInt  db    "%i", 0
newLine   db    "", 10, 0
heatMsg   db    " heat: ", 0
coolMsg   db    " cool: ", 0
timeMsg1  db    ":00 ", 0
timeMsg2  db    ":30 ", 0
space     db    " ", 0

section .bss
day   resw   1
month resw   1
year  resw   1


section .text

main:
    push   rbp
    mov    rbp, rsp
    
    mov    rdi, message
    mov    al, 0
    call   printf
    mov    rcx, 0

loop_header:
    cmp    QWORD rcx, 10
    jz     end
    
    push   rcx
    xor    rax, rax
    xor    rbx, rbx
    call   read_int
    mov    bx, ax
    and    ax, dayMask
    mov    [day], ax

    mov    ax, bx
    and    ax, monthMask
    ror    ax, 5
    mov    [month], ax

    mov    ax, bx
    and    ax, yearMask
    rol    ax, 7
    add    ax, 1900
    mov    [year], ax
    
    ; printing
    xor    rax, rax
    xor    rsi, rsi

    mov    ax, [month]
    
    mov    rsi, rax
    mov    rdi, printInt
    mov    al, 0
    call   printf

    mov    rdi, slash
    mov    al, 0
    call   printf

    mov    ax, [day]
    mov    rsi, rax
    mov    rdi, printInt
    mov    al, 0
    call   printf

    mov    rdi, slash
    mov    al, 0
    call   printf
    
    mov    ax, [year]
    mov    rsi, rax
    mov    rdi, printInt
    mov    al, 0
    call   printf
    
    ; print out a space
    mov    rdi, space
    mov    al, 0
    call   printf
 
    ; print the time
    xor    rax, rax
    xor    rsi, rsi
    call   read_int

    xor    rdx, rdx
    mov    rcx, 60
    div    rcx
    mov    rsi, rax
    mov    rdi, printInt
    push   rdx
    mov    al, 0
    call   printf
    pop    rdx
   
    ; was the time o'clock or not?
    cmp    rdx, 0
    jnz    half_hour
    jmp    hour

half_hour:
    mov    rdi, timeMsg2
    mov    al, 0
    call   printf
    jmp    temperatures

hour:
    mov    rdi, timeMsg1
    mov    al, 0
    call   printf

    ; print the heat
temperatures:
    mov    rdi, heatMsg
    mov    al, 0
    call   printf
 
    xor    rax, rax
    xor    rsi, rsi
    call   read_int
    
    mov    rsi, rax
    mov    rdi, printInt
    mov    al, 0
    call   printf

    ; print the cool
    mov    rdi, coolMsg
    mov    al, 0
    call   printf

    xor    rax, rax
    xor    rsi, rsi
    call   read_int

    mov    rsi, rax
    mov    rdi, printInt
    mov    al, 0
    call   printf

    ; print the new line
    mov    rdi, newLine
    mov    al, 0
    call   printf

    pop    rcx
    inc    rcx
    jmp    loop_header

    ;function teardown
end:
    mov    rsp, rbp
    pop    rbp
    ret
