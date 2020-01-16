using Libraries . StandardLibraries

action OutputAnInt ( Integer I ) returns Text
    Text ArNums
    Integer Index = 0
    Integer OutI = I
    repeat while OutI > 10
        Integer Rem = OutI:Remainder(10)
        OutI = OutI / 10
        Byte BRem = Rem
        ArNums:Add(BRem)
        Index = Index + 1
    end
    Byte One = 1
    ArNums:SetAt(Index, One)
    OutputAsByteDigits(ArNums)
end

action Main
    Byte B = 5
    OutputByteDigit(B)
    
    Array<Byte> ArBy
    ArBy:Add(B)
    OutputByteDigit(ArBy:GetAt(0))
    
    
    Byte One = 1
    Byte Two = 2
    Byte Three = 3
    Text T
    T:Add(One)
    T:Add(Two)
    T:Add(Three)
    
    OutputAsByteDigits(T)
    
    Integer I = 1234567
    Output ( I )
end
