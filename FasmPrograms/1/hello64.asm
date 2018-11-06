
format ELF64 executable 3
entry start

include 'import64.inc'

interpreter '/lib64/ld-linux-x86-64.so.2'
needed 'libc.so.6'
import printf,exit,putchar

segment readable executable

start:
	
	push '0'
	lea	rdi,[rsp]
	xor	eax,eax
	call	[printf]

	call	[exit]

segment readable writeable

msg db 'Hello world!',0xA,0
Haystack db 'Hello world!',0xA,0
Haystack_Size = $-Haystack
SearchChar db 'H',0xA,0
ReplaceChar db 'W',0xA,0
Tap db '1',0xA,0