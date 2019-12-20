using Libraries . Array
using Libraries . DataTypes

class Text
    Array<Byte> Letters


    action Text
    end

    action Resize ( Integer Size )
        Me : Letters : Resize ( Size )
    end

    action GetAt( Integer Position ) returns Byte
        return Me : Letters : GetAt ( Position )
    end
    
    action SetAt(Integer Position, Byte Elem)
        Me : Letters : SetAt ( Position , Elem )
    end
end
