using Libraries . DataTypes

action asm OutputByte ( Byte L )
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
end

action Main
    Byte L
    OutputByte ( L )
    L = 100
    OutputByte ( L )
    L = 100
    OutputByte ( L )
    L = 100
    OutputByte ( L )
    L = 100
    OutputByte ( L )
end
