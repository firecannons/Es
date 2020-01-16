using Libraries . Array
using Libraries . DataTypes

class Text
    Array<Byte> Letters

    action Resize ( Integer Size )
        Me : Letters : Resize ( Size )
    end
    
    action Add ( Byte B )
        Me : Letters : Add ( B )
    end
    
    action AddAt ( Integer Location, Byte Item )
        Me : Letters : AddAt ( Location , Item )
    end
    
    action RemoveAt ( Integer Position ) returns Byte
        return Me : Letters : RemoveAt ( Position )
    end
    
    action Find ( Byte B )
        Me : Letters : Find ( B )
    end
    
    action Contains ( Byte B )
        Me : Letters : Contains ( B )
    end
    
    action + ( Byte B )
        Me : Letters = Me : Letters + B
    end
    
    action GetSize ( ) returns Integer
        return Me : Letters : Size
    end

    action GetAt( Integer Position ) returns Byte
        return Me : Letters : GetAt ( Position )
    end
    
    action SetAt(Integer Position, Byte Elem)
        Me : Letters : SetAt ( Position , Elem )
    end
    
    action DeepReverse()
        Me:Letters:DeepReverse()
    end
end
