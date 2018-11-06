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

class MySymbol ( ) :
    def __init__ ( self , Name , Type ) :
        self . Name = Name
        self . Type = Type
        self . Offset = 0
        self . IsFunction = False
        self . Templates = { }

class Function ( ) :
    def __init__ ( self , Name ) :
        self . Name = Name
        self . Parameters = [ ]
        self . ReturnValues = [ ]
        self . IsFunction = True
        self . Templates = { }

class Type ( ) :
    
    def __init__ ( self , Name ) :
        self . Name = Name
        self . InnerTypes = { }
        self . Size = 0
        self . IsFunction = False
        self . Templates = { }

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
        'ACTION_AFTER_OPERATOR' : 18 ,
        'ACTION_AFTER_RIGHT_PAREN' : 9 ,
        'ACTION_AFTER_NAME' : 10 ,
        'ACTION_NEW_PARAMETER' : 11 ,
        'ACTION_PARAM_NAME' : 12 ,
        'ACTION_AFTER_PARAM' : 13 ,
        'DECLARING_VARIABLE' : 14 ,
        'AFTER_DECLARING_VARIABLE' : 15 ,
        'WAITING_FOR_COLON' : 16 ,
        'WAITING_FOR_OPERATOR' : 17 ,
        'CLASS_MAKING_TEMPLATE' : 18 ,
        'CLASS_AFTER_TEMPLATE_NAME' : 19 ,
        'CLASS_AFTER_TEMPLATES' : 20 ,
        'CLASS_AFTER_DECLARING_SIZE' : 21 ,
        'MAKING_TEMPLATE' : 22 ,
        'AFTER_TEMPLATE_NAME' : 23 ,
        'AFTER_TEMPLATE' : 24
        
    }
    
    KEYWORDS = {
        'USING' : 'using' ,
        'CLASS' : 'class' ,
        'SIZE' : 'size' ,
        'ACTION' : 'action' ,
        'ASM' : 'asm' ,
        'ON' : 'on' ,
        'OPERATOR' : 'operator' ,
        'NORMAL' : 'normal' ,
        'CREATE' : 'create' ,
        'END' : 'end' ,
        'EQUALS_SIGN' : '='
        
    }
    
    SPECIAL_CHARS = {
        'NEWLINE' : '\n' ,
        'PERIOD' : '.' ,
        'FORWARD_SLASH' : '/' ,
        'RIGHT_PAREN' : ')' ,
        'LEFT_PAREN' : '(' ,
        'COMMA' : ',' ,
        'EQUALS_SIGN' : '=' ,
        'COLON' : ':' ,
        'TEMPLATE_START' : '<' ,
        'TEMPLATE_END' : '>'
    }
    
    FUNCTION_TYPES = {
        'ASM' : 0 ,
        'NORMAL' : 1
    }
    
    MAIN_METHOD_NAMES = {
        'ON_CREATE' : 'On_Create' ,
        'EQUALS_SIGN' : '='
    }
    
    OPERATORS = {
        'COLON' : ':' ,
        'LEFT_PAREN' : '(' ,
        'PLUS' : '+' ,
        'MINUS' : '-' ,
        'MULT' : '*' ,
        'DIVIDE' : '/' ,
        'IS_EQUAL' : '==' ,
        'NOT_EQUAL' : '!-' ,
        'LESS_OR_EQUAL' : '<=' ,
        'GREATER_OR_EQUAL' : '>=' ,
        'GREATER_THAN' : '>' ,
        'LESS_THAN' : '<' ,
        'EQUALS' : '=' ,
        'RIGHT_PAREN' : ')' ,
    }
    
    OPERATOR_PRECEDENCE = [
        { OPERATORS [ 'COLON' ] , OPERATORS [ 'LEFT_PAREN' ] } ,
        { OPERATORS [ 'PLUS' ] , OPERATORS [ 'MINUS' ] , OPERATORS [ 'MULT' ] , OPERATORS [ 'DIVIDE' ] } ,
        { OPERATORS [ 'IS_EQUAL' ] , OPERATORS [ 'NOT_EQUAL' ] , OPERATORS [ 'LESS_OR_EQUAL' ] , OPERATORS [ 'GREATER_OR_EQUAL' ] } ,
        { OPERATORS [ 'EQUALS' ] } ,
        { OPERATORS [ 'RIGHT_PAREN' ] }
    ]
    
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
        self . STStack = [ { } ]
        self . CurrentClass = ''
        self . CurrentFunction = ''
        self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
        self . SavedType = ''
        self . CurrentSTOffset = 0
        self . SavedLeftOperand = ''
        self . TemplateItemNumber = 0
    
    def Parse ( self , SavedWordArray , OutputText ) :
        WordIndex = 0
        while WordIndex < len ( SavedWordArray ) :
            Token = SavedWordArray [ WordIndex ]
            SavedWordArray , WordIndex , OutputText = self . ParseToken ( Token , SavedWordArray , WordIndex , OutputText )
            WordIndex = WordIndex + 1
        PrintObject ( self . TypeTable )
        return OutputText , SavedWordArray
    
    def GetOperatorDepth ( self , Operator ) :
        Depth = -1
        DepthIndex = 0
        while DepthIndex < len ( self . OPERATOR_PRECEDENCE ) and Depth == -1 :
            if Operator in self . OPERATOR_PRECEDENCE [ DepthIndex ] :
                Depth = DepthIndex
            DepthIndex = DepthIndex + 1
        if Depth == -1 :
            CompilerIssue . OutputError ( 'Operator \'' + Operator + '\' is not an allowed operator' , self . EXIT_ON_ERROR )
        return Depth
    
    def OpOneHighestPrecedence ( self , Op1 , Op2 ) :
        Output = True
        Depth1 = self . GetOperatorDepth ( Op1 )
        Depth2 = self . GetOperatorDepth ( Op2 )
        if Depth2 < Depth1 :
            Output = False
        return Output
    
    def DoOperation ( self , Index , WordArray , CurrentClass ) :
        if WordArray [ Index + 1 ] == self . OPERATORS [ 'COLON' ] :
            IsFunction = False
            IsSymbol = False
            IsSymbol , CurrentObject = self . CheckCurrentSTs ( WordArray [ Index ] )
            CurrentClass = CurrentObject . Type
            if WordArray [ Index ] in self . CurrentTypeTable ( ) :
                IsFunction = True
            if IsSymbol == True or IsFunction == True :
                if WordArray [ Index + 2 ] in self . TypeTable [ CurrentClass ] . InnerTypes :
                    NewType = self . TypeTable [ CurrentClass ] . InnerTypes [ WordArray [ Index + 2 ] ] . Type
                    CurrentClass = self . TypeTable [ NewType ]
                    WordArray . pop ( Index )
                    WordArray . pop ( Index )
                else :
                    CompilerIssue . OutputError ( 'Class \'' + CurrentClass + '\' has no variable \'' + WordArray [ Index + 2 ] + '\'.' , self . EXIT_ON_ERROR )
            elif IsFound == False :
                CompilerIssue . OutputError ( 'Unknown ' + Operator + ' is not an allowed operator' , self . EXIT_ON_ERROR )
        elif WordArray [ Index + 1 ] == self . OPERATORS [ 'EQUALS' ] :
            WordArray . pop ( Index + 1 )
            WordArray . pop ( Index + 1 )
        return CurrentClass
        
    
    def Reduce ( self , Token , SavedWordArray ) :
        WordIndex = 0
        CurrentClass = ''
        FunctionStack = [ ]
        while len ( SavedWordArray ) > 2 :
            print ( SavedWordArray )
            Token1 = SavedWordArray [ WordIndex ]
            Token2 = SavedWordArray [ WordIndex + 1 ]
            Token3 = SavedWordArray [ WordIndex + 2 ]
            if len ( SavedWordArray ) > 4 :
                Token4 = SavedWordArray [ WordIndex + 3 ]
                Token5 = SavedWordArray [ WordIndex + 4 ]
                if self . OpOneHighestPrecedence ( Token2 , Token4 ) :
                    self . DoOperation ( WordIndex , SavedWordArray , CurrentClass )
                else :
                    self . DoOperation ( WordIndex + 2 , SavedWordArray , CurrentClass )
            else :
                self . DoOperation ( WordIndex , SavedWordArray , CurrentClass )
            print ( 'Reducing ' , SavedWordArray )
        '''
        WordIndex = 0
        ExprCurrentClass = ''
        ExprCurrentFunction = ''
        while WordIndex < len ( SavedWordArray ) :
            Token = SavedWordArray [ WordIndex ]
            if self . CheckCurrentSTs ( Token ) == True :
            elif self . GetTypeTable ( Expr
            else :
                CompilerIssue . OutputError ( '\'end\' found when not in any upper scope' , self . EXIT_ON_ERROR )'''
        
    
    def ParseToken ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        #print ( 'Parsing ' , Token , self . State , self . CurrentClass , self . CurrentFunction , len ( self . STStack ) , self . CurrentFunctionType )
        #print ( 'Parsing -> \'' + Token + '\'' , 'self . State = ' + str ( self . State ) , ' len ( self . STStack ) = ' + str ( len ( self . STStack ) ) )
        if self . State == self . MAIN_STATES [ 'START_OF_LINE' ] :
            if self . CurrentFunction != '' and self . CurrentFunctionType == self . FUNCTION_TYPES [ 'ASM' ] :
                print ( 'In Asm Function -> Will output ASM to output' )
            if Token == self . KEYWORDS [ 'USING' ] :
                self . State = self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ]
            elif Token == self . KEYWORDS [ 'CLASS' ] :
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
                    #print ( 'exiting function ' , self . CurrentFunction )
                    self . CurrentFunction = ''
                    self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
                elif self . CurrentClass != '' :
                    print ( 'exiting class ' , self . CurrentClass )
                    self . CurrentClass = ''
                self . STStack . pop ( len ( self . STStack ) - 1 )
            elif self . IsValidName ( Token ) == True :
                if self . CurrentFunctionType == self . FUNCTION_TYPES [ 'NORMAL' ] :
                    if Token in self . TypeTable :
                        if self . TypeTable [ Token ] . IsFunction == False :
                            self . SavedType = Token
                            self . State = self . MAIN_STATES [ 'DECLARING_VARIABLE' ]
                        else :
                            Found = self . CheckCurrentSTs ( Token )
                            LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                            #self . Reduce ( Token , LineWordArray )
                    elif self . CheckCurrentSTs ( Token ) :
                        Found = self . CheckCurrentSTs ( Token )
                        LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                        #self . Reduce ( Token , LineWordArray )
                    else :
                        CompilerIssue . OutputError ( 'Type \'' + Token + '\' not found' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'DECLARING_VARIABLE' ] :
            if self . CurrentFunctionType == self . FUNCTION_TYPES [ 'NORMAL' ] :
                if Token == self . SPECIAL_CHARS [ 'TEMPLATE_START' ] :
                    self . State = self . MAIN_STATES [ 'MAKING_TEMPLATE' ]
                elif self . SavedType in self . TypeTable :
                    if Token not in self . GetCurrentST ( ) :
                        NewSymbol = MySymbol ( Token , self . SavedType )
                        self . CurrentSTOffset = self . CurrentSTOffset - self . TypeTable [ self . SavedType ] . Size
                        self . TypeTable [ self . CurrentClass ] . Size = self . TypeTable [ self . CurrentClass ] . Size + self . TypeTable [ self . SavedType ] . Size
                        NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                        self . GetCurrentST ( ) [ Token ] = NewSymbol
                        self . TypeTable [ self . CurrentClass ] . InnerTypes [ Token ] = NewSymbol
                        self . State = self . MAIN_STATES [ 'AFTER_DECLARING_VARIABLE' ]
                    else :
                        CompilerIssue . OutputError ( 'A variable named ' + Token + ' has already been declared' , self . EXIT_ON_ERROR )
                else :
                    CompilerIssue . OutputError ( 'The type \'' + self . SavedType + '\' is not currently a declared type and is not template start ' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'AFTER_DECLARING_VARIABLE' ] :
            if Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected newline encountered \'' + Token + '\'' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'MAKING_TEMPLATE' ] :
            if self . IsValidName ( Token ) == True :
                if Token in self . TypeTable :
                    if self . TypeTable [ Token ] . IsFunction == False :
                        self . State = self . MAIN_STATES [ 'AFTER_TEMPLATE_NAME' ]
                    else :
                       CompilerIssue . OutputError ( 'Template type \'' + Token + '\' was found to be a function not class', self . EXIT_ON_ERROR ) 
                else :
                    CompilerIssue . OutputError ( 'Template type \'' + Token + '\' not found in type table', self . EXIT_ON_ERROR )
            else :
                CompilerIssue . OutputError ( 'Expected valid type for template instead of \'' + Token + '\'', self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'AFTER_TEMPLATE_NAME' ] :
            if Token == self . SPECIAL_CHARS [ 'COMMA' ] :
                self . State = self . MAIN_STATES [ 'MAKING_TEMPLATE' ]
            elif Token == self . SPECIAL_CHARS [ 'TEMPLATE_END' ] :
                self . State = self . MAIN_STATES [ 'DECLARING_VARIABLE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . SPECIAL_CHARS [ 'COMMA' ] + '\' or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_END' ] + '\' instead of \'' + Token + '\'' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ] :
            if Token . isalnum ( ) == False :
                CompilerIssue . OutputError ( '\'' + Token + '\' is not alphanumeric' , self . EXIT_ON_ERROR )
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
            elif Token == self . SPECIAL_CHARS [ 'TEMPLATE_START' ] :
                self . State = self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . KEYWORDS [ 'SIZE' ] + '\' or newline or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_START' ] + '\'' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ] :
            if self . IsValidName ( Token ) == False :
                CompilerIssue . OutputError ( Token + ' is in the wrong format for a template name' , self . EXIT_ON_ERROR )
            else :
                self . TypeTable [ self . CurrentClass ] . Templates [ Token ] = set ( )
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATE_NAME' ]
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATE_NAME' ] :
            if Token == self . SPECIAL_CHARS [ 'COMMA' ] :
                self . State = self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ]
            elif Token == self . SPECIAL_CHARS [ 'TEMPLATE_END' ] :
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATES' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . SPECIAL_CHARS [ 'COMMA' ] + '\' or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_END' ] + '\'.'  , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATES' ] :
            if Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            elif Token == self . KEYWORDS [ 'SIZE' ] :
                self . State = self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . KEYWORDS [ 'SIZE' ] + '\' or newline' , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ] :
            if Token . isdigit ( ) == True :
                self . TypeTable [ self . CurrentClass ] . Size = int ( Token )
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_DECLARING_SIZE' ]
            else :
                CompilerIssue . OutputError ( 'Expected number to go after' + self . KEYWORDS [ 'SIZE' ] , self . EXIT_ON_ERROR )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_DECLARING_SIZE' ] :
            if Token == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected newline after declaring class size' , self . EXIT_ON_ERROR )
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
            elif Token == self . KEYWORDS [ 'EQUALS_SIGN' ] :
                self . CurrentFunction = self . MAIN_METHOD_NAMES [ 'EQUALS_SIGN' ]
                self . TypeTable [ self . CurrentClass ] . InnerTypes [ self . CurrentFunction ] = Function ( self . CurrentFunction )
                self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
            else :
                CompilerIssue . OutputError ( 'Expected special action after \'' + self . KEYWORDS [ 'OPERATOR' ] + '\'' , self . EXIT_ON_ERROR )
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
                    NewSymbol = MySymbol ( Token , self . SavedType )
                    print ( self . TypeTable [ self . SavedType ] . Size , self . CurrentSTOffset , 'asfdasfd' )
                    self . CurrentSTOffset = self . CurrentSTOffset - self . TypeTable [ self . SavedType ] . Size
                    NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                    print ( 'self . CurrentSTOffset = ' + str ( self . CurrentSTOffset ) )
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
        elif self . State == self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ] :
            if Token == self . COLON :
                self . State = self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ]
            elif Token in self . ClassTypeTable ( self . SavedLeftOperand . Name ) :
                self . SavedOperator = Token
                self . State = self . MAIN_STATES [ 'WAITING_FOR_RIGHT_OPERATOR' ]
            else :
                CompilerIssue . OutputError ( 'Cound not find ' + Token + ' in ' + self . SavedLeftOperand . Name + ' which is of type '
                    + self . SavedLeftOperand . Type , self . EXIT_ON_ERROR )
                self . State = self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ]
            
                
        return SavedWordArray , WordIndex , OutputText
    
    def GetUntilNewline ( self , SavedWordArray , WordIndex ) :
        LineWordArray = [ ]
        TempWordIndex = WordIndex
        while SavedWordArray [ WordIndex ] != self . SPECIAL_CHARS [ 'NEWLINE' ] :
            LineWordArray . append ( SavedWordArray [ WordIndex ] )
            WordIndex = WordIndex + 1
        return LineWordArray , WordIndex
    
    def GetCurrentST ( self ) :
        return self . STStack [ len ( self . STStack ) - 1 ]
    
    def CheckCurrentSTs ( self , SymbolName ) :
        Found = False
        OutSymbol = None
        Index = 0
        StackHeight = len ( self . STStack ) - 1
        while Found == False and StackHeight - Index >= 0 :
            if SymbolName in self . STStack [ StackHeight - Index ] :
                Found = True
                OutSymbol = self . STStack [ StackHeight - Index ] [ SymbolName ]
            Index = Index + 1
        return Found , OutSymbol
        
    def CurrentTypeTable ( self ) :
        OutTable = self . TypeTable
        if self . CurrentClass != '' :
            OutTable = self . TypeTable [ self . CurrentClass ] . InnerTypes
        if self . CurrentFunction != '' :
            OutTable = OutTable [ self . CurrentFunction ] . Parameters
        return OutTable
    
    def GetTypeTable ( self , Class , Function ) :
        OutTable = self . TypeTable
        if Class != '' :
            OutTable = self . TypeTable [ Class ] . InnerTypes
        if Function != '' :
            OutTable = OutTable [ Function ] . Parameters
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
    MEANINGFUL_LETTERS = '()[]<>,.\\/'
    
    EMPTY_ARRAY = [ ]
    
    SAVED_WORD_DEFAULT = ''
    SAVED_WORD_ARRAY_DEFAULT = deepcopy ( EMPTY_ARRAY )
    
    NEGATIVE_ONE = -1
    
    MAIN_STATES = {
        'NORMAL' : 0 ,
        'AFTER_ACTION' : 1 ,
        'AFTER_ASM' : 2 ,
        'IN_ONE_LINE_COMMENT' : 3 ,
        'IN_MULTILINE_COMMENT' : 4 ,
        'IN_STRING_LITERAL' : 5 ,
        'ASM_ACTION_WAITING_FOR_LINE' : 6 ,
        'IN_ASM_FUNCTION' : 7
    }
    SINGLE_LINE_COMMENT_START = '//'
    MULTI_LINE_COMMENT_START = '/*'
    MULTI_LINE_COMMENT_END = '*/'
    QUOTATIONS = [ "'" , '"' ]
    NEWLINE = '\n'
    ESCAPE_CHAR = '\\'
    ASM_TEXT = 'asm'
    ACTION_TEXT = 'action'
    END_TEXT = 'end'
    
    
    FIND_NOT_FOUND = NEGATIVE_ONE
    
    def __init__ ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT
        self . SavedWordArray = deepcopy ( self . SAVED_WORD_ARRAY_DEFAULT )
        self . State = self . MAIN_STATES [ 'NORMAL' ]
        self . StartingQuotation = self . QUOTATIONS [ 0 ]
    
    def AppendWordToSavedArray ( self , Text ) :
        self . SavedWordArray . append ( Text ) 
        self . EraseSavedWord ( )
    
    def ProcessAppendWord ( self , Text ) :
        print ( 'Lexing \'' + Text + '\'' , 'self . State = ' + str ( self . State ) )
        if self . State == self . MAIN_STATES [ 'NORMAL' ] :
            if Text == self . SINGLE_LINE_COMMENT_START :
                self . State = self . MAIN_STATES [ 'IN_ONE_LINE_COMMENT' ]
            elif Text == self . MULTI_LINE_COMMENT_START :
                self . State = self . MAIN_STATES [ 'IN_MULTILINE_COMMENT' ]
            elif Text in self . QUOTATIONS :
                self . State = self . MAIN_STATES [ 'IN_STRING_LITERAL' ]
                self . StartingQuotation = Text
                self . AppendWordToSavedArray ( Text )
            elif Text == self . ASM_TEXT :
                if self . SavedWordArray [ len ( self . SavedWordArray ) - 1 ] == self . ACTION_TEXT :
                    self . State = self . MAIN_STATES [ 'ASM_ACTION_WAITING_FOR_LINE' ]
                    self . AppendWordToSavedArray ( Text )
            else :
                self . AppendWordToSavedArray ( Text )
        elif self . State == self . MAIN_STATES [ 'IN_ONE_LINE_COMMENT' ] :
            if Text [ len ( Text ) - 1 ] == self . NEWLINE :
                self . State = self . MAIN_STATES [ 'NORMAL' ]
                self . EraseSavedWord ( )
                #self . AppendWordToSavedArray ( Text )
        elif self . State == self . MAIN_STATES [ 'IN_MULTILINE_COMMENT' ] :
            LastChars = Text [ len ( Text ) - 2 : len ( Text ) ]
            if LastChars == self . MULTI_LINE_COMMENT_END :
                self . State = self . MAIN_STATES [ 'NORMAL' ]
                self . EraseSavedWord ( )
                #self . AppendWordToSavedArray ( Text )
        elif self . State == self . MAIN_STATES [ 'IN_STRING_LITERAL' ] :
            if Text [ len ( Text ) - 1 ] in QUOTATIONS :
                if Text [ len ( Text ) - 2 ] != self . ESCAPE_CHAR :
                    Str1 = Text [ 0 : len ( Text ) - 1 ]
                    Str2 = Text [ len ( Text ) - 1 : len ( Text ) ]
                    self . AppendWordToSavedArray ( Str1 )
                    self . AppendWordToSavedArray ( Str2 )
        elif self . State == self . MAIN_STATES [ 'ASM_ACTION_WAITING_FOR_LINE' ] :
            if Text == self . NEWLINE :
                self . State = self . MAIN_STATES [ 'IN_ASM_FUNCTION' ]
                self . AppendWordToSavedArray ( Text )
            else :
                self . AppendWordToSavedArray ( Text )
        elif self . State == self . MAIN_STATES [ 'IN_ASM_FUNCTION' ] :
            LastChars = LastChars = Text [ len ( Text ) - 3 : len ( Text ) ]
            if LastChars == self . END_TEXT :
                BeforeText = Text [ 0 : len ( Text ) - 3 ]
                self . AppendWordToSavedArray ( BeforeText )
                self . AppendWordToSavedArray ( LastChars )
                self . State = self . MAIN_STATES [ 'NORMAL' ]
                
    
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
            self . ProcessAppendWord ( self . SavedWord )
        if self . State == self . MAIN_STATES [ 'IN_ONE_LINE_COMMENT' ] or self . State == self . MAIN_STATES [ 'IN_MULTILINE_COMMENT' ] :
            self . AddCharacterToSavedWord ( CurrentLetter )
    
    def IsSavedWordExisting ( self ) :
        Output = False
        if self . SavedWord != self . SAVED_WORD_DEFAULT :
            Output = True
        return Output
    
    def DoLetterIsMeaningfulInSetup ( self ,
        CurrentLetter ) :
        if self . SavedWord == '3' :
            print ( 'aha' , self . SafedWord , self . SavedWord . isalnum ( ) , self . IsSavedWordExisting ( ) , CurrentLetter )
        if self . IsSavedWordExisting ( ) == True and self . SavedWord . isalnum ( ) :
            self . ProcessAppendWord ( self . SavedWord )
        self . AddCharacterToSavedWord ( CurrentLetter )
    
    def EraseSavedWord ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT
    
    def IsLetterNewLine ( self , Letter ) :
        Output = False
        if Letter == self . NEWLINE :
            Output = True
        return Output
	
    def DoLetterIsNewLine ( self , Letter ) :
        if self . IsSavedWordExisting ( ) == True :
            self . ProcessAppendWord ( self . SavedWord )
        self . AddCharacterToSavedWord ( Letter )
        self . ProcessAppendWord ( self . SavedWord )

    def ProcessLetterInSetup ( self ,
        CurrentLetter ) :
        if self . IsLetterWhiteSpace ( CurrentLetter ) == True :
            self . DoLetterIsWhiteSpaceInSetup ( CurrentLetter )
        elif self . IsLetterMeaningful ( CurrentLetter ) :
            self . DoLetterIsMeaningfulInSetup ( CurrentLetter )
        elif self . IsLetterNewLine ( CurrentLetter ) :
            self . DoLetterIsNewLine ( CurrentLetter )
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
        print ( 'self . SavedWordArray = ' + str ( self . SavedWordArray ) )
        return self . SavedWordArray

class Compiler ( ) :
    BEGINNING_TEXT = '''format ELF64 executable 3
segment readable executable
entry Main'''
    
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
    
    FASM_EXTENSION = '.asm'

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
        self . WriteOutputFile ( OutputFileName + self . FASM_EXTENSION , OutputText )
    
    def CalcOutputText ( self , InputText ) :
        OutputText = ''
        OutputText = OutputText + self . GetBeginningText ( )
        OutputText = self . ProgramTranslation ( InputText , OutputText )
        return OutputText
    
    def ProgramTranslation ( self , InputText , OutputText ) :
        MyLexer = Lexer ( )
        MyParser = Parser ( )
        SavedWordArray = MyLexer . MakeTokens ( InputText )
        OutputText , SavedWordArray = MyParser . Parse ( SavedWordArray , OutputText )
        for i in SavedWordArray :
            print ( i )
        return OutputText
    
    def GetBeginningText ( self ) :
        BeginningText = deepcopy ( self . BEGINNING_TEXT )
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
