import sys
import pprint
from copy import deepcopy

COMPILER_ARGUMENT_INDEX = 0
INPUT_FILE_ARGUMENT_INDEX = 1
OUTPUT_FILE_ARGUMENT_INDEX = 2
EMPTY_STRING = ''

def PrintObject ( Object , Level = 0 ) :
    if isinstance(Object, dict):
        for Item in list(set(Object.keys())):
            print ( ( '\t' * Level) + str ( Item ) + ' : ' + str ( Object [ Item ] ) )
            PrintObject ( Object [ Item ] , Level + 1 )
    elif isinstance(Object, list):
        for Item in Object:
            print ( ( '\t' * Level) + str ( Item ) )
            PrintObject ( Item , Level + 1 )
    elif hasattr(Object, '__dict__'):
        for Item in Object . __dict__ :
            print ( ( '\t' * Level) + str ( Item ) + ' : ' + str ( Object . __dict__ [ Item ] ) )
            PrintObject ( Object . __dict__ [ Item ] ,  Level + 1 )

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

class Function ( ) :
    def __init__ ( self , Name ) :
        self . Name = Name
        self . Parameters = [ ]
        self . ReturnValues = [ ]

class Symbol ( ) :
    def __init__ ( self , Name , Type ) :
        self . Name = Name
        self . Type = Type
        self . Offset = 0 # from rbp

class Type ( ) :
    
    def __init__ ( self , Name ) :
        self . Name = Name
        self . InnerTypes = { }
        self . Size = 0

class CompilerIssue :
    
    FAIL_COLOR_TEXT = '\033[91m'
    END_COLOR_TEXT = '\033[0m'
    
    ERROR_START_TEXT = 'ERROR: '
    
    @staticmethod
    def OutputError ( ErrorText , Exit ) :
        print ( CompilerIssue . FAIL_COLOR_TEXT + CompilerIssue . ERROR_START_TEXT\
         + ErrorText + CompilerIssue . END_COLOR_TEXT )
        if Exit == True :
            exit ( )

