using Libraries . DataTypes
using Libraries . DynamicMemory

class Array < Type >
        Pointer < Type > P
        Integer Size
        Integer ReservedSize
        
        action Constructor
            Me:Size = 0
            Me:ReservedSize = 0
            Me:P:Position = 0
        end
        
        action Destructor
            DynamicMemory < Type > DM
            if Me:ReservedSize != 0
                DM:DeallocateHeapMemory(Me:P, Me:ReservedSize)
            end
        end
        
        action Initialize
            Me:Constructor()
        end
        
        action SetMemorySize ( Integer Size )
            DynamicMemory < Type > DM
            Me : P = DM : AllocateHeapMemory ( Size, Me:P )
            Me : ReservedSize = Size
            if Me : ReservedSize < Me : Size
                Me : Size = Me : ReservedSize
            end
        end

        action Resize ( Integer Size )
            DynamicMemory < Type > DM
            Me : P = DM : ReallocateHeapMemory ( Size , Me : P , Me:ReservedSize )
            Me : ReservedSize = Size
        end
        
        action Add ( Type Item )
            if Me:Size == Me:ReservedSize
                Me:Resize(Me:ReservedSize + 1)
            end
            Me:SetAt(Me:Size, Item)
            Me:Size = Me:Size + 1
        end
        
        action = ( Array<Type> Source )
            DynamicMemory DM
            Pointer<Type> OldP = Me:P
            Me:P = DM:AllocateHeapMemory(Source:ReservedSize, Me:P)
            Me:CopyElementsToMe(Source)
            DM:DeallocateHeapMemory(OldP, Me:ReservedSize)
            Me:ReservedSize = Source:ReservedSize
            Me:Size = Source:Size
        end
        
        action CopyElementsToMe(Array<Type> Source)
            Integer Index = 0
            repeat while Index < Source:Size
                Me:SetAt(Index, Source:GetAt(Index))
                Index = Index + 1
            end
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
