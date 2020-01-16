using Libraries . DataTypes
using Libraries . Array
using Libraries . IOOperations

action Main
    
    Byte B = 2
    Byte Mult = 4
    B = B * Mult
    OutputByteDigit(B) // 4 * 2 = 8
    Byte TwoByte = 2
    OutputByteDigit(TwoByte) // 2
    OutputByteDigit(B) // 8
    B = B / TwoByte
    OutputByteDigit(B) // 4
    B = B / TwoByte
    OutputByteDigit(B) // 2
    
    B = 8
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 0
    
    B = 9
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 1
    
    B = 10
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 0
    
    B = 11
    Byte Modulus = B:Remainder(TwoByte)
    OutputByteDigit(Modulus) // 1
    
    Integer I = 1234567
    Output ( I )
end
