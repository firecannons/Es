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
    
    action Add ( Text T )
        Me : Letters : Add ( T : Letters )
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
    
    action + ( Byte B ) returns Text
        Text OldT = Me
        OldT : Letters = OldT : Letters + B
        return OldT
    end
    
    action + ( Text T ) returns Text
        Text OldT = Me
        OldT : Letters = OldT : Letters + T : Letters
        return OldT
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
    
    action ParseInteger() returns Integer
        Text NewMe = Me
        NewMe:DeepReverse()
        Integer Result = 0
        Integer TenPower = 1
        Integer Index = 0
        repeat while Index < NewMe:GetSize()
            Integer TempInt = NewMe:GetAt(Index):GetInteger() - 48
            Result = Result + TenPower * TempInt
            TenPower = TenPower * 10
            Index = Index + 1
        end
        return Result
    end
    
    action CopyFromPointer(Pointer<Byte> P, Integer Size)
        DynamicMemory DM
        DM:CopyMemory(Me:Letters:P, P, Size)
    end
end
