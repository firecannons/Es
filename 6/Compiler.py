import sys
import pprint
from copy import deepcopy

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


class UsingPathList ( ) :
    
    PATH_CHARACTER = '/'
    EXTENSION = '.q'
    
    def __init__ ( self ) :
        self . WordList = [ ]
        self . ClearWordList ( )
    
    def AddWord ( self , Word ) :
        self . WordList . append ( Word )
    
    def ClearWordList ( self ) :
        self . WordList = [ ]
    
    def CalcPath ( self ) :
        Path = ''
        WordListLength = len ( self . WordList )
        for WordIndex in range ( WordListLength ) :
            Path = Path + self . WordList [ WordIndex ]
            if WordIndex < WordListLength - 1 :
                Path = Path + self . PATH_CHARACTER
            else :
                Path = Path + self . EXTENSION
        return Path


class ClassMethod ( ) :
    def __init__ ( self ) :
        Name = ''
        ReturnType = ''
        Parameters = [ ]
    
    def AddParameter ( self , NewParameter ) :
        Parameters . append ( NewParameter )


class ClassMember ( ) :
    def __init__ ( self ) :
        Name = ''
        Type = ''
    
    def SetNameAndType ( self , InName , InType ) :
        Name = InName
        Type = InType

class ClassInParser ( ) :
    
    def __init__ ( self ) :
        Members = [ ]
        Methods = [ ]
        TotalSize = 0
        Name = ''
    
    def AddMember ( self , Name , Type ) :
        NewMember = Member ( )
        NewMember . SetNameAndType ( Name , Type )
        Members . append ( NewMember )
    
    def AddMethod ( self , Name , ReturnType , Members ) :
        NewMember = Member ( )
        NewMember . SetNameAndType ( Name , Type )
        Members . append ( NewMember )
        
        


