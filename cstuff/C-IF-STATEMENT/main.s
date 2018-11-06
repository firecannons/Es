	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
.LC1:
	.string	"no"
	.text
	.p2align 4,,15
	.globl	_Z14SecondFunctionv
	.type	_Z14SecondFunctionv, @function
_Z14SecondFunctionv:
.LFB30:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$.LC0, %edi
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	movl	$0, 4(%rsp)
	call	scanf
	movl	4(%rsp), %edx
	xorl	%eax, %eax
	movl	$.LC0, %esi
	movl	$1, %edi
	call	__printf_chk
	cmpl	$157, 4(%rsp)
	je	.L7
	movl	$.LC1, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
.L3:
	movq	8(%rsp), %rcx
	xorq	%fs:40, %rcx
	movl	4(%rsp), %eax
	jne	.L8
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	movl	$157, %edx
	movl	$.LC0, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	jmp	.L3
.L8:
	call	__stack_chk_fail
	.cfi_endproc
.LFE30:
	.size	_Z14SecondFunctionv, .-_Z14SecondFunctionv
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB31:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
#APP
# 31 "main.c" 1
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
	call	_Z14SecondFunctionv
#APP
# 33 "main.c" 1
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
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE31:
	.size	main, .-main
	.globl	MY_STR
	.section	.rodata.str1.1
.LC2:
	.string	"ASM IS HARD"
	.data
	.align 8
	.type	MY_STR, @object
	.size	MY_STR, 8
MY_STR:
	.quad	.LC2
	.ident	"GCC: (Ubuntu 7.3.0-21ubuntu1~16.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
