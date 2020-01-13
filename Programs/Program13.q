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
    
    Array<Integer> Ar
    Ar:Resize(5)
    Ar:SetAt(0, 4)
    Ar:SetAt(1, 3)
    Ar:SetAt(2, 2)
    Ar:SetAt(3, 1)
    Ar:SetAt(4, 0)
    
    Integer SearchValue = 2
    Integer Pos = Ar:Find(SearchValue)
    Byte BI = Pos
    OutputByteDigit(BI)
    
    Integer SearchValue = 2
    Bool Found = Ar:Contains(SearchValue)
    OutputByteDigit(Found:Value)
    OutputByteDigit(False:Value)
    OutputByteDigit(True:Value)
end
