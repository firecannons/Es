using Libraries . DataTypes
using Libraries . DynamicMemory

class Array < Type >
        Integer Size
        Pointer < Type > P
        
        action Array
        end

        action Resize ( Integer Size )
                DynamicMemory < Type > DM
                Me : P = DM : AllocateHeapMemory ( Size )
        end

        action asm GetAt( Integer Position ) returns Type
                push ebp
                mov ebp, esp

                ; load P into ecx
                mov ebx, ebp
                add ebx, 8
                mov ebx, [ebx]
                add ebx, 4
                mov dword ecx, [ebx]
                
                ;sub esp, 1
                ;mov byte [esp], cl
                ;mov esi, esp
                ;
                ;sub esp, 4
                ;mov [esp], esi
                ;call GetAction(OutputByte)(0)
                ;add esp, 5

                ; mov value of Position into eax
                mov eax, ebp
                add eax, 12
                mov eax, [eax]
                mov dword eax, [eax]

                ; perform addition
                mov edx, GetSize(Type)
                mul dl
                
                
                
                
                
                
                
                ;sub esp, 1
                ;mov byte [esp], al
                ;mov esi, esp
                ;
                ;sub esp, 4
                ;mov [esp], esi
                ;call GetAction(OutputByteDigit)(0)
                ;add esp, 5
                
                
                
                
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
                
                ;sub esp, 1
                ;mov byte [esp], 105
                ;mov esi, esp
                
                ;sub esp, 4
                ;mov [esp], esi
                ;call GetAction(OutputByte)(0)
                ;add esp, 5

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
                add ebx, 4
                mov dword ecx, [ebx]

                ; mov value of Position into eax
                mov eax, ebp
                add eax, 12
                mov eax, [eax]
                mov dword eax, [eax]

                ; perform addition
                mov edx, GetSize(Type)
                mul dl
                
                
                
                
                
                
                
                ;sub esp, 1
                ;mov byte [esp], al
                ;mov esi, esp
                ;
                ;sub esp, 4
                ;mov [esp], esi
                ;call GetAction(OutputByteDigit)(0)
                ;add esp, 5
                
                
                
                
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
