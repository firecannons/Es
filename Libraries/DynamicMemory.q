class DynamicMemory<T>
    action asm AllocateHeapMemory( Integer Size ) returns Pointer<T>
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
        add ebx, 12
        mov ecx, [ebx]
        mov ecx, [ecx]
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
        add ebx, 16
        mov [ebx], eax
        
        ;mov eax, 0
        mov byte [eax], 12
        mov byte [eax+1], 12
        mov byte [eax+2], 12
        mov byte [eax+3], 12
        
        mov esp, ebp
        pop ebp
    end

    action asm DeallocateHeapMemory ( Pointer<T> Location , Integer Size )
        push ebp
        mov ebp, esp
        
        ; len to ecx
        mov ebx, [ebp+16]
        mov ecx, [ebx]
        
        ; addr to ebx
        mov ebx, [ebp+12]
        mov ebx, [ebx]
        
        ; call mmap
        mov eax, 91
        ;lea ebx, [mmap_arg]
        int	0x80
        
        mov esp, ebp
        pop ebp
    end
    
    action ReallocateHeapMemory( Integer NewSize, Pointer<T> OldLocation, Integer OldSize ) returns Pointer<T>
    Byte Eight = NewSize
            OutputByteDigit(Eight)
        Pointer<T> NewP = Me:AllocateHeapMemory(NewSize)
            OutputByteDigit(Eight)
        if NewP != OldLocation
            OutputByteDigit(Eight)
            Me:CopyMemory(NewP, OldLocation, OldSize)
        end
            OutputByteDigit(Eight)
        Me:DeallocateHeapMemory(OldLocation, OldSize)
        return NewP
    end
    
    action asm CopyMemory( Pointer<T> NewLocation, Pointer<T> OldLocation, Integer OldSize)
        push ebp
        mov ebp, esp
        
        ; load NewLocation into eax
        mov eax, [ebp+12]
        mov eax, [eax]
        
        ; load OldLocation into ebx
        mov ebx, [ebp+16]
        mov ebx, [ebx]
        
        ; load OldSize into edi
        mov edi, [ebp+20]
        mov edi, [edi]
        
        ; Set ecx to 0 because is will be our "loop index"
        xor ecx, ecx
        
        CopyMemoryRepeatLabel:
        test ecx, edi
        je CopyMemoryExitLabel
        
        ; Load current value in OldLocation to edx
        mov byte dl, [ebx+ecx]
        
        ; Copy esi to the current position in NewLocation
        mov byte [eax+ecx], dl
        
        inc ecx
        
        jmp CopyMemoryRepeatLabel
        CopyMemoryExitLabel:
        
        mov esp, ebp
        pop ebp
    end
end
