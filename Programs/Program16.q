using Libraries . StandardLibraries

action Main
    Integer I = 1234567
    Text T = I:GetText()
    Output(T)
    
    Byte B = T:RemoveAt(3)
    Output(B)
    
    Output(T)
    
    T:AddAt(3, B)
    Output(T)
end
