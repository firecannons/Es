	.file	"main.c"
	.globl	MESSAGE
	.section	.rodata
.LC0:
	.string	"Hello"
	.data
	.align 8
	.type	MESSAGE, @object
	.size	MESSAGE, 8
MESSAGE:
	.quad	.LC0
	.globl	MAX
	.section	.rodata
	.align 4
	.type	MAX, @object
	.size	MAX, 4
MAX:
	.long	10
	.text
	.globl	LoopCount
	.type	LoopCount, @function
LoopCount:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movq	MESSAGE(%rip), %rax
	movq	%rax, %rdi
	call	puts
	addl	$1, -4(%rbp)
.L2:
	movl	$10, %eax
	cmpl	%eax, -4(%rbp)
	jb	.L3
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	LoopCount, .-LoopCount
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 18 "main.c" 1
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
	movl	$0, %eax
	call	LoopCount
#APP
# 20 "main.c" 1
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
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
