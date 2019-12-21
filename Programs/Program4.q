using Libraries . DataTypes
using Libraries . Array
using Libraries . Text

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
    
    ; sys_exit
    ;mov     eax, 1
    ;mov     ebx, 0
    ;int     0x80
    
    mov esp, ebp
    pop ebp
end

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

action OutputText ( Text T )
    Byte Test = T : GetAt ( 0 )
    OutputByte ( Test )
    
    Test = T : GetAt ( 1 )
    OutputByte ( Test )
    
    Test = T : GetAt ( 2 )
    OutputByte ( Test )
    
    Test = T : GetAt ( 3 )
    OutputByte ( Test )
    
    Test = T : GetAt ( 4 )
    OutputByte ( Test )
end

class MultiPassTest
    ElemTest E1
    ElemTest E2
end

class ElemTest
    Byte B1
    Byte B2
end

action OutputText ( Text MyText )
    Byte MyByte = MyText : GetAt ( 0 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 1 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 2 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 3 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 4 )
    OutputByte ( MyByte )
end

action CreateCoolString ( Text MyText )
    MyText : Letters : Resize ( 5 )
    Byte Test = 108
    MyText : Letters : SetAt ( 0 , Test )
    Test = 117
    MyText : Letters : SetAt ( 1 , Test )
    Test = 99
    MyText : Letters : SetAt ( 2 , Test )
    Test = 97
    MyText : Letters : SetAt ( 3 , Test )
    Test = 115
    MyText : Letters : SetAt ( 4 , Test )
end

action OutputText ( Array < Byte > MyText )
    Byte MyByte = MyText : GetAt ( 0 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 1 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 2 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 3 )
    OutputByte ( MyByte )
    
    MyByte = MyText : GetAt ( 4 )
    OutputByte ( MyByte )
end

action CreateCoolString ( Array < Byte > MyText )
    MyText : Resize ( 5 )
    Byte Test = 108
    MyText : SetAt ( 0 , Test )
    Test = 117
    MyText : SetAt ( 1 , Test )
    Test = 99
    MyText : SetAt ( 2 , Test )
    Test = 97
    MyText : SetAt ( 3 , Test )
    Test = 115
    MyText : SetAt ( 4 , Test )
end

action Main
    Byte OverloadTest = 97
    OutputByte(OverloadTest)
    
    OverloadTest = 5
    OutputByteDigit(OverloadTest)
    
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
    Byte B = MyArray:GetAt(0)
    OverloadTest = 100
    OutputByte(OverloadTest)
    //OutputByte(B)
    
    
    
    Byte TestByte = 4
    MyArray:SetAt(0, TestByte)
    
    TestByte = 3
    MyArray:SetAt(1, TestByte)
    
    TestByte = 2
    MyArray:SetAt(2, TestByte)
    
    TestByte = 1
    MyArray:SetAt(3, TestByte)
    
    
    
    TestByte = MyArray:GetAt(0)
    OutputByteDigit(TestByte)
    
    TestByte = MyArray:GetAt(1)
    OutputByteDigit(TestByte)
    
    TestByte = MyArray:GetAt(2)
    OutputByteDigit(TestByte)
    
    TestByte = MyArray:GetAt(3)
    OutputByteDigit(TestByte)
    TestByte = MyArray:GetAt(3)
    OutputByteDigit(TestByte)
    
    Byte NewByte
    /*TestByte = 5
    Text FirstText
    FirstText:CreateCoolString()
    FirstText:Resize(1)
    FirstText:SetAt(0, TestByte)
    OutputByteDigit(FirstText:GetAt(0))*/
    //OutputText ( FirstText )
   
    NewByte = 2
    Array<Byte> MyText
    MyText:Resize(1)
    MyText:SetAt(0, TestByte)
    NewByte = MyText:GetAt(0)
    OutputByteDigit(NewByte)
    
    Text MyText3
    MyText3:Letters:Resize(1)
    TestByte = 2
    MyText3:Letters:SetAt(0, TestByte)
    NewByte = MyText3:Letters:GetAt(0)
    OutputByteDigit(NewByte)
    
    Text MyText2
    MyText2:Resize(1)
    TestByte = 2
    MyText2:SetAt(0, TestByte)
    NewByte = MyText2:Letters:GetAt(0)
    OutputByteDigit(NewByte)
    
    Array<Byte> CoolArray
    CreateCoolString ( CoolArray )
    OutputText ( CoolArray )
    
    /*Byte LoopByte = 1
    repeat while LoopByte < 9
        OutputByteDigit(LoopByte)
        LoopByte = LoopByte + 1
    end*/
end

class afterClass
    Byte TestByte
end
