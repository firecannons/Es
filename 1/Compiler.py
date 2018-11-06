import sys

COMPILER_ARGUMENT_INDEX = 0
INPUT_FILE_ARGUMENT_INDEX = 1
OUTPUT_FILE_ARGUMENT_INDEX = 2

class FunctionItemParameter ( ) :

    def __init__ ( self ) :
        self . Name = ''
        self . Type = ''

    def __init ( self , Name , Type ) :
        self . Name = Name
        self . Type = Type

    def SetName ( self , Name ) :
        self . Name = Name

    def SetType ( self , Type ) :
        self . Type = Type
    

class FunctionItem ( ) :

    def __init__ ( self ) :
         self . Name = ''
         self . Parameters = [ ]

    def __init__ ( self , Name ) :
        self . Name = Name
        self . Parameters = [ ]

    def AddFunctionItemParameter ( self , Parameter ) :
        FunctionParameters = FunctionParameters . append ( Parameter )

    def SetName ( self , NewName ) :
        self . Name = NewName

class Error ( ) :
    
    MESSAGES = {
        'MISSING_FUNCTION_NAME' : 'Missing function name' ,
        'MISSING_OPENING_PARENTHESIS' :  'Missing opening parenthesis'
    }
    
    def __init ( self ) :
        pass

    
