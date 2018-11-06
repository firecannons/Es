import sys
import pprint

COMPILER_ARGUMENT_INDEX = 0
INPUT_FILE_ARGUMENT_INDEX = 1
OUTPUT_FILE_ARGUMENT_INDEX = 2
EMPTY_STRING = ''

class FunctionItemParameter ( ) :

    def __init__ ( self ) :
        self . Name = EMPTY_STRING
        self . Type = EMPTY_STRING

    def SetName ( self , Name ) :
        self . Name = Name

    def SetType ( self , Type ) :
        self . Type = Type
    

class FunctionItem ( ) :

    def __init__ ( self ) :
         self . Name = EMPTY_STRING
         self . Parameters = [ ]

    def AddFunctionItemParameter ( self , Parameter ) :
        self . Parameters . append ( Parameter )

    def SetName ( self , NewName ) :
        self . Name = NewName

class Parser ( ) :
    
    MAIN_STATES = {
        'START_OF_LINE' : 0 ,
        'AFTER_USING' : 1
    }
    
    KEYWORDS = {
        'USING' : 'using'
    }
    
    SPECIAL_CHARS = {
        'NEWLINE' : '\n' ,
        'PERIOD' : '.' ,
        'FORWARD_SLASH' : '/' ,
    }
    
    PROGRAM_EXTENSION = 'q'
    
    EMPTY_STRING = ''
    
    def __init__ ( self ) :
        self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        self . SavedLine = ''
    
    def Parse ( self , SavedWordArray ) :
        WordIndex = 0
        while WordIndex < len ( SavedWordArray ) :
            Token = SavedWordArray [ WordIndex ]
            SavedWordArray = self . ParseToken ( Token , SavedWordArray , WordIndex )
            print ( Token , ' = token ' , WordIndex , ' = WordIndex ' , SavedWordArray , '\n\n' )
            WordIndex = WordIndex + 1
        return '' , SavedWordArray
    
    def ParseToken ( self , Token , SavedWordArray , WordIndex ) :
        if self . State == self . MAIN_STATES [ 'START_OF_LINE' ] :
            if Token == self . KEYWORDS [ 'USING' ] :
                self . State = self . MAIN_STATES [ 'AFTER_USING' ]
        elif self . State == self . MAIN_STATES [ 'AFTER_USING' ] :
            if Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                Path = self . ConvertToPath ( self . SavedLine )
                Path = Path + self . SPECIAL_CHARS [ 'PERIOD' ] + self . PROGRAM_EXTENSION
                Text = self . ReadFile ( Path )
                MyLexer = Lexer ( )
                NewTokens = MyLexer . MakeTokens ( Text )
                FirstWordArray = SavedWordArray [ 0 : WordIndex + 1 : ]
                SecondWordArray = SavedWordArray [ WordIndex : len ( SavedWordArray ) : ]
                SavedWordArray = FirstWordArray + NewTokens + SecondWordArray
                print ( NewTokens , SavedWordArray )
                self . SavedLine = ''
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                self . SavedLine = self . SavedLine + Token
        return SavedWordArray
    
    def ConvertToPath ( self , Text ) :
        Text = Text . replace ( self . SPECIAL_CHARS [ 'PERIOD' ] , self . SPECIAL_CHARS [ 'FORWARD_SLASH' ] )
        return Text
    
    def ReadFile ( self , Path ) :
        file = open ( Path , 'r' ) 
        Text = file . read ( ) 
        file . close ( )
        return Text
                
        
        

