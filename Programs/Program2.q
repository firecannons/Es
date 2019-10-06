using Libraries.Letter
using Libraries.DynamicMemory

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

action asm OutputByteReference ( Byte Reference L )
    push ebp
    mov ebp, esp
    
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
    
    mov esp, ebp
    pop ebp
end

action asm OutputByte3 ( Byte L , Byte L2 , Byte L3 )
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
    
    mov esp, ebp
    pop ebp
    
end

action IndirectionOutput ( Byte L )
    OutputByte ( L )
end

action IndirectionAddOutput ( Byte L )
    OutputByte ( L + 1 )
end

action IndirectionAddTwoOutput ( Byte L )
    OutputByte ( L + 2 )
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

class ClassScopeTest
    Byte B2
    Byte B3
    
    action on create
        Me : B2 = 65
    end
    
    action RunTest ( Byte B3 )
        Byte B1 = 5
        Me : B2 = 66
    end
end

class ClassScopeTestTwo
    CapTest C1
    
    action on create
        Me : C1 : B2 = 68
    end
    
    action RunTest ( Byte B3 )
        Me : C1 : B2 = 72
    end
end

action NoParamTest ( )
end

class DoubleMethodTest
    action on create
    end
    
    action Method1 ( )
        OutputByte ( 82 )
    end
    
    action Method2 ( )
        Me : Method1 ()
    end
end

action ReturnTest ( ) returns Byte
    Byte B = 70
    return B
end

class RetTestCls
    action on create
    end
    
    action RetTe ( ) returns Byte
        Byte B = 66
        return B
    end
end

action ReturnTest2 ( Byte B2 ) returns Byte
    Byte B = B2
    return B
end

class TemplateTest<T>
    T MyT
    
    action on create
        Me : MyT = 67
        OutputByte ( Me : MyT )
    end
end

class Array<T>
    Byte Size
    Pointer DP
    Byte MemorySize
    
    action on create
        Me : Size = 0
        Me : MemorySize = 0
        Me : DP = AllocateHeapMemory ( Me : MemorySize )
    end
    
    action asm SetAt(Byte Position, T Elem)
        push ebp
        mov ebp, esp
        
        ; load DP into edx
        mov ebx, ebp
        add ebx, 8
        mov ebx, [ebx]
        add ebx, 1
        mov ecx, ebx
        
        mov byte [ecx], 85
        
        ;push ecx
        ;add esp, -4
        ;mov [esp], ecx
        ;call OutputByte
        ;add esp, 4
        ;pop ecx
        
        ; load Position into edx
        mov edx, ebp
        add edx, 12
        mov edx, [edx]
        mov byte dl, [edx]
        
        ; Perform arithmetic to find correct memory position into ebx
        mov eax, SizeOf(T)
        mul dl
        add ecx, eax
        
        ;push ecx
        ;add esp, -4
        ;mov [esp], ebx
        ;call OutputByte
        ;add esp, 4
        ;pop ecx
        
        
        ; Load the ebx position onto the stack
        mov ebx, ebp
        add ebx, 16
        mov ebx, [ebx]
        add esp, -4
        mov [esp], ebx
        
        ; Load the ebx position onto the stack
        add esp, -4
        mov [esp], ecx
        call GetResolvedClassName(T)On_Equals
        
        ; Move the stack pointer back up
        add esp, 8
        
        ;push ecx
        ;add esp, -4
        ;mov [esp], ebx
        ;call OutputByte
        ;add esp, 4
        ;pop ecx
        
        mov esp, ebp
        pop ebp
        
    end
    
    action asm GetAt(Byte Position) returns T
        push ebp
        mov ebp, esp
        
        ; load DP into edx
        mov ebx, ebp
        add ebx, 8
        mov ebx, [ebx]
        add ebx, 1
        mov ecx, ebx
        
        ;add esp, -4
        ;mov [esp], ecx
        ;call OutputByte
        ;add esp, 4
        
        ; load Position into edx
        mov edx, ebp
        add edx, 12
        mov edx, [edx]
        mov byte dl, [edx]
        
        ; Perform arithmetic to find correct memory position into ebx
        mov eax, SizeOf(T)
        mul dl
        add ecx, eax
        
        ;add esp, -4
        ;mov [esp], ecx
        ;call OutputByte
        ;add esp, 4
        
        ; Load the ebx position onto the stack
        add esp, -4
        mov [esp], ecx
        
        ; Load the return position
        mov ebx, ebp
        add ebx, 16
        add esp, -4
        mov [esp], ebx
        
        call GetResolvedClassName(T)On_Equals
        
        ; Move the stack pointer back up
        add esp, 8
        
        mov esp, ebp
        pop ebp
    end
    
    action Append ( T NewElem )
        Byte testy = 70
        OutputByte ( testy )
        OutputByte ( testy )
        Me : Size = Me : Size + 1
        OutputByte ( Me : Size + 65 )
        if Me : Size > Me : MemorySize
            //Me : MemorySize = Me : Size * 2
            Me : MemorySize = Me : Size
            //OutputByte ( Me : MemorySize + 65 )
            Me : DP = AllocateHeapMemory( Me:MemorySize )
            //OutputByteReference ( Me : DP )
        end
        Byte NewSize = Me:Size - 1
        Byte PrintSize = NewSize + 65
        //OutputByte ( PrintSize )
        //OutputByteReference ( Me : DP )
        Me : SetAt(NewSize, NewElem)
    end
    
    action Resize ( Byte Size )
        Me : Size = Size
        Me : MemorySize = Size
        Me : DP = AllocateHeapMemory ( Me : MemorySize )
    end
