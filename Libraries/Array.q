using Libraries . DataTypes
using Libraries . DynamicMemory

class Array < Type >
        Pointer < Type > P
        Integer Size
        Integer ReservedSize
        
        action Array
        end
        
        action Initialize()
            Me:Size = 0
            Me:ReservedSize = 0
            Me:P:Position = 0
        end
        
        action SetMemorySize ( Integer Size )
            DynamicMemory < Type > DM
            Me : P = DM : AllocateHeapMemory ( Size )
            Me : ReservedSize = Size
            if Me : ReservedSize < Me : Size
                Me : Size = Me : ReservedSize
            end
        end

        action Resize ( Integer Size )
            DynamicMemory < Type > DM
            Byte Nine = 9
            OutputByteDigit(Nine)
            Me : P = DM : AllocateHeapMemory ( Size )
            OutputByteDigit(Nine)
            //Me : P = DM : ReallocateHeapMemory ( Size , P , Me:ReservedSize )
            Me : ReservedSize = Size
        end
        
        action Add ( Type Item )
            Byte Four = 4
            if Me:Size == Me:ReservedSize
                Me:Resize(Me:ReservedSize + 1)
            end
            OutputByteDigit(Four)
            Me:SetAt(Me:Size, Item)
            OutputByteDigit(Four)
            Me:Size = Me:Size + 1
        end

        action asm GetAt( Integer Position ) returns Type
                push ebp
                mov ebp, esp

                ; load P into ecx
                mov ebx, ebp
                add ebx, 8
                mov ebx, [ebx]
                add ebx, 0
                mov dword ecx, [ebx]

                ; mov value of Position into eax
                mov eax, ebp
                add eax, 12
                mov eax, [eax]
                mov dword eax, [eax]

                ; perform addition
                mov edx, GetSize(Type)
                mul dl
                
                
                
                
                add dword ecx, eax

                ; Load the ebx position onto the stack
                add esp, -4
                mov [esp], ecx
                
                ; Load the return position
                mov ebx, ebp
                add ebx, 16
                add esp, -4
                mov [esp], ebx
                
                call GetAction(Type:=)(0)
                
                ; Move the stack pointer back up
                add esp, 8

                mov esp, ebp
                pop ebp        
        end
        
        action asm SetAt(Integer Position, Type Elem)
                push ebp
                mov ebp, esp

                ; load P into ecx
                mov ebx, ebp
                add ebx, 8
                mov ebx, [ebx]
                add ebx, 0
                mov dword ecx, [ebx]

                ; mov value of Position into eax
                mov eax, ebp
                add eax, 12
                mov eax, [eax]
                mov dword eax, [eax]

                ; perform addition
                mov edx, GetSize(Type)
                mul dl
                
                
                
                
                
                
                
                
                
                add dword ecx, eax
                
                
                
                ; Load Elem
                mov ebx, ebp
                add ebx, 16
                mov ebx, [ebx]
                add esp, -4
                mov [esp], ebx

                ; Load the array position
                add esp, -4
                mov [esp], ecx
                mov edi, ecx
                
                call GetAction(Type:=)(0)
                
                ; Move the stack pointer back up
                add esp, 8

                mov esp, ebp
                pop ebp        
        end
end
