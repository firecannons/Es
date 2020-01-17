using Libraries . StandardLibraries

action Main
    Text T = 'Lets square a number.  Type in a number (whose square is a single digit): '
    Text IsSquareText = ' is the square of '
    OutputNoNewline(T)
    Integer InputInteger = Input():ParseInteger()
    Integer SquaredInteger = InputInteger * InputInteger
    T = SquaredInteger:GetText() + IsSquareText + InputInteger:GetText()
    Output(T)
end
