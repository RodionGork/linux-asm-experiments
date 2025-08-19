.section .data
msg: .ascii "regs: CS, DS, SS:\n\0"
msg2: .ascii "data segment: msg...esp:\n\0"
newline: .ascii "\n\0"

.section .bss
.equ pad_sz, 0x100
pad: .space pad_sz
.equ stk_sz, 0x100
stk: .space stk_sz

.section .text
.global _start

.macro store val
movl \val, (%ebp)
addl $4, %ebp
.endm

.macro storew val
movw \val, (%ebp)
movw $0, 2(%ebp)
addl $4, %ebp
.endm

.macro fetch r
subl $4, %ebp
movl (%ebp), \r
.endm

.macro peek r
movl -4(%ebp), \r
.endm

############################
_start:
movl $stk, %ebp

store $msg ; call prn_str
storew %cs ; store $4 ; call prn_hex_nl
storew %ds; store $4 ; call prn_hex_nl
storew %es; store $4 ; call prn_hex_nl
store $msg2 ; call prn_str
store $msg ; store $8 ; call prn_hex_nl
store %esp ; store $8 ; call prn_hex_nl
store $13 ; call sys_exit

prn_hex_nl: # value, digits --
call prn_hex
store $newline ; call prn_str
ret

prn_str: # addr --
call str_len
call sys_print
ret

prn_hex: # value, digits --
fetch %ecx
fetch %edx
movl $pad, %ebx
movb $0, (%ebx, %ecx)
prn_hex_0:
mov %dl, %al
and $0xF, %al
cmp $10, %al
jb prn_hex_1
add $7, %al
prn_hex_1:
add $0x30, %al
movb %al, -1(%ebx, %ecx)
shr $4, %edx
loop prn_hex_0
store $pad
call prn_str
ret

str_len:
peek %ebx
xor %ecx, %ecx
str_len_next:
movb (%ebx, %ecx), %al
test %al, %al
jz str_len_done
inc %ecx
jmp str_len_next
str_len_done:
store %ecx
ret

sys_exit:
movl $1, %eax
fetch %ebx
int $0x80

sys_print:
movl $4, %eax
movl $1, %ebx
fetch %edx
fetch %ecx
int $0x80
ret

