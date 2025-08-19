.section .text
.global _start

_start:

# mprotect call to make code writable
movl $125, %eax 
movl $_start, %ebx ; andl $0xFFFFF000, %ebx  # align to page
movl $4096, %ecx                             # size - one page
movl $7, %edx                                # read/write/execute flags
int $0x80                                    # invoke syscall

# now let's modify the parameter in the exit call following below
movl $endlabel, %ebx ; movb $13, 1(%ebx)

endlabel:
movl $0, %ebx   # this instruction is to be changed
movl $1, %eax
int $0x80

# the code is written to exit with 0 code
# but we are modifying the instruction to return 13 instead
# this could be checked after run with "echo $?"