# A Parser is supposed to turn an array of tokens into something like an abstract syntax tree (AST)
class Parser ( ) :
    
    ACTION_INPUT_TEXT = "Action"
    ACTION_OUTPUT_TEXT = ""
    ACTION_ADD_TEXT = ":\n"
    ACTION_DECLARE_IGNORE_CHARACTERS = "(,"
    
    USING_INPUT_TEXT = "Using"
    
    CLASS_TEXT = 'class'
    
    END_TEXT = 'end'
    
    ACTION_CLOSING_TEXT = ")"
    
    LEFT_PAREN = '('
    
    PARSER_STATES = {
    'NONE' : 0 ,
    'BEFORE_ACTION_NAME' : 1 ,
    'DECLARING_ACTION_TYPE' : 2 ,
    'DECLARING_ACTION_VARIABLE' : 3 ,
    'DEFINING_ACTION' : 4,
    'USING_WAITING_FOR_WORD' : 5,
    'USING_WAITING_FOR_PERIOD' : 6 ,
    'CLASS_WAITING_FOR_NAME' : 7 ,
    'UNKNOWN' : 8
    }
    
    PERIOD = '.'
    
    def __init__ ( self ) :
        self . State = self . PARSER_STATES [ 'NONE' ]
        self . UsingPathList = UsingPathList ( )
        self . ClassArray = [ ]
        self . SavedClass = None
        self . IsClassSaved = False
        SavedUnknownWord = ''
        self . IsFunctionSaved = False
        self . SavedFunction = None
    
    def CheckEquals ( self , Word1 , Word2 ) :
        Output = False
        LowercaseWord1 = Word1 . lower ( )
        LowercaseWord2 = Word2 . lower ( )
        if LowercaseWord1 == LowercaseWord2 :
            Output = True
        return Output
    
    def CheckIn ( self , Needle , HayStack ) :
        Output = False
        if Needle in HayStack :
            Output = True
        return Output
        
    def CheckForActionWord ( self , InWord ) :
        Output = self . CheckEquals ( self . ACTION_INPUT_TEXT , InWord )
        return Output
    
    def CheckForUsingWord ( self , InWord ) :
        Output = self . CheckEquals ( self . USING_INPUT_TEXT , InWord )
        return Output
    
    def CheckForActionClosingText ( self , InWord ) :
        Output = self . CheckEquals ( self . ACTION_CLOSING_TEXT , InWord )
        return Output
    
    def CheckForActionDeclareIgnoreCharacter ( self , InWord ) :
        Output = False
        Output = self . CheckIn ( InWord , self . ACTION_DECLARE_IGNORE_CHARACTERS )
        return Output
    
    def ActionDeclareUsefulCharacter ( self , InWord , IsDeclaringType ) :
        OutWord = ""
        ## Unfinished
        IsDeclaringType = ~IsDeclaringType
        return OutWord , IsDeclaringType
    
    def DoActionWordCheck ( self , InWord , OutWord ) :
        if self . State == self . PARSER_STATES [ "NONE" ] :
            IsAction = self . CheckForActionWord ( InWord )
            if IsAction == True :
                OutWord = self . ACTION_OUTPUT_TEXT
                self . State = self . PARSER_STATES [ "BEFORE_ACTION_NAME" ]
        return OutWord
    
    def DoUsingWordCheck ( self , InWord , OutWord ) :
        if self . State == self . PARSER_STATES [ "NONE" ] :
            print ( "ok good" )
            IsUsing = self . CheckForUsingWord ( InWord )
            if IsUsing == True :
                OutWord = ''
                self . UsingPathList . ClearWordList ( )
                self . State = self . PARSER_STATES [ "USING_WAITING_FOR_WORD" ]
                print ( "score for using! " + self . UsingPathList . CalcPath ( ) )
        return OutWord
    
    def CheckForClassWord ( self , InWord ) :
        Output = self . CheckEquals ( self . CLASS_TEXT , InWord )
        return Output
	
    def DoClassWordCheck ( self , InWord , OutWord ) :
        if self . State == self . PARSER_STATES [ "NONE" ] :
            IsClass = self . CheckForClassWord ( InWord )
            if IsClass == True :
                self . State = self . PARSER_STATES [ "CLASS_WAITING_FOR_NAME" ]
                self . SavedClass = ClassInParser ( )
                self . IsClassSaved = True
        return OutWord
    
    def CheckForEndWord ( self , InWord ) :
        Output = Output = self . CheckEquals ( self . END_TEXT , InWord )
        return Output
    
    def DoEndWordCheck ( self , InWord , OutWord ) :
        if self . State == self . PARSER_STATES [ "NONE" ] :
            IsEnd = self . CheckForEndWord ( InWord )
            if IsClass == True :
                self . State = self . PARSER_STATES [ "NONE" ]
                self . ClassArray . append ( SavedClass )
                self . SavedClass = None
                self . IsClassSaved = False
        return OutWord
    
    def CheckIfDoneWithPath ( self , InWord ) :
        Output = False
        if InWord != self . PERIOD :
            Output = True
        return Output
    
    def DoUnknownCheck ( self , InWord , OutWord ) :
        if self . State == self . PARSER_STATES [ "NONE" ] :
            self . SavedUnknownWord = InWord
            self . State = self . PARSER_STATES [ "UNKNOWN" ]
        return OutWord
	
    def CheckIfLeftParen ( self , InWord )
        Output = False
        if InWord == self . RIGHT_PAREN :
            Output = True
        return Output
        
        
    def CalcWord ( self , InWord ) :
        OutWord = ""
        if self . State == self . PARSER_STATES [ "NONE" ] :
            OutWord = self . DoActionWordCheck ( InWord , OutWord )
            OutWord = self . DoUsingWordCheck ( InWord , OutWord )
            OutWord = self . DoClassWordCheck ( InWord , OutWord )
            OutWord = self . DoEndWordCheck ( InWord , OutWord )
            OutWord = self . DoUnknownCheck ( InWord , OutWord )
        elif self . State == self . PARSER_STATES [ "BEFORE_ACTION_NAME" ] :
            OutWord = InWord + self . ACTION_ADD_TEXT
            self . State = self . PARSER_STATES [ 'ACTION_LEFT_PAREN' ]
        elif self . State = self . PARSER_STATES [ 'ACTION_LEFT_PAREN' ] :
            self . State = self . PARSER_STATES [ 'DECLARING_ACTION_TYPE' ]
        elif self . State == self . PARSER_STATES [ 'DECLARING_ACTION_TYPE' ] :
            self . SavedType = InWord
            
            IsActionClosingText = self . CheckForActionClosingText ( InWord )
            if IsActionClosingText == True :
                self . State = self . PARSER_STATES [ 'DEFINING_ACTION' ]
            elif self . State == self . PARSER_STATES [ 'DECLARING_ACTION_TYPE' ] :
                IsActionDeclareIgnoreCharacter = self . CheckForActionDeclareIgnoreCharacter ( InWord )
        elif self . State == self . PARSER_STATES [ "USING_WAITING_FOR_WORD" ] :
            print ( "ok1" )
            self . UsingPathList . AddWord ( InWord )
            self . State = self . PARSER_STATES [ 'USING_WAITING_FOR_PERIOD' ]
        elif self . State == self . PARSER_STATES [ 'USING_WAITING_FOR_PERIOD' ] :
            print ( "ok... " + InWord )
            IsDoneWithPath = self . CheckIfDoneWithPath ( InWord )
            if IsDoneWithPath == True :
                Path = self . UsingPathList . CalcPath ( )
                print ( "yessss " + Path )
                TheCompiler = Compiler ( )
                InputText = TheCompiler . ReadInputFile ( Path )
                print ( InputText + " = InputText" )
                TheLexer = Lexer ( )
                SavedWordArray = TheLexer . MakeTokens ( InputText )
                print ( str(SavedWordArray) + " = SavedWordArray" )
                print ( "before" )
                for i in SavedWordArray :
                    print ( i + " f" )
                print ( "new one" )
                NewParser = Parser ( )
                AddedCode = NewParser . GenerateCode ( SavedWordArray )
                OutWord = AddedCode
                self . State = self . PARSER_STATES [ 'NONE' ]
                print ( "exiting recursion" )
            else :
                self . State = self . PARSER_STATES [ 'USING_WAITING_FOR_WORD' ]
        elif self . State == self . PARSER_STATES [ "CLASS_WAITING_FOR_NAME" ] :
            SavedClass . Name = InWord
        elif self . State == self . PARSER_STATES [ "UNKNOWN" ] :
            IsLeftParen = CheckIfLeftParen ( InWord )
            if IsLeftParen == True :
                if self . IsClassSaved == True :
                    
            
        return OutWord
    
    def GenerateCode ( self , WordArray ) :
        OutputCode = ""
        for Word in WordArray :
            OutputWord = self . CalcWord ( Word )
            OutputCode = OutputCode + OutputWord
        OutputWord = self . CalcWord ( '' )
        return OutputCode
            
        
        

