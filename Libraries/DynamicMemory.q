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
    
    ; move new memory location to return position
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
