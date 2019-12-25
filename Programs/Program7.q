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
    Byte SimpleByte = 1
    Pointer<Byte> Pb
    Pb:PointTo(SimpleByte)
    Byte SimpleByte2 = 2
    OutputByteDigit(SimpleByte)
    Pb:Dereference() = SimpleByte2
    OutputByteDigit(SimpleByte)
    
    // Should output 457
    Byte ConstByte4 = 4
    Byte ConstByte5 = 5
    Byte ConstByte6 = 6
    Byte ConstByte7 = 7
    Byte Test1 = 1
    Byte Test2 = 2
    Byte Test3 = 3
    Pointer<Byte> Pb1
    Pointer<Byte> Pb2
    Pointer<Byte> Pb3
    Pointer<Byte> Pb4
    Pb1:PointTo(Test1)
    Pb2:PointTo(Test2)
    Pb3:PointTo(Test3)
    Pb4:PointTo(Test3)
    Pb1:Dereference() = ConstByte4
    Pb2:Dereference() = ConstByte5
    Pb3:Dereference() = ConstByte6
    Pb4:Dereference() = ConstByte7
    OutputByteDigit(Test1)
    OutputByteDigit(Test2)
    OutputByteDigit(Test3)
end