class Lexer ( ) :
    WHITE_SPACE_LETTERS = " \t\n\r"
    MEANINGFUL_LETTERS = '()[]<>,.'
    
    EMPTY_ARRAY = [ ]
    
    SAVED_WORD_DEFAULT = ''
    SAVED_WORD_ARRAY_DEFAULT = EMPTY_ARRAY
    
    NEGATIVE_ONE = -1

    FIND_NOT_FOUND = NEGATIVE_ONE
    
    def __init__ ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT
        # Note that deepcopy must be used
        self . SavedWordArray = deepcopy ( self . EMPTY_ARRAY )
        print ( "LEXER: __init__() SavedWordArray = " + str ( self . SavedWordArray ) + " SAVED_WORD_ARRAY_DEFAULT = " + str ( self . SAVED_WORD_ARRAY_DEFAULT ) )
    
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
    
    def DoEndingProcessing ( self ) :
        if self . IsSavedWordExisting ( ) == True :
            self . AppendToSavedWordArray ( self . SavedWord )
    
    def MakeTokens ( self , InputText ) :
        print ( "LEXER: MakeTokens() START SavedWordArray = " + str ( self . SavedWordArray ) + " SAVED_WORD_ARRAY_DEFAULT = " + str ( self . SAVED_WORD_ARRAY_DEFAULT ) )
        Position = 0
        InputTextLength = len ( InputText )
        while ( Position < InputTextLength ) :
            CurrentLetter = InputText [ Position ]
            self . ProcessLetterInSetup ( CurrentLetter )
            Position = Position + 1
        self . DoEndingProcessing ( )
        print ( "LEXER: MakeTokens() END SavedWordArray = " + str ( self . SavedWordArray ) + " SAVED_WORD_ARRAY_DEFAULT = " + str ( self . SAVED_WORD_ARRAY_DEFAULT ) )
        return self . SavedWordArray

class Compiler ( ) :
    BEGINNING_TEXT = '''format ELF64 executable 3
segment readable executable
entry ProgramStart
'''
    
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
        OutputText = OutputText + self . CalcProgramTranslation ( InputText )
        return OutputText
    
    def CalcProgramTranslation ( self , InputText ) :
        MyLexer = Lexer ( )
        SavedWordArray = MyLexer . MakeTokens ( InputText )
        for i in SavedWordArray :
            print ( i )
        MyParser = Parser ( )
        OutputCode = MyParser . GenerateCode ( SavedWordArray )
        return OutputCode
    
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
