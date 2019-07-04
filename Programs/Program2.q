using Libraries.DataTypes
using Libraries.DynamicMemory

action asm OutputByte ( Byte L )
    ; load a pointer to the byte in ecx
    mov ecx, ebp
    add ecx, 8
    mov ecx, [ecx]
    
    ; Set other values
    mov	eax, 4
    mov	ebx, 1
	mov	edx, 1
	int	0x80
end

action asm OutputByte3 ( Byte L , Byte L2 , Byte L3 )
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
        ; load DP into ebx
        mov ebx, ebp
        add ebx, 8
        mov ebx, [ebx]
        add ebx, 4
        mov ebx, [ebx]
        
        ; load Position into edx
        mov edx, ebp
        add edx, 12
        mov edx, [edx]
        mov edx, [edx]
        
        ; Perform arithmetic to find correct memory position into ebx
        mov eax, SizeOf(T)
        mul edx
        add ebx, eax
        
        add esp, -1
        mov byte [esp], 70
        mov eax, esp
        add esp, -4
        mov [esp], eax
        call OutputByte
        add esp, 5
        
        ; Load the ebx position onto the stack
        add esp, -4
        mov [esp], ebx
        
        ; Load the ebx position onto the stack
        mov ebx, ebp
        add ebx, 16
        mov ebx, [ebx]
        add esp, -4
        mov [esp], ebx
        
        call GetResolvedClassName(T)On_Equals
        
        add esp, -1
        mov byte [esp], 67
        mov eax, esp
        add esp, -4
        mov [esp], eax
        call OutputByte
        add esp, 5
        
        ; Move the stack pointer back up
        add esp, 8
        
        
    end
    
    action asm GetAt(Byte Position) returns T
        ; load DP into ebx
        mov ebx, ebp
        add ebx, 12
        mov ebx, [ebx]
        add ebx, 4
        mov ebx, [ebx]
        
        ; load Position into edx
        mov edx, ebp
        add edx, 12
        mov edx, [edx]
        mov edx, [edx]
        
        ; Perform arithmetic to find correct memory position into ebx
        mov eax, SizeOf(T)
        mul edx
        add ebx, eax
        
        ; Load the ebx position onto the stack
        mov ebx, ebp
        add ebx, 16
        add ebx, SizeOf(T)
        add esp, -4
        mov [esp], ebx
        
        ; Load the ebx position onto the stack
        add esp, -4
        mov [esp], ebx
        
        call GetResolvedClassName(T)On_Equals
        
        ; Move the stack pointer back up
        add esp, 8
        
        
    end
    
    action Append ( T NewElem )
        Byte testy = 70
        OutputByte ( testy )
        OutputByte ( testy )
        Me : Size = Me : Size + 1
        if Me : Size > Me : MemorySize
            //Me : MemorySize = Me : Size * 2
            Me : MemorySize = Me : Size
            Me : DP = AllocateHeapMemory( Me:MemorySize )
        end
        Byte NewSize = Me:Size - 1
        Byte PrintSize = NewSize + 90
        OutputByte ( PrintSize )
        Me : SetAt(NewSize, NewElem)
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
    Pointer DB = AllocateHeapMemory ( Size )
    
    //Array<Byte> MyAr
    
    TemplateTest<Byte> TeTe
    
    MultiTemplateTest<Byte,Byte,Integer> MuTeTe
    
    RefTemplateTest<Byte reference,Byte,Integer> RefTeTe
    
    Byte MyByte = 66
    OutputByte ( MyByte )
    Array<Byte> MyByteArray
    OutputByte ( MyByte )
    MyByteArray:Append(MyByte)
    OutputByte ( MyByte )
    MyByte = MyByteArray:GetAt(0)
    OutputByte ( MyByte )
    
end
