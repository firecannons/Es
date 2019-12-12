using Libraries . DataTypes
using Libraries . Array

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
    Byte OverloadTest = 97
    OutputByte(OverloadTest)
    OverloadTest = 97
    OutputByte(OverloadTest)
    Array<Byte> MyArray
    OverloadTest = 98
    OutputByte(OverloadTest)
    MyArray:Resize(4)
    OverloadTest = 99
    OutputByte(OverloadTest)
    OverloadTest = 99
    OutputByte(OverloadTest)
    Byte B = MyArray:GetAt(3)
    OverloadTest = 100
    OutputByte(OverloadTest)
    OutputByte(B)
end

class afterClass
    Byte TestByte
end
