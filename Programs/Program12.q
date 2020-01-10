using Libraries . DataTypes
using Libraries . Array

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

Byte B = 2

action Main
    OutputByteDigit(B)
    CapTest CT
    OutputByteDigit(CT:B1)
    OutputByteDigit(True:Value)
    True:AssignNumericValue(4)
    OutputByteDigit(True:Value)
    Byte Five = 5
    OutputByteDigit(Five)
    B = 8
    OutputByteDigit(B)
    Byte D = 5
end