class Compiler ( ) :
    BEGINNING_TEXT = '''format ELF64 executable 3
segment readable executable
entry ProgramStart'''
    
    FILE_READ_FLAG = "r"
    FILE_WRITE_FLAG = "w"
    
    WHITE_SPACE_LETTERS = " \t\n\r"
    MEANINGFUL_LETTERS = '()[]<>,.'
    OPENING_PAREN = '('
    CLOSING_PAREN = ')'

    END_TEXT = 'end'
    
    ACTION_TEXT = 'action'
    ACTION_END_TEXT = END_TEXT

    NO_SAVED_WORD_LENGTH = 0

    SAVED_WORD_DEFAULT = ''

    DECLARING_ACTION_STATES = {
        'NONE' : 0 ,
        'WAITING_FOR_NAME' : 1 ,
        'WAITING_FOR_OPENING_PAREN' : 4 ,
        'WAITING_FOR_PARAM_START' : 2 ,
        'WAITING_FOR_PARAM_NAME' : 3 ,
        'WAITING_FOR_COMMA' : 6 ,
        'WAITING_FOR_CLOSING_PAREN' : 5
        }
    
    DEFAULT_ERROR_MESSAGE = ''
    NO_ERROR = False
    ERROR_EXISTS = True
    DEFAULT_ERROR_EXISTS = NO_ERROR
    
    NEGATIVE_ONE = -1

    FIND_NOT_FOUND = NEGATIVE_ONE
    
    ERROR = Error ( )
    
    def __init__ ( self ) :
        self . InitilizeStructuring ( )

    def InitilizeStructuring ( self ) :
        self . CurrentCharacter = None
        self . SavedWord = self . SAVED_WORD_DEFAULT
        self . FunctionTable = [ ]
        self . CurrentFunctionTableItem = None
        self . DeclaringActionProgress = self . DECLARING_ACTION_STATES [ 'NONE' ]
        self . DeclaringActionParameterNumber = 0
        self . ErrorExists = self . DEFAULT_ERROR_EXISTS
        self . ErrorMessage = self . DEFAULT_ERROR_MESSAGE
    
    def Compile ( self , InputFileName , OutputFileName ) :
        InputText = self . ReadInputFile ( InputFileName )
        OutputText = self . CalcOutputText ( InputText )
        self . WriteOutputFile ( OutputFileName , OutputText )
    
    def CalcOutputText ( self , InputText ) :
        OutputText = ''
        OutputText = OutputText + self . GetBeginningText ( )
        OutputText = OutputText + self . ProgramTranslation ( InputText )
        return OutputText
    
    def GetSpecialLetters ( self ) :
        return self . SPECIAL_LETTERS
    
    def IsLetterWhiteSpace ( self , Letter ) : 
        Output = False
        if self . WHITE_SPACE_LETTERS . find ( Letter ) != self . FIND_NOT_FOUND :
            Output = True
        return Output

    def IsLetterMeaningful ( self , Letter ) :
        Output = False
        if self . MEANINGFUL_LETTERS . find ( Letter ) != self . FIND_NOT_FOUND :
            Output = True
        return Output
    
    def CheckLetter ( self , Letter ) :
        WordFound = False
        if self . IsLetterSpecial ( Letter ) == True :
            WordFound = True
        return WordFound
    
    def IsWordFound ( self , InputText , Length , LetterIterator ) :
        WordFound = False
        if LetterIterator == Length - 1 :
            WordFound = True
        else :
            CurrentLetter = InputText [ LetterIterator ]
            WordFound = self . CheckLetter ( CurrentLetter )
        return WordFound
    
    def GetNextWord ( self , Position , InputText ) :
        LetterIterator = Position
        WordFound = False
        Length = len ( InputText )
        while WordFound == False :
            WordFound = self . IsWordFound ( InputText , Length , LetterIterator )
            LetterIterator = LetterIterator + 1
        LetterIterator = LetterIterator - 1
        return LetterIterator , Position

    def GetSavedWordLength ( self ) :
        SavedWordLength = len ( self . SavedWord )
        return SavedWordLength

    def IsAWordSaved ( self ) :
        Output = False
        if self . SAVED_WORD_DEFAULT != self . SavedWord :
            Output = True
        return Output

    def StartDeclaringAction ( self ) :
        self . DeclaringActionProgress = self . DECLARING_ACTION_STATES [ 'WAITING_FOR_NAME' ]

    def DetermineWordMeaning ( self ) :
        if IsDeclaringAction == True :
            self . FurtherDeclareAction ( )
        # Incomplete

    def IsOpeningParen ( self , Letter ) :
        Output = False
        if Letter == self . OPENING_PAREN :
            Output = True
        return Output
    
    def MissingOpeningParenthesis ( self ) :
        self . ErrorMessage = self . ERROR . MESSAGES [ 'MISSING_OPENING_PARENTHESIS' ]
        self . Error = self . ERROR_EXISTS
    
    def MissingFunctionName ( self ) :
        self . ErrorMessage = self . ERROR . MESSAGES [ 'MISSING_FUNCTION_NAME' ]
        self . Error = self . ERROR_EXISTS

    def ProcessOpeningParen ( self ) :
        if self . IsOpeningParen ( self . CurrentCharacter ) :
            self . DeclaringActionProgress = self . DECLARING_ACTION_STATES [ 'WAITING_FOR_PARAM_START' ]
        else :
            self . MissingOpeningParenthesis ( )

        # testing
        print ( 'eyy boy' , self . FunctionTable , len ( self . FunctionTable ) )
        # end testing

    def FurtherDeclareAction ( self ) :
        if self . DeclaringActionProgress == self . DECLARING_ACTION_STATES [ 'WAITING_FOR_NAME' ] :
            FunctionName = self . SavedWord
            NewFunctionItem = FunctionItem ( FunctionName )
            self . FunctionTable . append ( NewFunctionItem )
            self . DeclaringActionProgress = self . DECLARING_ACTION_STATES [ 'WAITING_FOR_OPENING_PAREN' ]
       # Incomplete for testing

    def DetermineSavedWordMeaning ( self ) :
        if True == self . DeclaringActionProgress != self . DECLARING_ACTION_STATES [ 'NONE' ]  :
            self . FurtherDeclareAction ( )

    def SavedWordSwitch ( self ) :
        if self . SavedWord == self . ACTION_TEXT :
            self . StartDeclaringAction ( )
        else :
            self . DetermineSavedWordMeaning ( )
        # Incomplete

    def EraseSavedWord ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT

    def DoIsWhiteSpaceInSetup ( self ) :
        if self . IsAWordSaved ( ) == True :
            self . SavedWordSwitch ( )
        self . EraseSavedWord ( )
    
    def MeaningfulLetterSwitch ( self ) :
        if self . DeclaringActionProgress == self . DECLARING_ACTION_STATES [ 'WAITING_FOR_OPENING_PAREN' ] :
            self . ProcessOpeningParen ( )
    
    def DoIsLetterMeaningfulInSetup ( self ) :
        if self . IsAWordSaved ( ) == True :
            self . SavedWordSwitch ( )
        else :
            self . MissingFunctionName ( )
        self . MeaningfulLetterSwitch ( )
        self . EraseSavedWord ( )

    def AddCharacterToSavedWord ( self ) :
        self . SavedWord = self . SavedWord + self . CurrentCharacter     

    def ProcessLetterInSetup ( self ) :
        if self . IsLetterMeaningful ( self . CurrentCharacter ) == True :
            self . DoIsLetterMeaningfulInSetup ( )
        elif self . IsLetterWhiteSpace ( self . CurrentCharacter ) == True :
            self . DoIsWhiteSpaceInSetup ( )
        else :
            self . AddCharacterToSavedWord ( )
    
    def DoesErrorExist ( self ) :
        Output = False
        if self . ErrorExists == self . ERROR_EXISTS :
            Output = True
        return Output
    
    def OutputError ( self ) :
        print ( self . ErrorMessage )

    def SetupProgramStructure ( self , InputText ) :
        Position = 0
        InputTextLength = len ( InputText )
        while ( Position < InputTextLength and self . DoesErrorExist ( ) == False ) :
            self . CurrentCharacter = InputText [ Position ]
            self . ProcessLetterInSetup ( )
            Position = Position + 1
            
        if self . DoesErrorExist ( ) == True :
            self . OutputError ( )
    
    def ProgramTranslation ( self , InputText ) :
        self . SetupProgramStructure ( InputText )
        return ''
        '''
        NewText = ""
        Position = 0
        InputTextLength = len ( InputText )
        while ( Position < InputTextLength ) :
            WordEnd , Position = self . GetNextWord ( Position , InputText )
            Word = InputText [ Position : WordEnd ]
            print ( "\"" , Word , "\"" )
            if Word == "text" :
                NewText = NewText + "\n"
                NewText = NewText + "sub rsp, 8"
            Position = WordEnd + 1
            '''
        return NewText
    
    def GetBeginningText ( self ) :
        BeginningText = self . BEGINNING_TEXT
        return BeginningText
    
    def ReadInputFile ( self , InputFileName ) :
        FileObject = open ( InputFileName , self . FILE_READ_FLAG )
        InputText = FileObject . read ( )
        return InputText
    
    def WriteOutputFile ( self , OutputFileName , OutputText ) :
        FileObject = open ( OutputFileName , self . FILE_WRITE_FLAG )
        FileObject . write ( OutputText )

class CompilerController ( ) :

    def __init__ ( self ) :
        pass
        
    def GetArguments ( self ) :
        PassedArguments = sys . argv
        return PassedArguments
    
    def GetInputFileName ( self , PassedArguments ) :
        InputFile = PassedArguments [ INPUT_FILE_ARGUMENT_INDEX ]
        return InputFile
    
    def GetOutputFileName ( self , PassedArguments ) :
        OutputFile = PassedArguments [ OUTPUT_FILE_ARGUMENT_INDEX ]
        return OutputFile
    
    def GetCompilationFileNames ( self ) :
        PassedArguments = self . GetArguments ( )
        InputFile = self . GetInputFileName ( PassedArguments )
        OutputFile = self . GetOutputFileName ( PassedArguments )
        return InputFile , OutputFile

    def Run ( self ) :
        InputFile , OutputFile = self . GetCompilationFileNames ( )
        TheCompiler = Compiler ( )
        TheCompiler . Compile ( InputFile , OutputFile )

TheController = CompilerController ( )
TheController . Run ( )