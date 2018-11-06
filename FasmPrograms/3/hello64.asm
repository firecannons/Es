
format ELF64 executable 3
entry start

include 'import64.inc'

interpreter '/lib64/ld-linux-x86-64.so.2'
needed 'libc.so.6'
import printf,exit,putchar


my_sub :
	push rbp
	mov rbp,rsp
mov rax, 20
	add rax, 10
	mov	rsi,rbp
	lea	rdi,[PointerPrint]
	xor	eax,eax
	call	[printf]




	mov rbx, rbp
	sub rbx, 9
	mov al, 'E'
	
	mov [rsp], al
	lea	rdi,[rsp]
	xor	eax,eax
	call	[printf]
	pop rbp
ret

; Description: PrintInput will print what is passed to it
; Pre: The String to print must be passed in rdi
; Post: The String is printed
PrintInput :
	mov	rsi,rdi
	lea	rdi,[StringPrint]
	xor	eax,eax
	call	[printf]
ret

MyFunction :

; Create Stack Frame
push rbp
mov rbp,rsp

lea rdi,[msg]
call PrintInput

mov rdi,SearchChar
call PrintInput

; Destroy Stack Frame
mov rsp,rbp
pop rbp

ret

start:
	
	lea rdi,[msg]
	lea rsi,[SearchChar]
	call MyFunction
	
	; NOTE: call and ret DO NOT MAKE A STACK FRAME FOR MEMORY
	; YOU NEED TO PUSH RBP IN THE FUNCTION FOR A STACK FRAME IN MEMORY
	; call and ret ONLY MAKE A STACK FRAME IN CODE
	; call subroutine
	; decrease stack size by 2 bytes
	;add rsp, 1
	

	call	[exit]

segment readable writeable

msg db 'Hello world!',0xA,0
PointerPrint db '%ld',0xA,0
StringPrint db '%s',0xA,0
Haystack db 'Hello world!',0xA,0
Haystack_Size = $-Haystack
SearchChar db 'H',0xA,0
ReplaceChar db 'W',0xA,0
Tap db '1',0xA,0