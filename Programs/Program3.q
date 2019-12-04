using Libraries . DataTypes
using Libraries . DataTypes
//using Libraries . DynamicMemory

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
    
    mov esp, ebp
    pop ebp
end

action asm OutputByte2 ( Byte L , Byte L2 )
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
    
    mov ecx, ebp
    add ecx, 12
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov esp, ebp
    pop ebp
    
end

action asm OutputByte5 ( Byte L , Byte L2 , Byte L3 , Byte L4 , Byte L5 )
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
    
    mov esp, ebp
    pop ebp
    
end

class MultiPassTest
    ElemTest E1
    ElemTest E2
end

class ElemTest
    Byte B1
    Byte B2
end

action Main
    Byte L = 102
    OutputByte ( L )
    
    Byte I1 = 100
    I1 = L
    L = I1
    OutputByte ( I1 )
    OutputByte ( L )
    Byte CST_1 = I1
    
    ElemTest ET
    ET:B1 = 102
    OutputByte ( ET:B1 )

    afterClass A
    A:TestByte = 102
    OutputByte ( A : TestByte )

    Pointer<Byte> Pb
    Pointer<Integer> Pi
    Box<Integer> Bi
    Box<Byte> Bb
/*
    OutputByte ( I1 + Mult(L, I1) )

    OutputByte ( t + 1 )
    
    OutputByte ( GetNum ( ) + 1 )

    OutputByte ( A + ( ( t1 ) ) ) + OutputByte ( t1 ) ) )

    OutputByte ( ( ( A + ( t1 ) ) + OutputByte ( t1 ) ) )

    OutputByte ( A + ( t1 + OutputByte ( ) )
    */
end

class afterClass
    Byte TestByte
end