end

class Text
    Array<Letter> Data
    
    action on create
    end
    
    action SetAt ( Byte Position , Letter L )
        Me : Data : SetAt ( Position , L )
    end
    
    action GetAt ( Byte Position ) returns Letter
        Letter Temp = Me : Data : GetAt ( Position )
        return Temp
    end
    
    action Append ( Letter L )
        Data : Append ( L )
    end
    
    action Output
        Byte Index = 0
        repeat until Index > Data : Size
            OutputByte ( Data : GetAt ( Index ) )
            Index = Index + 1
        end
    end
end

/*
class Game
    List<List<Tile>> World
    List<Unit> Units
end

class Tile
    Unit Reference MyUnit
    Coord2D Position
end

class Unit
    Tile Reference MyTile
    Number Health
    
    action Move ( Tile InTile )
        MyTile : MyUnit = None
        InTile : MyUnit = Me
    end
end
*/
class MultiTemplateTest<T, T2, T3>
    T MyT
    T2 MyT2
    T3 MyT3
    
    action on create
        Me : MyT = 67
        Me : MyT2 = 68
        OutputByte ( Me : MyT2 )
    end
end

class RefTemplateTest<T, T2, T3>
    T MyT
    T2 MyT2
    T3 MyT3
    
    action on create
        Me : MyT = 67
        Me : MyT2 = 68
        OutputByte ( Me : MyT2 )
    end
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

action asm SetByteInDynam ( Pointer DB , Byte Position , Byte NewByte )
    push ebp
    mov ebp, esp
    
    ; load DP into edx
    mov ebx, ebp
    add ebx, 8
    mov ecx, [ebx]
        
    ; load Position into edx
    mov edx, ebp
    add edx, 12
    mov edx, [edx]
    mov byte dl, [edx]
    
    ; Perform arithmetic to find correct memory position into ebx
    mov eax, 1
    mul dl
    add ecx, eax
    
    ; Load the return position
    mov ebx, ebp
    add ebx, 16
    mov ebx, [ebx]
    add esp, -4
    mov [esp], ebx
    
    ; Load the ebx position onto the stack
    add esp, -4
    mov [esp], ecx
    
    call Byte__On_Equals
    
    ; Move the stack pointer back up
    add esp, 8
    
    mov esp, ebp
    pop ebp
end

action asm SetFirstByteInDynam ( Pointer DB )
    push ebp
    mov ebp, esp
    
    ; load DP into edx
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    
    mov byte [ebx], 86
    
    add esp, -4
    mov [esp], ebx
    call OutputByte
    add esp, 4
    
    ; Move the stack pointer back up
    add esp, 8
    
    mov esp, ebp
    pop ebp
end

action asm GetFirstByteInDynam ( Pointer DB )
    push ebp
    mov ebp, esp
    
    ; load DP into edx
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    
    add esp, -4
    mov [esp], ebx
    call OutputByte
    add esp, 4
    
    ; Move the stack pointer back up
    add esp, 8
    
    mov esp, ebp
    pop ebp
end

action asm GetPointerPart ( Pointer I , Byte Index ) returns Byte
    push ebp
    mov ebp, esp
    
    ; load I into ebx
    mov ebx, ebp
    add ebx, 8
    mov ebx, [ebx]
    mov ebx, [ebx]
    
    ; load Index into ecx
    xor ecx, ecx
    mov eax, ebp
    add eax, 12
    mov eax, [eax]
    mov byte cl, [eax]
    
    ; Do shifting arithmetic
    mov byte dl, 7
    sub byte dl, cl
    xor eax, eax
    mov byte al, dl
    mov dl, 4
    mul dl
    
    ; Do shift
    mov cl, al
    shr ebx, cl
    
    ; Perform modulus by 16 to get lower 4 bits and edx has the remainder
    xor edx, edx
    mov eax, ebx
    mov ebx, 16
    div ebx
    
    ; Move result in bl into return location
    mov eax, ebp
    add eax, 16
    mov [eax], dl
    
    mov esp, ebp
    pop ebp
