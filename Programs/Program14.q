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

action Output ( Integer I )
    Array<Byte> ArNums
    Integer Index = 0
    Integer OutI = I
    repeat while OutI > 10
        Integer Rem = OutI:Remainder(10)
        OutI = OutI / 10
        Byte BRem = Rem
        ArNums:Add(BRem)
        Index = Index + 1
    end
    Byte One = 1
    ArNums:SetAt(Index, One)
    repeat while Index < ArNums:Size
        OutputByteDigit(ArNums:GetAt(ArNums:Size - Index - 1))
        Index = Index + 1
    end
end

action Main
    
    Byte B = 2
    Byte Mult = 4
    B = B * Mult
    OutputByteDigit(B) // 4 * 2 = 8
    Byte TwoByte = 2
    OutputByteDigit(TwoByte) // 2
    OutputByteDigit(B) // 8
    B = B / TwoByte
    OutputByteDigit(B) // 4
    B = B / TwoByte
    OutputByteDigit(B) // 2
    
    B = 8
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 0
    
    B = 9
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 1
    
    B = 10
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 0
    
    B = 11
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 1
    
    Integer I = 1234567
    Output ( I )
end
