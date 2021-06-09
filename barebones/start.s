.globl start
.extern main
.extern start_ctors, end_ctors, start_dtors, end_dtors

.set ALIGN,      1 << 0
.set MEMINFO,    1 << 1
.set FLAGS,      ALIGN | MEMINFO
.set MAGIC,      0x1BADB002
.set CHECKSUM,   -(MAGIC + FLAGS)

.section .text
.align 4
.multibootheader:
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

.set STACKSIZE, 0x4000 #16384

.code32
.static_ctors_loop:
    mov %ebx, start_ctors
    jmp .test
.body:
    calll start_ctors
    add %ebx, 4
.test:
    cmp %ebx, end_ctors
    jb .body

.code32
.start:
    mov $STACKSIZE+stack, %esp

    push %eax
    push %ebx
    
    calll main

.static_dtors_loop:
    mov %ebx, start_dtors
    jmp .test

    call start_dtors
    add %ebx, 4

    cmp %ebx, end_dtors
    jb .body

cpuhalt:
    hlt
    jmp cpuhalt

.section .bss
.align 32

stack:
    .space STACKSIZE