class Lexer ( ) :
    WHITE_SPACE_LETTERS = " \t\r"
    MEANINGFUL_LETTERS = '()[]<>,.\n'
    
    EMPTY_ARRAY = [ ]
    
    SAVED_WORD_DEFAULT = ''
    SAVED_WORD_ARRAY_DEFAULT = EMPTY_ARRAY
    
    NEGATIVE_ONE = -1

    FIND_NOT_FOUND = NEGATIVE_ONE
    
    def __init__ ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT
        self . SavedWordArray = [ ]
    
    def AppendToSavedWordArray ( self , Text ) :
        self . SavedWordArray . append ( Text )
    
    def AddCharacterToSavedWord ( self ,
        CurrentCharacter ) :
        self . SavedWord = self . SavedWord + CurrentCharacter 
    
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
    
    def IsLetterSpecial ( self , Letter ) :
        Output = False
        if self . IsLetterWhiteSpace ( Letter ) == True :
            Output = True
        elif self . IsLetterMeaningful ( Letter ) == True :
            Output = True
        return Output
    
    def DoLetterIsWhiteSpaceInSetup ( self ,
        CurrentLetter ) :
        if self . IsSavedWordExisting ( ) == True :
            self . AppendToSavedWordArray ( self . SavedWord )
            self . EraseSavedWord ( )
        pass
    
    def IsSavedWordExisting ( self ) :
        Output = False
        if self . SavedWord != self . SAVED_WORD_DEFAULT :
            Output = True
        return Output
    
    def DoLetterIsMeaningfulInSetup ( self ,
        CurrentLetter ) :
        if self . IsSavedWordExisting ( ) == True :
            self . AppendToSavedWordArray ( self . SavedWord )
        self . AppendToSavedWordArray ( CurrentLetter )
        self . EraseSavedWord ( )
    
    def EraseSavedWord ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT

    def ProcessLetterInSetup ( self ,
        CurrentLetter ) :
        if self . IsLetterWhiteSpace ( CurrentLetter ) == True :
            self . DoLetterIsWhiteSpaceInSetup ( CurrentLetter )
        elif self . IsLetterMeaningful ( CurrentLetter ) :
            self . DoLetterIsMeaningfulInSetup ( CurrentLetter )
        else :
            self . AddCharacterToSavedWord ( CurrentLetter )
    
    def MakeTokens ( self , InputText ) :
        Position = 0
        InputTextLength = len ( InputText )
        while ( Position < InputTextLength ) :
            CurrentLetter = InputText [ Position ]
            self . ProcessLetterInSetup ( CurrentLetter )
            Position = Position + 1
        if self . SavedWord != '' :
            self. SavedWordArray . append ( self . SavedWord )
        return self . SavedWordArray

class Compiler ( ) :
    BEGINNING_TEXT = '''format ELF64 executable 3
segment readable executable
entry ProgramStart'''
    
    FILE_READ_FLAG = "r"
    FILE_WRITE_FLAG = "w"
    
    WHITE_SPACE_LETTERS = " \t\n\r"
    MEANINGFUL_LETTERS = '()[]<>,.'
    SPECIAL_CHARS = WHITE_SPACE_LETTERS + MEANINGFUL_LETTERS

    END_TEXT = 'end'
    
    ACTION_TEXT = 'action'
    ACTION_END_TEXT = END_TEXT

    NO_SAVED_WORD_LENGTH = 0

    SAVED_WORD_DEFAULT = ''
    SAVED_PARAMETER_TYPE_DEFAULT = ''
    SAVED_FUNCTION_ITEM_DEFAULT = None

    DECLARING_ACTION_STATES = {
        'NONE' : 0 ,
        'WAITING_FOR_NAME' : 1 ,
        'WAITING_FOR_OPENING_PAREN' : 4 ,
        'WAITING_FOR_PARAM_START' : 2 ,
        'WAITING_FOR_PARAM_NAME' : 3 ,
        'WAITING_FOR_COMMA' : 6
        }
    
    DECLARING_CLASS_STATES = {
            'NONE' : 0 ,
            'WAITING_FOR_NAME' : 1
        }
    
    NEGATIVE_ONE = -1

    FIND_NOT_FOUND = NEGATIVE_ONE
    
    def __init__ ( self ) :
        self . InitilizeStructuring ( )

    def InitilizeStructuring ( self ) :
        self . CurrentCharacter = None
        self . SavedWord = self . SAVED_WORD_DEFAULT
        self . FunctionTable = [ ]
        self . CurrentFunctionTableItem = None
        self . DeclaringActionProgress = self . DECLARING_ACTION_STATES [ 'NONE' ]
        self . DeclaringActionParameterNumber = 0
        self . SavedParameterType = self . SAVED_PARAMETER_TYPE_DEFAULT
        self . SavedFunctionItem = self . SAVED_FUNCTION_ITEM_DEFAULT
        self . SavedWordArray = [ ]
    
    def Compile ( self , InputFileName , OutputFileName ) :
        InputText = self . ReadInputFile ( InputFileName )
        OutputText = self . CalcOutputText ( InputText )
        self . WriteOutputFile ( OutputFileName , OutputText )
    
    def CalcOutputText ( self , InputText ) :
        OutputText = ''
        OutputText = OutputText + self . GetBeginningText ( )
        OutputText = OutputText + self . ProgramTranslation ( InputText )
        return OutputText
    
    def ProgramTranslation ( self , InputText ) :
        MyLexer = Lexer ( )
        MyParser = Parser ( )
        SavedWordArray = MyLexer . MakeTokens ( InputText )
        NewText , SavedWordArray = MyParser . Parse ( SavedWordArray )
        for i in SavedWordArray :
            print ( i )
        return ''
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
