	.file	"main.c"
	.text
	.globl	_Z4funci
	.type	_Z4funci, @function
_Z4funci:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	_Z4funci, .-_Z4funci
	.section	.rodata
.LC0:
	.string	"%d"
	.text
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
	subq	$16, %rsp
#APP
# 9 "main.c" 1
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
	movl	$3, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %edi
	call	_Z4funci
#APP
# 12 "main.c" 1
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
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-21ubuntu1~16.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
