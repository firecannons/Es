action asm AllocateHeapMemory ( Byte Size ) returns Pointer
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
    
    add esp, 24
    
    ;ope:
    ;
    ;push eax
    ;mov byte [eax], 85
    ;add esp, -4
    ;mov [esp], eax
    ;call OutputByte
    ;pop eax
    ;
    ;add esp, 4
    ;
    ;add eax, 1
    ;
    ;jmp ope
    
    ;test eax, eax
    ;jnz cont
    
    ;mov	eax,1
	;xor	ebx,ebx
	;int	0x80
    
    ;cont:

    
    ; move new memory location to return position
    mov ebx, ebp
    add ebx, 12
    mov [ebx], eax
    
    mov esp, ebp
    pop ebp
end

action asm DeallocateHeapMemory ( Pointer Location , Byte Size )
    push ebp
    mov ebp, esp
    
    ; len to ecx
    xor ecx, ecx
    mov ebx, ebp
    add ebx, 12
    mov byte cl, [ebx]
    
    ; addr to ebx
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    mov ebx, [ebx]
    
    ; call mmap
    mov eax, 90
    mov ebx, esp
    ;lea ebx, [mmap_arg]
    int	0x80
    
    mov esp, ebp
    pop ebp
end

