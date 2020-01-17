using Libraries . StandardLibraries

action Main
    Text AdderIntText
    /*Byte Temp = 1 + 48
    AdderIntText:Add(Temp)
    Temp = 2 + 48
    AdderIntText:Add(Temp)
    Temp = 4 + 48
    AdderIntText:Add(Temp)
    Output(AdderIntText)*/
    
    AdderIntText = Input()
    Integer AdderInt = AdderIntText:ParseInteger()
    AdderInt = AdderInt + 1
    Output(AdderInt)
    Output(48:GetText())
end
