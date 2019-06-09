action asm AllocateHeapMemory ( Byte Size ) returns Pointer
    ; addr
    add esp, -4
    mov dword [esp], 0
    
    ; len
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    add esp, -4
    mov dword [esp], ebx
    
    ; addr
    add esp, -4
    mov dword [esp], 3
    
    ; addr
    add esp, -4
    mov dword [esp], 34
    
    ; addr
    add esp, -4
    mov dword [esp], -1
    
    ; addr
    add esp, -4
    mov dword [esp], 0
    
    ; call mmap
    mov eax, 90
    mov ebx, esp
    add ebx, 24
    int	0x80
    
    mov ebx, ebp
    add ebx, 12
    mov [ebx], eax
end