end

action OutputAsHex ( Byte InByte )
    Byte NewByte = InByte
    if NewByte < 10
        NewByte = NewByte + 48
    else
        NewByte = NewByte + 55
    end
    OutputByte ( NewByte )
end

action PrintPointer ( Pointer I )
    OutputByte ( 48 )
    OutputByte ( 120 )
    Byte Index = 0
    repeat while Index < 8
        Byte TempByte
        TempByte = GetPointerPart ( I , Index )
        OutputAsHex ( TempByte )
        Index = Index + 1
    end
end

action PrintPointerWithNewLine ( Pointer I )
    OutputByte ( 10 )
    OutputByte ( 48 )
    OutputByte ( 120 )
    Byte Index = 0
    repeat while Index < 8
        Byte TempByte
        TempByte = GetPointerPart ( I , Index )
        OutputAsHex ( TempByte )
        Index = Index + 1
    end
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
    OutputByte ( S6 )
    S6 = 122
    Byte S7 = 65
    Byte S8 = 121
    
    repeat while S6 > 65
        OutputByte ( S6 )
        S6 = S6 - 1
    end
    
    S6 = 65
    repeat until S6 > 121
        OutputByte ( S6 )
        S6 = S6 + 1
    end
    
    repeat until S6 <= 65
        OutputByte ( S6 )
        S6 = S6 - 1
    end
    
    repeat until S6 >= 122
        OutputByte ( S6 )
        S6 = S6 + 1
    end
    
    repeat until S6 == 65
        OutputByte ( S6 )
        S6 = S6 - 1
    end
    
    repeat while S6 < 122
        OutputByte ( S6 )
        S6 = S6 + 1
    end
    
    repeat while S6 != 65
        OutputByte ( S6 )
        S6 = S6 - 1
    end
    
    S6 = 65
    OutputByte ( S6 )
    if S6 == 66
        S6 = 67
    end
    
    Byte WriteByte = 0
    if S6 == 65
        WriteByte = 89
        OutputByte ( WriteByte )
        WriteByte = 69
        OutputByte ( WriteByte )
        WriteByte = 83
        OutputByte ( WriteByte )
    end
    
    if S6 != 65
        WriteByte = 78
        OutputByte ( WriteByte )
        WriteByte = 79
        OutputByte ( WriteByte )
    end
    
    if S6 == 65
        WriteByte = 89
        OutputByte ( WriteByte )
        WriteByte = 69
        OutputByte ( WriteByte )
        WriteByte = 83
        OutputByte ( WriteByte )
    elseif S6 == 65
        WriteByte = 78
        OutputByte ( WriteByte )
        WriteByte = 79
        OutputByte ( WriteByte )
    else
        WriteByte = 77
        OutputByte ( WriteByte )
        WriteByte = 65
        OutputByte ( WriteByte )
    end
    
    OutputByte ( S6 )
    OutputByte ( S6 )
    OutputByte ( S6 )
    OutputByte ( S6 )
    OutputByte ( S6 + 2 )
    OutputByte5 ( S6 + 1 , B2 , B3 , B4 , B5 )
    OutputByte5 ( S6 + 1 , S6 + 2 , S6 + 3 , S6 + 4 , S6 + 5 )
    OutputByte3 ( S6 , S6 + 1 , S6 + 2 )
    OutputByte5 ( S6 + 1 , S6 + 1 + 1 , S6 + 1 + 1 + 1 , S6 + 4 , S6 + 5 )
    
    OutputByte ( ( S6 ) )
    
    OutputByte ( ( ( ( S6 ) ) ) )
    
    OutputByte ( ( ( ( S6 ) ) + 1 ) )
    
    IndirectionOutput ( S6 )
    
    IndirectionAddOutput ( S6 )
    
    IndirectionAddTwoOutput ( S6 )
    
    Byte T1 = S6
    Byte T2 = 1
    
    OutputByte ( ( T1 ) )
    
    OutputByte ( ( S6 ) + T2 )
    
    IndirectionAddOutput ( ( S6 ) + T2 )
    
    CapTest c
    c : B1 = 65
    OutputByte ( c : B1 )
    c : B2 = 4
    c : B1 = c : B1 + c : B2
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    c : B1 = c : B1 + c : B2
    OutputByte ( c : B1 )
    OutputByte ( c : B1 )
    
    CapTest2 ct
    ct : C1 : B1 = c : B1
    OutputByte ( c : B1 )
    OutputByte ( ct : C1 : B1 )
    ct : C1 : B1 = ct : C1 : B1 + c : B2
    OutputByte ( ct : C1 : B1 )
    OutputByte ( c : B1 )
    ct : C2 : B2 = ct : C1 : B1 + c : B2
    OutputByte ( ct : C2 : B2 )
    OutputByte ( ct : C2 : B2 )
    OutputByte ( c : B1 )
    
    
    ClassScopeTest CST
    OutputByte ( CST : B2 )
    CST : RunTest ( S6 )
    OutputByte ( CST : B2 )
    OutputByte ( c : B1 )
    OutputByte ( 66 )
    
    ClassScopeTest CST2
    OutputByte ( CST2:B2 )
    
    ClassScopeTestTwo CST2_1
    OutputByte ( CST2_1:C1:B2 )
    CST2_1:C1:B1 = 69
    OutputByte ( CST2_1:C1:B1 )
    CST2_1:C1:B1 = 70
    OutputByte ( CST2_1:C1:B1 )
    CST2_1:RunTest ( S6 )
    OutputByte ( CST2_1:C1:B2 )
    
    OutputByte ( 66 )
    
    Byte reference BR1
    BR1 = CST2_1:C1:B2
    OutputByte ( BR1 )
    
    Byte reference BR2
    BR2 = BR1
    OutputByte ( BR2 )
    
    
    
    ClassScopeTest TestCST
    ClassScopeTest reference CSTR
    CSTR = TestCST
    TestCST : B2 = 100
    OutputByte ( TestCST : B2 )
    CSTR : RunTest ( 66 )
    OutputByte ( TestCST : B2 )
    
    NoParamTest ( )
    
    DoubleMethodTest DMT
    DMT : Method2 ( )
    
    Byte RetTest
    RetTest = ReturnTest ( )
    OutputByte ( RetTest )
    
    RetTestCls RTC
    RetTest = RTC : RetTe ( )
    OutputByte ( RetTest )
    
    Byte RetTest2
    RetTest2 = ReturnTest2 ( 72 )
    OutputByte ( RetTest2 )
    
    if S6 == 65
        Byte MeByte
        MeByte = MeByte + 2
    end
    Pointer joe
    
    Byte Size = 128
    Integer TestSize
    OutputByte ( 85 )
    Pointer DB = AllocateHeapMemory ( Size )
    S6 = 0
    repeat while S6 < 10
        Byte NewByte = 65
        SetByteInDynam ( DB , S6 , NewByte )
        OutputByte ( NewByte )
        S6 = S6 + 1
    end
    
    //Array<Byte> MyAr
    
    TemplateTest<Byte> TeTe
    
    MultiTemplateTest<Byte,Byte,Integer> MuTeTe
    
    //RefTemplateTest<Byte reference,Byte,Integer> RefTeTe
    
    Byte MyByte = 67
    Array<Byte> MyByteArray
    OutputByte ( MyByte )
    MyByteArray : Resize ( 10 )
    MyByte = 70
    OutputByte ( MyByte )
    OutputByte ( MyByte )
    OutputByte ( MyByte )
    MyByteArray : SetAt ( 0 , 68 )
    OutputByte ( MyByte )
    MyByteArray : SetAt ( 1 , 69 )
    MyByteArray : SetAt ( 2 , 70 )
    
    MyByteArray : SetAt ( 3 , 68 )
    MyByteArray : SetAt ( 4 , 65 )
    MyByteArray : SetAt ( 5 , 68 )
    
    MyByte = MyByteArray : GetAt ( 0 )
    OutputByte ( MyByte )
    MyByte = MyByteArray : GetAt ( 1 )
    OutputByte ( MyByte )
    MyByte = MyByteArray : GetAt ( 2 )
    OutputByte ( MyByte )
    
    MyByte = MyByteArray : GetAt ( 3 )
    OutputByte ( MyByte )
    MyByte = MyByteArray : GetAt ( 4 )
    OutputByte ( MyByte )
    MyByte = MyByteArray : GetAt ( 5 )
    OutputByte ( MyByte )
    
    S6 = 0
    repeat while S6 < 10
        MyByteArray:Resize(S6 + 1)
        MyByteArray : SetAt ( S6 , 65 )
        GetFirstByteInDynam ( MyByteArray : DP )
        Byte NewByte
        NewByte = MyByteArray : GetAt ( S6 )
        OutputByte ( NewByte )
        S6 = S6 + 1
    end
    // Test Comment
    /* 
        Multi line comment
    */
end
