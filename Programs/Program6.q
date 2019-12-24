using Libraries . DataTypes
using Libraries . DynamicMemory

action asm OutputByte ( Byte L )
    push ebp
    mov ebp, esp
    
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    ; sys_exit
    ;mov     eax, 1
    ;mov     ebx, 0
    ;int     0x80
    
    mov esp, ebp
    pop ebp
end

action asm OutputByteDigit ( Byte L )
    push ebp
    mov ebp, esp
    
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; add 48 for the ascii table offset
    mov byte dl, [ecx]
    add dl, 48
    add esp, -1
    mov byte [esp], dl
    mov ecx, esp
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    add esp, 1
    
    mov esp, ebp
    pop ebp
end

action Main
    // First test that Dealloc works for Arrays
    DynamicMemory<Integer> DM
    DM:AllocateHeapMemory(10)
    
    Integer I = 1
    Integer OneInt = 1
    Byte One = 1
    Byte CounterByte = 0
    repeat while I != 10000
        CounterByte = CounterByte + One
        OutputByteDigit(CounterByte)
        I = I + 1
        DM:AllocateHeapMemory(OneInt)
    end
    
    I = 100
    repeat while I != 100000
    end
end
