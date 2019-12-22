using Libraries . DataTypes

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
    Byte Byte1 = 97
    Byte Byte2 = 1
    OutputByte(Byte1)
    Byte1 = Byte1 + Byte2
    OutputByte(Byte1)
    Byte Byte3 = 120
    
    repeat while Byte1 < Byte3
        OutputByte(Byte1)
        Byte Byte2_1 = 97
        Byte Byte2_2 = 1
        Byte Byte2_3 = 120
        repeat while Byte2_1 < Byte2_3
            OutputByte(Byte2_1)
            Byte2_1 = Byte2_1 + Byte2_2
        end
        Byte1 = Byte1 + Byte2
    end
    
    /*repeat while 25 < 26
        OutputByte(Byte1)
    end*/
end