class Parser ( ) :
    
    MAIN_STATES = {
        'START_OF_LINE' : 0 ,
        'USING_WAITING_FOR_WORD' : 2 ,
        'USING_AFTER_WORD' : 3 ,
        'CLASS_AFTER' : 4 ,
        'CLASS_AFTER_NAME' : 5 ,
        'CLASS_DECLARING_SIZE' : 6 ,
        'ACTION_AFTER' : 7 ,
        'ACTION_AFTER_ON' : 8 ,
        'ACTION_AFTER_RIGHT_PAREN' : 9 ,
        'ACTION_AFTER_NAME' : 10 ,
        'ACTION_NEW_PARAMETER' : 11 ,
        'ACTION_PARAM_NAME' : 12 ,
        'ACTION_AFTER_PARAM' : 13 ,
        'DECLARING_VARIABLE' : 14 ,
        'AFTER_DECLARING_VARIABLE' : 15
    }
    
    KEYWORDS = {
        'USING' : 'using' ,
        'CLASS' : 'class' ,
        'SIZE' : 'size' ,
        'ACTION' : 'action' ,
        'ASM' : 'asm' ,
        'ON' : 'on' ,
        'NORMAL' : 'normal' ,
        'CREATE' : 'create' ,
        'END' : 'end'
        
    }
    
    SPECIAL_CHARS = {
        'NEWLINE' : '\n' ,
        'PERIOD' : '.' ,
        'FORWARD_SLASH' : '/' ,
        'RIGHT_PAREN' : ')' ,
        'LEFT_PAREN' : '(' ,
        'COMMA' : ','
    }
    
    FUNCTION_TYPES = {
        'ASM' : 0 ,
        'NORMAL' : 1
    }
    
    MAIN_METHOD_NAMES = {
        'ON_CREATE' : 'On_Create'
    }
    
    EXIT_ON_ERROR = True
    
    PROGRAM_EXTENSION = 'q'
    
    EMPTY_STRING = ''
    
    EMPTY_ARRAY = [ ]
    
    ACTION_DECLARATION_OFFSET = -16
    ACTION_DEFINITION_OFFSET = 0
    
    def __init__ ( self ) :
        self . State = deepcopy ( self . MAIN_STATES [ 'START_OF_LINE' ] )
        self . SavedLine = ''
        self . TypeTable = { }
        self . STStack = [ ]
        self . CurrentClass = ''
        self . CurrentFunction = ''
        self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
        self . SavedType = ''
        self . CurrentSTOffset = 0
    
    def Parse ( self , SavedWordArray ) :
        WordIndex = 0
        while WordIndex < len ( SavedWordArray ) :
            Token = SavedWordArray [ WordIndex ]
            SavedWordArray = self . ParseToken ( Token , SavedWordArray , WordIndex )
            WordIndex = WordIndex + 1
        PrintObject ( self . TypeTable )
        return '' , SavedWordArray
    
    def ParseToken ( self , Token , SavedWordArray , WordIndex ) :
        print ( 'Parsing ' , Token , self . State , self . CurrentClass , self . CurrentFunction , len ( self . STStack ) , self . CurrentFunctionType )
        if self . State == self . MAIN_STATES [ 'START_OF_LINE' ] :
            if self . CurrentFunction != '' and self . CurrentFunctionType == self . FUNCTION_TYPES [ 'ASM' ] :
                print ( 'will print out tokens to output program' )
            if Token == self . KEYWORDS [ 'USING' ] :
                self . State = self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ]
            elif Token == self . KEYWORDS [ 'CLASS' ] :
                print ( 'ope' )
                self . State = self . MAIN_STATES [ 'CLASS_AFTER' ]
                self . STStack . append ( { } )
            elif Token == self . KEYWORDS [ 'ACTION' ] :
                self . State = self . MAIN_STATES [ 'ACTION_AFTER' ]
                self.  CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
                self . CurrentSTOffset = deepcopy ( self . ACTION_DECLARATION_OFFSET )
                self . ActionTypeDeclared = False
                self . STStack . append ( { } )
            elif Token == self . KEYWORDS [ 'END' ] :
                if len ( self . STStack ) == 0 :
                    CompilerIssue . OutputError ( '\'end\' found when not in any upper scope' , self . EXIT_ON_ERROR )
                elif self . CurrentFunction != '' :
                    print ( 'exiting function ' , self . CurrentFunction )
                    self . CurrentFunction = ''
                    self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
                elif self . CurrentClass != '' :
                    print ( 'exiting class ' , self . CurrentClass )
                    self . CurrentClass = ''
                self . STStack . pop ( len ( self . STStack ) - 1 )
            elif self . IsValidName ( Token ) == True :
                if self . CurrentFunctionType == self . FUNCTION_TYPES [ 'NORMAL' ] :
                    if Token in self . TypeTable :
                        self . SavedType = Token
                        self . State = self . MAIN_STATES [ 'DECLARING_VARIABLE' ]
                    else :
                        CompilerIssue . OutputError ( 'Type \'' + Token + '\' not found' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'DECLARING_VARIABLE' ] :
            if self . CurrentFunctionType == self . FUNCTION_TYPES [ 'NORMAL' ] :
                if self . SavedType in self . TypeTable :
                    if Token not in self . GetCurrentST ( ) :
                        NewSymbol = Symbol ( Token , self . SavedType )
                        self . CurrentSTOffset = self . CurrentSTOffset - self . TypeTable [ self . SavedType ] . Size
                        NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                        self . GetCurrentST ( ) [ Token ] = NewSymbol
                        self . State = self . MAIN_STATES [ 'AFTER_DECLARING_VARIABLE' ]
                    else :
                        CompilerIssue . OutputError ( 'A variable named ' + Token + ' has already been declared' , self . EXIT_ON_ERROR )
                else :
                    CompilerIssue . OutputError ( 'The type \'' + self . SavedType + '\' is not currently a declared type ' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'AFTER_DECLARING_VARIABLE' ] :
            if Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected newline encountered \'' + Token + '\'' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ] :
            if Token . isalnum ( ) == False :
                CompilerIssue . OutputError ( Token + ' is not alphanumeric' , self . EXIT_ON_ERROR )
            else :
                self . SavedLine = self . SavedLine + Token
                self . State = self . MAIN_STATES [ 'USING_AFTER_WORD' ]
        elif self . State == self . MAIN_STATES [ 'USING_AFTER_WORD' ] :
            if Token == self . SPECIAL_CHARS [ 'PERIOD' ] :
                self . SavedLine = self . SavedLine + Token
                self . State = self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ]
            elif Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                Path = self . ConvertToPath ( self . SavedLine )
                Path = Path + self . SPECIAL_CHARS [ 'PERIOD' ] + self . PROGRAM_EXTENSION
                Text = self . ReadFile ( Path )
                MyLexer = Lexer ( )
                NewTokens = MyLexer . MakeTokens ( Text )
                FirstWordArray = SavedWordArray [ 0 : WordIndex + 1 : ]
                SecondWordArray = SavedWordArray [ WordIndex : len ( SavedWordArray ) : ]
                SavedWordArray = FirstWordArray + NewTokens + SecondWordArray
                self . SavedLine = ''
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( Token + ' is not a period or newline' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER' ] :
            if self . IsValidName ( Token ) == False :
                CompilerIssue . OutputError ( Token + ' is in the wrong format for a class name' , self . EXIT_ON_ERROR )
            else :
                self . TypeTable [ Token ] = Type ( Token )
                self . CurrentClass = Token
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_NAME' ]
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_NAME' ] :
            if Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            elif Token == self . KEYWORDS [ 'SIZE' ] :
                self . State = self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'size\' or newline.' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ] :
            if Token . isdigit ( ) == True :
                self . TypeTable [ self . CurrentClass ] . Size = int ( Token )
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'size\' or newline.' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER' ] :
            if Token == self . KEYWORDS [ 'ASM' ] :
                if self . ActionTypeDeclared == True :
                    CompilerIssue . OutputError ( '\'' + self . KEYWORDS [ 'ASM' ] + '\' declared twice on function' , self . EXIT_ON_ERROR )
                else :
                    self . CurrentFunctionType = self . FUNCTION_TYPES [ 'ASM' ]
                    self . ActionTypeDeclared = True
            elif Token == self . KEYWORDS [ 'NORMAL' ] :
                if self . ActionTypeDeclared == True :
                    CompilerIssue . OutputError ( '\'' + self . KEYWORDS [ 'NORMAL' ] + '\' declared twice on function' , self . EXIT_ON_ERROR )
                else :
                    self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
                    self . ActionTypeDeclared = True
            elif self . IsValidName ( Token ) == True :
                if self . CurrentClass != '' :
                    if self . FunctionInTypes ( self . TypeTable [ self . CurrentClass ] . InnerTypes , Token ) :
                        CompilerIssue . OutputError ( self . CurrentClass + ' already has a symbol named ' + Token , self . EXIT_ON_ERROR )
                    else :
                        if Token == self . KEYWORDS [ 'ON' ] :
                            self . State = self . MAIN_STATES [ 'ACTION_AFTER_ON' ]
                        else :
                            self . CurrentTypeTable ( ) [ Token ] = Function ( self . CurrentFunction )
                            self . CurrentFunction = Token
                            self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
                else :
                    self . TypeTable [ Token ] = Function ( Token )
                    self . CurrentFunction = Token
                    self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
            else :
                CompilerIssue . OutputError ( Token + ' is in the wrong format for a method name' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_ON' ] :
            if Token == self . KEYWORDS [ 'CREATE' ] :
                self . CurrentFunction = self . MAIN_METHOD_NAMES [ 'ON_CREATE' ]
                self . TypeTable [ self . CurrentClass ] . InnerTypes [ self . CurrentFunction ] = Function ( self . CurrentFunction )
                self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
            else :
                CompilerIssue . OutputError ( 'Expected main method name' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_NAME' ] :
            if Token == self . SPECIAL_CHARS [ 'LEFT_PAREN' ] :
                self . State = self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ]
            elif Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected left paren or newline in action declaration' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ] :
            if self . IsValidName ( Token ) :
                if Token in self . TypeTable :
                    self . SavedType = Token
                    self . State = self . MAIN_STATES [ 'ACTION_PARAM_NAME' ]
                else :
                    CompilerIssue . OutputError ( 'Unknown type \'' + Token + '\'' , self . EXIT_ON_ERROR )
            else :
                CompilerIssue . OutputError ( 'Expected variable or right paren in action declaration' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'ACTION_PARAM_NAME' ] :
            if self . IsValidName ( Token ) :
                if Token in self . CurrentTypeTable ( ) :
                    CompilerIssue . OutputError ( 'There is already a \'' + Token + '\' in the current scope' , self . EXIT_ON_ERROR )
                else :
                    NewSymbol = Symbol ( Token , self . SavedType )
                    print ( self . TypeTable [ self . SavedType ] . Size , self . CurrentSTOffset , 'asfdasfd' )
                    self . CurrentSTOffset = self . CurrentSTOffset - self . TypeTable [ self . SavedType ] . Size
                    NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                    print ( 'self . CurrentSTOffset = ' + str ( self . CurrentSTOffset ) )
                    self . CurrentTypeTable ( ) . append ( NewSymbol )
                    self . GetCurrentST ( ) [ Token ] = NewSymbol
                    self . State = self . MAIN_STATES [ 'ACTION_AFTER_PARAM' ]
            else :
                CompilerIssue . OutputError ( 'Invalid variable name in action declaration' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_PARAM' ] :
            if Token == self . SPECIAL_CHARS [ 'COMMA' ] :
                self . State = self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ]
            elif Token == self . SPECIAL_CHARS [ 'RIGHT_PAREN' ] :
                self . CurrentSTOffset = deepcopy ( self . ACTION_DEFINITION_OFFSET )
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
                
        return SavedWordArray
    
    def GetCurrentST ( self ) :
        return self . STStack [ len ( self . STStack ) - 1 ]
        
    def CurrentTypeTable ( self ) :
        OutTable = self . TypeTable
        if self . CurrentClass != '' :
            OutTable = self . TypeTable [ self . CurrentClass ] . InnerTypes
        if self . CurrentFunction != '' :
            OutTable = OutTable [ self . CurrentFunction ] . Parameters
        return OutTable
    
    def FunctionInTypes ( self , Table , FuncName ) :
        Output = False
        for Type in Table :
            if Table [ Type ] . Name == FuncName :
                Output = True
        return Output
    
    
    def IsValidName ( self , Token ) :
        Output = True
        if Token [ 0 ] . isalpha ( ) == False or Token . isalnum ( ) == False :
            Output = False
        return Output
    
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
    SAVED_WORD_ARRAY_DEFAULT = deepcopy ( EMPTY_ARRAY )
    
    NEGATIVE_ONE = -1

    FIND_NOT_FOUND = NEGATIVE_ONE
    
    def __init__ ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT
        self . SavedWordArray = deepcopy ( self . SAVED_WORD_ARRAY_DEFAULT )
    
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
