using Libraries . DataTypes
using Libraries . Text

action OutputByteDigit ( Byte L )
    Output(L + 48)
end

action asm Output ( Byte B )
    push ebp
    mov ebp, esp
    
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; add 48 for the ascii table offset
    mov byte dl, [ecx]
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

action Output ( Text T )
    Integer Index = 0
    repeat while Index < T:GetSize()
        Output(T:GetAt(Index))
        Index = Index + 1
    end
    OutputNewline()
end

action OutputNewline()
    Byte B = 10
    Output(B)
end

action OutputAsByteDigits ( Text T )
    Integer Index = 0
    repeat while Index < T:GetSize()
        OutputByteDigit(T:GetAt(Index))
        Index = Index + 1
    end
end

action Output ( Integer I )
    Text ArNums = I:GetText()
    Output(ArNums)
end

action asm InputByte ( Byte RetByte ) returns Integer
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp+8]
    
    mov	eax, 3
    mov	ebx, 0
	mov	edx, 1
	int	0x80
    
    mov [ebp+12], eax
    
    mov esp, ebp
    pop ebp
end

action Input ( ) returns Text
    Text RetText
    Byte NewlineChar = 10
    Byte TempByte = 0
    InputByte(TempByte)
    repeat while TempByte != NewlineChar
        RetText:Add(TempByte)
        InputByte(TempByte)
    end
    return RetText
end
