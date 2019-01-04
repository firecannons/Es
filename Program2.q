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

action asm OutputByte2 ( Byte L , Byte L2 )
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 12
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
end

action asm OutputByte5 ( Byte L , Byte L2 , Byte L3 , Byte L4 , Byte L5 )
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 12
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 16
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 20
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov ecx, ebp
    add ecx, 24
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
end


action Main
    Byte L = 102
    OutputByte ( L )
    L = 100
    L = 120
    OutputByte ( L )
    Byte B2
    OutputByte ( L )
    B2 = 110
    OutputByte ( L )
    B2 = L
    OutputByte ( L )
    OutputByte2 ( L , B2 )
    B2 = 121
    L = 119
    OutputByte2 ( L , B2 )
    Byte B3
    Byte B4
    Byte B5
    L = 100
    B2 = 101
    B3 = 102
    B4 = 103
    B5 = 104
    OutputByte5 ( L , B2 , B3 , B4 , B5 )
    B5 = 32
    OutputByte ( B5 )
    OutputByte ( B5 )
    OutputByte ( B5 )
    OutputByte ( B5 )
    OutputByte ( B5 )
    Byte S1
    Byte S2
    Byte S3
    S1 = 100
    S2 = 101
    S3 = S1
    S1 = S2
    S2 = S3
    OutputByte ( S1 )
    OutputByte ( S2 )
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 + 1
    OutputByte ( S3 )
    S3 = S3 - 1
    OutputByte ( S3 )
    S3 = S3 - 1
    OutputByte ( S3 )
    S3 = S3 - 1
    OutputByte ( S3 )
    S3 = S3 - 1
    OutputByte ( S3 )
    S3 = S3 - 1
    OutputByte ( S3 )
    S3 = S3 - 1 - 1 - 1 - 1
    OutputByte ( S3 )
    
    S3 = S3 - 1
    OutputByte ( S3 )
    Byte S4 = 1
    S3 = S3 - S4
    OutputByte ( S3 )
    
    Byte S5 = 115
    OutputByte ( S5 )
    Byte S6 = S5
    OutputByte ( S6 )
    S6 = S6 - 5
    OutputByte ( S6 )
    
    repeat while S6 > 105
        S6 = S6 - 1
    end
    
    OutputByte ( S6 )
    OutputByte ( S6 )
    OutputByte ( S6 )
    OutputByte ( S6 )
    
end
