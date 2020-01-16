// comment test
/* comment test > 2 */
/* comment
test 3*/

//using Libraries . Text

class Integer size 4
        
        action asm = ( Integer Source )
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov eax, [eax]
            
            ; mov address of return dword into ebx
            sub ebx, 4
            mov ebx, [ebx]
            
            ; mov value of eax into position of [ebx]
            mov dword [ebx], eax
            
            
            
            
            
            ;mov ecx, ebx
            ; Set other values
            ;mov	eax, 4
            ;mov	ebx, 1
            ;mov	edx, 1
            ;int	0x80
            
            mov esp, ebp
            pop ebp
        end
        
        action asm + ( Integer Rhs ) returns Integer
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform addition
            add dword ecx, eax
            
            ; mov value into return area
            add ebx, 8
            mov dword [ebx], ecx
            
            mov esp, ebp
            pop ebp
        end
        
        action asm - ( Integer Rhs ) returns Integer
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform subtraction
            sub dword ecx, eax
            
            ; mov value into return area
            add ebx, 8
            mov dword [ebx], ecx
            
            mov esp, ebp
            pop ebp
        end
        
        action asm - ( ) returns Integer
            push ebp
            mov ebp, esp
            
            mov ebx, [ebp+8]
            mov eax, [ebx]
            
            neg eax
            
            mov [ebx], eax
            
            mov esp, ebp
            pop ebp
        end
        
        action asm > ( Integer Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setg byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        end
        
        action asm >= ( Integer Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setge byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        end
        
        action asm == ( Integer Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            sete byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm < ( Integer Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setl byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm <= ( Integer Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setle byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm != ( Integer Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform comparison
            cmp dword ecx, eax
            setne byte al
            
            ; move resultto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm * ( Integer Rhs ) returns Integer
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov dword eax, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov dword ecx, [ecx]
            
            ; perform multiplication
            imul ecx
            
            ; mov value into return area
            add ebx, 8
            mov dword [ebx], eax
            
            mov esp, ebp
            pop ebp
        end
        
        action asm / ( Integer Rhs ) returns Integer
            push ebp
            mov ebp, esp
            
            ; mov value of Me into eax
            mov eax, [ebp+8]
            mov eax, [eax]
            cdq
            
            ; load in the object into ecx
            mov ecx, [ebp+12]
            mov ecx, [ecx]
            
            ; perform division
            idiv ecx
            
            ; mov value into return area
            mov [ebp+16], eax
            
            mov esp, ebp
            pop ebp
        end
        
        action asm Remainder ( Integer Rhs ) returns Integer
            push ebp
            mov ebp, esp
            
            ; mov value of Me into eax
            mov eax, [ebp+8]
            mov eax, [eax]
            cdq
            
            ; load in the object into ecx
            mov ecx, [ebp+12]
            mov ecx, [ecx]
            
            ; perform division
            idiv ecx
            
            ; mov value into return area
            mov [ebp+16], edx
            
            mov esp, ebp
            pop ebp
        end
        
        action GetText ( ) returns Text
            Text ArNums
            Integer Index = 0
            Integer OutI = Me
            repeat while OutI > 10
                Integer Rem = OutI:Remainder(10)
                OutI = OutI / 10
                Byte BRem = Rem
                ArNums:Add(BRem + 48)
                Index = Index + 1
            end
            Byte One = 1
            ArNums:Add(One + 48)
            ArNums:DeepReverse()
            return ArNums
        end
end

class Byte size 1
        
        action asm Constructor
            push ebp
            mov ebp, esp
            
            ; asm comment
            ; mov address of the object into
            mov ebx, ebp
            add ebx, 8
            mov eax, [ebx]
            
            mov byte [eax], 4
            
            mov esp, ebp
            pop ebp
        end
        
        action asm Constructor ( Byte InB )
            push ebp
            mov ebp, esp
            
            ; asm comment
            ; mov address of the object into
            mov ebx, [ebp+8]
            mov eax, [ebp+12]
            
            mov byte al, [eax]
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm Destructor
            push ebp
            mov ebp, esp
            
            ; asm comment
            ; mov address of the object into
            mov ebx, [ebp+8]
            
            mov byte [ebx], 5
            
            mov esp, ebp
            pop ebp
        end
        
        action asm = ( Byte Source )
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov eax, [eax]
            
            ; mov address of return byte into ebx
            sub ebx, 4
            mov ebx, [ebx]
            
            ; mov value of eax into position of [ebx]
            mov byte [ebx], al
            
            
            
            
            
            ;mov ecx, ebx
            ; Set other values
            ;mov	eax, 4
            ;mov	ebx, 1
            ;mov	edx, 1
            ;int	0x80
            
            mov esp, ebp
            pop ebp
        end

        action asm = ( Integer Source )
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov eax, [eax]
            
            ; mov address of return byte into ebx
            sub ebx, 4
            mov ebx, [ebx]
            
            ; mov value of eax into position of [ebx]
            mov byte [ebx], al
            
            
            
            
            
            ;mov ecx, ebx
            ; Set other values
            ;mov	eax, 4
            ;mov	ebx, 1
            ;mov	edx, 1
            ;int	0x80
            
            mov esp, ebp
            pop ebp
        end
        
        action asm + ( Byte Rhs ) returns Byte
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform addition
            add byte cl, al
            
            ; mov value into return area
            add ebx, 8
            mov byte [ebx], cl
            
            mov esp, ebp
            pop ebp
        end
        
        action asm + ( Integer Rhs ) returns Byte
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform addition
            add byte cl, al
            
            ; mov value into return area
            add ebx, 8
            mov byte [ebx], cl
            
            mov esp, ebp
            pop ebp
        end
        
        action asm - ( Byte Rhs ) returns Byte
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform addition
            sub byte cl, al
            
            ; mov value into return area
            add ebx, 8
            mov byte [ebx], cl
            
            mov esp, ebp
            pop ebp
        end
        
        action asm > ( Byte Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setg byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        end
        
        action asm >= ( Byte Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setge byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm == ( Byte Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            sete byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm < ( Byte Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setl byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        end
        
        action asm <= ( Byte Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setle byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm != ( Byte Rhs ) returns Bool
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform comparison
            cmp byte cl, al
            setne byte al
            
            ; move result onto stack
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
            
        end
        
        action asm * ( Byte Rhs ) returns Byte
            push ebp
            mov ebp, esp
            
            ; mov value of Source into eax
            mov ebx, ebp
            add ebx, 12
            mov eax, [ebx]
            mov byte al, [eax]
            
            ; load in the object into ecx
            sub ebx, 4
            mov ecx, [ebx]
            mov byte cl, [ecx]
            
            ; perform multiplication
            imul cl
            
            ; mov value into return area
            add ebx, 8
            mov byte [ebx], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm / ( Byte Rhs ) returns Byte
            push ebp
            mov ebp, esp
            
            ; mov value of Me into eax
            mov eax, [ebp+8]
            mov byte al, [eax]
            cbw
            
            ; load in Rhs into ecx
            mov ecx, [ebp+12]
            mov byte cl, [ecx]
            
            ; perform division
            idiv cl
            
            ; mov value into return area
            mov byte [ebp+16], al
            
            mov esp, ebp
            pop ebp
        end
        
        action asm Remainder ( Byte Rhs ) returns Byte
            push ebp
            mov ebp, esp
            
            ; mov value of Me into eax
            mov eax, [ebp+8]
            mov byte al, [eax]
            cbw
            
            ; load in Rhs into ecx
            mov ecx, [ebp+12]
            mov byte cl, [ecx]
            
            ; perform division
            idiv cl
            
            ; mov value into return area
            mov byte [ebp+16], ah
            
            mov esp, ebp
            pop ebp
        end

        action asm OutputToConsole ( )
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
end

class Bool size 1
    Byte Value
    
    action AssignNumericValue(Integer I)
        Me:Value = I
    end
    
    action =(Integer I)
        Me:Value = I
    end
end

Bool True = 1
Bool False = 0

class Pointer<T>
    Integer Position
    
    action Constructor
    end
    
    action = ( Pointer<T> Source )
        Me : Position = Source : Position
    end
    
    action == ( Pointer<T> Source ) returns Bool
        return Me:Position == Source:Position
    end
    
    action != ( Pointer<T> Source ) returns Bool
        return Me:Position != Source:Position
    end

    //action Deref ( ) returns T
    //end

    action asm Dereference ( ) returns T reference
        push ebp
        mov ebp, esp
        
        ; Put &Position into ecx
        mov ecx, [ebp+8]
        mov ecx, [ecx]
        
        ; Put &T into eax
        mov [ebp+12], ecx
        
        mov esp, ebp
        pop ebp
    end
    
    action asm PointTo(T Object)
        push ebp
        mov ebp, esp
    
        ; Put &Object into eax
        mov eax, [ebp+12]
        
        ; Put &Position into ecx
        mov ecx, [ebp+8]
        
        ; Put &Object(eax) into Position([ecx])
        mov [ecx], eax
        
        mov esp, ebp
        pop ebp
    end
end

class Box<T>
    T MyT
    //Pointer<T> MyP

    action Constructor
    end

    action = ( Box<T> Source )
        Me:MyT = Source:MyT
    end
end

/*
action asm Reference<T>(T) returns Pointer<T>
    mov ebx, ebp
    add ebx, 12
    mov [ebx+8], ebx
end*/

class CapTest
    Byte B1
    Byte B2
end

class CapTest2
    CapTest C1
    CapTest C2
    
    action Constructor
    end
end

class CapTest3
    CapTest2 C1
    CapTest2 C2
    
    action Constructor
    end
end
