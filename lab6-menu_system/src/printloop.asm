
bits 64
global printloop
extern printf


section .text
   ; procedure build up

printloop:
   push    rbp
   mov     rbp, rsp

loop_cond:
   cmp    ecx, edx
   jle    loop_body
   mov    rdi, newLine
   mov    al, 0
   call   printf

   ; procedure tear down
   mov    rsp, rbp
   pop    rbp
   ret

loop_body:
   mov    rsi, rcx
   mov    edi, testMsg
   mov    al, 0
   push   rcx
   push   rdx
   call   printf
   pop    rdx
   pop    rcx
   inc    ecx
   jmp    loop_cond

section .data
testMsg db "%i ", 0
newLine db " ", 10, 0
