	.file	"main.c"
	.intel_syntax noprefix
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
.LC1:
	.string	"%d %c %c %c %c %c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	MyFunction
	.type	MyFunction, @function
MyFunction:
.LFB23:
	.cfi_startproc
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	mov	r13d, esi
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	mov	r12d, r8d
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	mov	ebp, ecx
	mov	ebx, edi
	movsx	r12d, r12b
	mov	edi, OFFSET FLAT:.LC0
	movsx	ebp, bpl
	sub	rsp, 16
	.cfi_def_cfa_offset 64
	mov	r14d, edx
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR [rsp+8], rax
	xor	eax, eax
	lea	rsi, [rsp+4]
	mov	DWORD PTR [rsp+4], 0
	call	__isoc99_scanf
	push	r12
	.cfi_def_cfa_offset 72
	push	rbp
	.cfi_def_cfa_offset 80
	xor	eax, eax
	mov	edx, DWORD PTR [rsp+20]
	movsx	ecx, bl
	movsx	r9d, r14b
	movsx	r8d, r13b
	mov	esi, OFFSET FLAT:.LC1
	mov	edi, 1
	call	__printf_chk
	pop	rax
	.cfi_def_cfa_offset 72
	pop	rdx
	.cfi_def_cfa_offset 64
	mov	eax, DWORD PTR [rsp+4]
	mov	rdx, QWORD PTR [rsp+8]
	xor	rdx, QWORD PTR fs:40
	jne	.L5
	add	rsp, 16
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	pop	rbx
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE23:
	.size	MyFunction, .-MyFunction
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.1
.LC3:
	.string	"%s"
	.section	.text.unlikely
.LCOLDB4:
	.section	.text.startup,"ax",@progbits
.LHOTB4:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	sub	rsp, 88
	.cfi_def_cfa_offset 96
	mov	edi, OFFSET FLAT:.LC0
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR [rsp+72], rax
	xor	eax, eax
	lea	rsi, [rsp+8]
	mov	DWORD PTR [rsp+8], 2
	call	__isoc99_scanf
#APP
# 38 "main.c" 1
	;
;
;
;
;
;
;
;
;
;
;
# 0 "" 2
#NO_APP
	mov	edx, 19
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	xor	eax, eax
	mov	DWORD PTR [rsp+68], 19
	mov	BYTE PTR [rsp+16], 97
	mov	BYTE PTR [rsp+17], 98
	mov	BYTE PTR [rsp+18], 0
	mov	BYTE PTR [rsp+65], 0
	call	__printf_chk
	lea	rdx, [rsp+16]
	mov	esi, OFFSET FLAT:.LC3
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk
	lea	rsi, [rsp+12]
	mov	edi, OFFSET FLAT:.LC0
	xor	eax, eax
	mov	DWORD PTR [rsp+12], 0
	call	__isoc99_scanf
	push	49
	.cfi_def_cfa_offset 104
	push	49
	.cfi_def_cfa_offset 112
	mov	ecx, 49
	mov	edx, DWORD PTR [rsp+28]
	mov	r9d, 49
	mov	r8d, 49
	mov	esi, OFFSET FLAT:.LC1
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk
	mov	edx, DWORD PTR [rsp+28]
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk
	mov	rdx, QWORD PTR MY_STR[rip]
	xor	eax, eax
	mov	esi, OFFSET FLAT:.LC3
	mov	edi, 1
	call	__printf_chk
	pop	rax
	.cfi_def_cfa_offset 104
	pop	rdx
	.cfi_def_cfa_offset 96
	mov	rcx, QWORD PTR [rsp+72]
	xor	rcx, QWORD PTR fs:40
	jne	.L9
	xor	eax, eax
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L9:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE4:
	.section	.text.startup
.LHOTE4:
	.globl	MY_STR
	.section	.rodata.str1.1
.LC5:
	.string	"ASM IS HARD"
	.data
	.align 8
	.type	MY_STR, @object
	.size	MY_STR, 8
MY_STR:
	.quad	.LC5
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
