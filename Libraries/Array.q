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
end
