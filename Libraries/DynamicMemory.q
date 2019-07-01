action asm AllocateHeapMemory ( Byte Size ) returns Pointer
jmp next

mmap_arg:  ; ugly
  .addr:   dd 0
  .len:    dd 512
  .prot:   dd 3
  .flags:  dd 34
  .fd:     dd -1
  .offset: dd 0
  
next:

    push ebp
    mov ebp, esp
    
    ; Must build the struct in reverse order
    ; offset
    add esp, -4
    mov dword [esp], 0
    
    ; fd
    add esp, -4
    mov dword [esp], -1
    
    ; flags
    add esp, -4
    mov dword [esp], 34
    
    ; prot
    add esp, -4
    mov dword [esp], 3
    
    ; len
    xor ecx, ecx
    mov ebx, ebp
    add ebx, 8
    mov byte cl, [ebx]
    add esp, -4
    mov dword [esp], ecx
    
    ; addr
    add esp, -4
    mov dword [esp], 0
    
    ; call mmap
    mov eax, 90
    mov ebx, esp
    ;lea ebx, [mmap_arg]
    int	0x80
    
    test eax, eax
    jnz cont
    
    mov	eax,1
	xor	ebx,ebx
	int	0x80
    
    cont:
    
    mov ebx, ebp
    add ebx, 12
    mov [ebx], eax
    
    ; --- Testing OutputByte ---
    ;mov [esp], eax
    ;mov byte [eax], 122
    ;call OutputByte
    
    mov esp, ebp
    pop ebp
end
