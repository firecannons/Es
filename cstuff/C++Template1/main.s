	.file	"main.cpp"
	.text
	.globl	_Z4funci
	.type	_Z4funci, @function
_Z4funci:
.LFB1543:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE1543:
	.size	_Z4funci, .-_Z4funci
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"hello"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB1544:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
#APP
# 41 "main.cpp" 1
	;
;
;
;1
;
;
;
# 0 "" 2
# 43 "main.cpp" 1
	;
;
;
;2
;
;
;
# 0 "" 2
# 45 "main.cpp" 1
	;
;
;
;3
;
;
;
# 0 "" 2
# 47 "main.cpp" 1
	;
;
;
;4
;
;
;
# 0 "" 2
# 49 "main.cpp" 1
	;
;
;
;5
;
;
;
# 0 "" 2
#NO_APP
	movl	$.LC0, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
#APP
# 51 "main.cpp" 1
	;
;
;
;6
;
;
;
# 0 "" 2
#NO_APP
	movl	$15, %esi
	movl	$_ZSt4cout, %edi
	call	_ZNSolsEi
	movq	%rax, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
	xorl	%eax, %eax
	popq	%rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1544:
	.size	main, .-main
	.type	_GLOBAL__sub_I__Z4funci, @function
_GLOBAL__sub_I__Z4funci:
.LFB2041:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	popq	%rax
	.cfi_def_cfa_offset 8
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	jmp	__cxa_atexit
	.cfi_endproc
.LFE2041:
	.size	_GLOBAL__sub_I__Z4funci, .-_GLOBAL__sub_I__Z4funci
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z4funci
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 7.3.0-21ubuntu1~16.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
