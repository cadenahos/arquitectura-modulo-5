section .data
    num1 db 10
    num2 db 20
    num3 db 15
    result db 0
    msg db "Largest number: ", 0xA
    msg_len equ $ - msg
    buffer db "00", 0xA

section .bss

section .text
    global _start

_start:
    mov al, [num1]
    mov bl, [num2]
    cmp al, bl
    jge check_num3
    mov al, bl

check_num3:
    mov cl, [num3]
    cmp al, cl
    jge store_result
    mov al, cl

store_result:
    mov [result], al
    movzx rax, byte [result]
    mov rbx, 10
    xor rdx, rdx
    div rbx
    add dl, '0'
    add al, '0'
    mov [buffer], al
    mov [buffer+1], dl
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 3
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall
