	.file	"main.cpp"
	.text
	.section	.text._ZN6PersonC2Ev,"axG",@progbits,_ZN6PersonC5Ev,comdat
	.align 2
	.weak	_ZN6PersonC2Ev
	.type	_ZN6PersonC2Ev, @function
_ZN6PersonC2Ev:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	_ZN6PersonC2Ev, .-_ZN6PersonC2Ev
	.weak	_ZN6PersonC1Ev
	.set	_ZN6PersonC1Ev,_ZN6PersonC2Ev
	.section	.text._ZN6PersonplERKS_,"axG",@progbits,_ZN6PersonplERKS_,comdat
	.align 2
	.weak	_ZN6PersonplERKS_
	.type	_ZN6PersonplERKS_, @function
_ZN6PersonplERKS_:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	_ZN6PersonplERKS_, .-_ZN6PersonplERKS_
	.section	.text._ZN6PersonaSERKS_,"axG",@progbits,_ZN6PersonaSERKS_,comdat
	.align 2
	.weak	_ZN6PersonaSERKS_
	.type	_ZN6PersonaSERKS_, @function
_ZN6PersonaSERKS_:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	_ZN6PersonaSERKS_, .-_ZN6PersonaSERKS_
	.section	.text._ZN6Person5helloERKS_,"axG",@progbits,_ZN6Person5helloERKS_,comdat
	.align 2
	.weak	_ZN6Person5helloERKS_
	.type	_ZN6Person5helloERKS_, @function
_ZN6Person5helloERKS_:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	_ZN6Person5helloERKS_, .-_ZN6Person5helloERKS_
	.text
	.globl	_Z4funci
	.type	_Z4funci, @function
_Z4funci:
.LFB6:
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
.LFE6:
	.size	_Z4funci, .-_Z4funci
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
#APP
# 32 "main.cpp" 1
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
	movl	$3, -12(%rbp)
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %edi
	call	_Z4funci
#APP
# 35 "main.cpp" 1
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
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
#APP
# 37 "main.cpp" 1
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
	leaq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6PersonC1Ev
#APP
# 39 "main.cpp" 1
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
	leaq	-15(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6PersonC1Ev
#APP
# 41 "main.cpp" 1
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
	leaq	-14(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6PersonC1Ev
#APP
# 43 "main.cpp" 1
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
	leaq	-15(%rbp), %rdx
	leaq	-14(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN6PersonplERKS_
	leaq	-13(%rbp), %rdx
	leaq	-14(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN6PersonaSERKS_
#APP
# 45 "main.cpp" 1
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
	leaq	-15(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN6Person5helloERKS_
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L10
	call	__stack_chk_fail
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-21ubuntu1~16.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
