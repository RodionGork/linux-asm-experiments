.section .text
.global _start

_start:

mov $10, %rax
mov $_start, %rdi
and $-0xFFF-1, %rdi
mov $0x1000, %rsi
mov $7, %rdx
syscall

movq $exit_code_instruction, %rbx
movb $13, 3(%rbx)

exit_code_instruction:
mov $7, %rdi
mov $0x3c, %rax
syscall
