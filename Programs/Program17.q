using Libraries . StandardLibraries

action Main
    Text T
    Byte B = 4
    T:Add(B)
    B = 5
    T:Add(B)
    B = 6
    T:Add(B)
    
    Integer I = T:ParseInteger()
    Output(I)
end
