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
                
                sub esp, 1
                mov byte [esp], 105
                mov ebx, esp
                
                sub esp, 4
                mov [esp], ebx
                call GetAction(OutputByte)(0)

                ; load P into ecx
                mov ebx, ebp
                add ebx, 8
                mov ebx, [ebx]
                add ebx, 4
                mov dword ecx, [ebx]

                ; mov value of Position into eax
                mov edx, ebp
                add edx, 12
                mov edx, [edx]
                mov dword edx, [edx]

                ; perform addition
                mov eax, GetSize(Type)
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
end
