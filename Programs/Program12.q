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
Box<Byte> BB1

action Main
    OutputByteDigit(B)
    CapTest CT
    OutputByteDigit(CT:B1)
    OutputByteDigit(True:Value)
    True:AssignNumericValue(4)
    OutputByteDigit(True:Value)
    OutputByteDigit(False:Value)
    Byte Five = 5
    OutputByteDigit(Five)
    B = 8
    OutputByteDigit(B)
    Byte D = 5
    
    Array<Integer> Ar
    Ar:Resize(5)
    Ar:SetAt(0, 4)
    Ar:SetAt(1, 3)
    Ar:SetAt(2, 2)
    Ar:SetAt(3, 1)
    Ar:SetAt(4, 0)
    
    Integer Position = 0
    //Position = Ar:Find(2)
    Byte OutPos = Position
    OutputByteDigit(OutPos)
    
    Box<Byte> BB
    
    Integer I = 1
    
    Integer NegTest = 8
    NegTest = NegTest + -1
    NegTest = NegTest + -I
    Byte NegTestByte = NegTest
    OutputByteDigit(NegTestByte)
end
