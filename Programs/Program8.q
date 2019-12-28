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

action Main
    Array<Byte> Ab
    Ab:Initialize()
    Byte Test = 1
    Ab:Add(Test)
    Test = Ab:GetAt(0)
    OutputByteDigit(Test)
    
    Test = 2
    Ab:Add(Test)
    
    Test = 3
    Ab:Add(Test)
    
    Test = 4
    Ab:Add(Test)
    
    Test = 5
    Ab:Add(Test)
    
    Test = Ab:GetAt(1)
    OutputByteDigit(Test)
    
    Test = Ab:GetAt(2)
    OutputByteDigit(Test)
    
    Test = Ab:GetAt(3)
    OutputByteDigit(Test)
    
    Test = Ab:GetAt(4)
    OutputByteDigit(Test)
end
