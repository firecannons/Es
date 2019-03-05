import sys
import pprint
from copy import deepcopy
import traceback

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

class ScopeAdder ( ) :
    def __init__ ( self , Type ) :
        self . Type = Type

class Scope ( ) :
    def __init__ ( self , Type , Offset , RoutineNumber = -1 ) :
        self . Type = Type
        self . Offset = Offset
        self . Symbols = { }
        self . RoutineNumber = RoutineNumber
        if Type == Parser . SCOPE_TYPES [ 'IF' ] :
            self . EndRoutineNumber = RoutineNumber + 1

class MyToken ( ) :
    def __init__ ( self , Name , LineNumber , FileName ) :
        self . Name = Name
        self . LineNumber = LineNumber
        self . FileName = FileName

class CompilerIssue :
    
    FAIL_COLOR_TEXT = '\033[91m'
    END_COLOR_TEXT = '\033[0m'
    
    ERROR_START_TEXT = 'ERROR: '
    ON_LINE_TEXT = ' on line '
    
    @classmethod
    def OutputError ( cls , ErrorText , Exit , Token ) :
        print ( CompilerIssue . FAIL_COLOR_TEXT + CompilerIssue . ERROR_START_TEXT\
         + ErrorText + CompilerIssue . END_COLOR_TEXT )
        print ( CompilerIssue . FAIL_COLOR_TEXT + Token . FileName + cls . ON_LINE_TEXT + str ( Token . LineNumber ) )
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
        'AFTER_TEMPLATE' : 24 ,
        'ACTION_AT_END' : 25 ,
        'RETURN_WAITING_FOR_PARAM' : 26 ,
        'RETURN_AT_END' : 27 ,
        'REDUCING_IF' : 28 ,
        'AFTER_REPEAT' : 29
        
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
        'EQUALS_SIGN' : '=' ,
        'RETURNS' : 'returns' ,
        'IF' : 'if' ,
        'REPEAT' : 'repeat' ,
        'WHILE' : 'while' ,
        'UNTIL' : 'until' ,
        'ELSE_IF' : 'elseif' ,
        'ELSE' : 'else'
        
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
    
    OPERATORS = {
        'COLON' : ':' ,
        'LEFT_PAREN' : '(' ,
        'PLUS' : '+' ,
        'MINUS' : '-' ,
        'MULT' : '*' ,
        'DIVIDE' : '/' ,
        'IS_EQUAL' : '==' ,
        'NOT_EQUAL' : '!=' ,
        'LESS_OR_EQUAL' : '<=' ,
        'GREATER_OR_EQUAL' : '>=' ,
        'GREATER_THAN' : '>' ,
        'LESS_THAN' : '<' ,
        'EQUALS' : '=' ,
        'RIGHT_PAREN' : ')' ,
        'CREATE' : 'create'
    }
    
    MAIN_METHOD_NAMES = {
        OPERATORS [ 'EQUALS' ] : 'On_Equals' ,
        OPERATORS [ 'CREATE' ] : 'On_Create' ,
        OPERATORS [ 'PLUS' ] : 'On_Plus' ,
        OPERATORS [ 'MINUS' ] : 'On_Minus' ,
        OPERATORS [ 'GREATER_THAN' ] : 'On_Greater_Than' ,
        OPERATORS [ 'GREATER_OR_EQUAL' ] : 'On_Greater_Equal' ,
        OPERATORS [ 'IS_EQUAL' ] : 'On_If_Equal' ,
        OPERATORS [ 'LESS_THAN' ] : 'On_Less_Than' ,
        OPERATORS [ 'LESS_OR_EQUAL' ] : 'On_Less_Or_Equal' ,
        OPERATORS [ 'NOT_EQUAL' ] : 'On_Not_Equal'
    }
    
    OPERATOR_MAPPING = {
        OPERATORS [ 'EQUALS' ] : MAIN_METHOD_NAMES [ '=' ] ,
        OPERATORS [ 'CREATE' ] : MAIN_METHOD_NAMES [ 'create' ] ,
    }
    
    OPERATOR_PRECEDENCE = [
        { OPERATORS [ 'COLON' ] , SPECIAL_CHARS [ 'COMMA' ] } ,
        { OPERATORS [ 'LEFT_PAREN' ] } ,
        { OPERATORS [ 'PLUS' ] , OPERATORS [ 'MINUS' ] , OPERATORS [ 'MULT' ] , OPERATORS [ 'DIVIDE' ] } ,
        { OPERATORS [ 'IS_EQUAL' ] , OPERATORS [ 'NOT_EQUAL' ] , OPERATORS [ 'GREATER_THAN' ] , OPERATORS [ 'GREATER_OR_EQUAL' ] , OPERATORS [ 'LESS_OR_EQUAL' ] , OPERATORS [ 'LESS_THAN' ] } ,
        { OPERATORS [ 'EQUALS' ] } ,
        { OPERATORS [ 'RIGHT_PAREN' ] }
    ]
    
    ASM_COMMANDS = {
        'CALL' : 'call'
    }
    
    POINTER_SIZE = 4
    
    ASM_ROUTINE_LETTER = 'S'
    
    ASM_TEXT = {
        'LOAD_TEXT' : 'add esp, {}\n' . format ( -POINTER_SIZE ) +\
            'mov ebx, ebp\n' +\
            'add ebx, {}\n' +\
            'mov [esp], ebx\n' ,
        'ALLOC_BYTE' : 'add esp, -1\n' ,
        'SET_CURRENT_BYTE' : 'mov byte [esp], {}\n' ,
        'DEFAULT_CREATE' : 'add esp, {}\n' +\
            'mov ebx, ebp\n' +\
            'add ebx, {}\n' +\
            'mov [esp], ebx\n' ,
        'STACK_FRAME_BEGIN' : 'push ebp\nmov ebp, esp\n\n' ,
        'STACK_FRAME_END' : '\nmov esp, ebp\npop ebp' ,
        'SHIFT_STRING' : 'add esp, {}\n' ,
        'SET_REG_STRING' : 'mov {}, {}\n' ,
        'WHILE_COMPARISON' : 'mov byte cl, [esp]\ntest cl, cl\nje ' + ASM_ROUTINE_LETTER + '{}\n\n' ,
        'UNTIL_COMPARISON' : 'mov byte cl, [esp]\ntest cl, cl\njne ' + ASM_ROUTINE_LETTER + '{}\n\n' ,
        'IF_COMPARISON' : 'mov byte cl, [esp]\ntest cl, cl\nje ' + ASM_ROUTINE_LETTER + '{}\n\n' ,
        'NEW_ROUTINE_TEXT' : ASM_ROUTINE_LETTER + '{}:\n' ,
        'JUMP_TO_ROUTINE_ASM' : 'jmp ' + ASM_ROUTINE_LETTER + '{}\n'
    }
    
    EXIT_ON_ERROR = True
    
    PROGRAM_EXTENSION = 'q'
    
    EMPTY_STRING = ''
    
    EMPTY_ARRAY = [ ]
    
    FUNCTION_OUTPUT_DELIMITER = '__'
    
    REGISTERS = {
        'STACK_TOP' : 'esp'
    }
    
    BYTE_SIZE = 1
    
    SPACE = ' '
    
    RETURN_TEMP_LETTER = '['
    
    SCOPE_TYPES = {
        'IF' : 0 ,
        'REPEAT' : 1 ,
        'GLOBAL' : 2 ,
        'CLASS' : 3 ,
        'ACTION' : 4
    }
    
    BYTE_TYPE_NAME = 'Byte'
    
    ACTION_DECLARATION_OFFSET = 0
    ACTION_DEFINITION_OFFSET = 0
    
    def __init__ ( self ) :
        self . State = deepcopy ( self . MAIN_STATES [ 'START_OF_LINE' ] )
        self . SavedLine = [ ]
        self . TypeTable = { }
        self . STStack = [ Scope ( self . SCOPE_TYPES [ 'GLOBAL' ] , 0 ) ]
        self . CurrentClass = None
        self . CurrentFunction = None
        self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
        self . SavedType = ''
        self . CurrentSTOffset = 0
        self . SavedLeftOperand = ''
        self . TemplateItemNumber = 0
        self . ParameterArray = [ ]
        self . ReturnTempIndex = 0
        self . RoutineCounter = 0
        self . CurrentToken = None
        self . CurrentTokenObject = None
    
    def Parse ( self , SavedWordArray , OutputText ) :
        WordIndex = 0
        while WordIndex < len ( SavedWordArray ) :
            self . CurrentTokenObject = SavedWordArray [ WordIndex ]
            Token = self . CurrentTokenObject
            self . CurrentToken = Token
            SavedWordArray , WordIndex , OutputText = self . ParseToken ( Token , SavedWordArray , WordIndex , OutputText )
            WordIndex = WordIndex + 1
        PrintObject ( self . TypeTable )
        return OutputText , SavedWordArray
    
    def GetOperatorDepth ( self , Token ) :
        Depth = -1
        if Token . Name == self . EMPTY_STRING :
            Depth = len ( self . OPERATOR_PRECEDENCE )
        DepthIndex = 0
        while DepthIndex < len ( self . OPERATOR_PRECEDENCE ) and Depth == -1 :
            if Token . Name in self . OPERATOR_PRECEDENCE [ DepthIndex ] :
                Depth = DepthIndex
            DepthIndex = DepthIndex + 1
        if Depth == -1 :
            i = i[0]
            CompilerIssue . OutputError ( 'Operator \'' + Token . Name + '\' is not an allowed operator' , self . EXIT_ON_ERROR , Token )
        return Depth
    
    def OpOneHighestPrecedence ( self , Op1 , Op2 ) :
        Output = True
        Depth1 = self . GetOperatorDepth ( Op1 )
        Depth2 = self . GetOperatorDepth ( Op2 )
        if Depth2 < Depth1 :
            Output = False
        return Output
    
    def AllocateByte ( self , CurrentOperand ) :
        OutputText = ''
        OutputText = OutputText + self . ASM_TEXT [ 'ALLOC_BYTE' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        OutputText = OutputText + self . ASM_TEXT [ 'SET_CURRENT_BYTE' ] . format ( CurrentOperand ) + self . SPECIAL_CHARS [ 'NEWLINE' ]
        self . CurrentSTOffset = self . CurrentSTOffset - self . BYTE_SIZE
        return OutputText
    
    def OutputAsmRoutine ( self , OutputText , RoutineNumber ) :
        OutputText = OutputText + self . ASM_TEXT [ 'NEW_ROUTINE_TEXT' ] . format ( RoutineNumber )
        return OutputText
    
    def OutputWhileComparisonAsm ( self , OutputText , RoutineNumber ) :
        OutputText = OutputText + self . ASM_TEXT [ 'WHILE_COMPARISON' ] . format ( RoutineNumber )
        return OutputText
    
    def OutputUntilComparisonAsm ( self , OutputText , RoutineNumber ) :
        OutputText = OutputText + self . ASM_TEXT [ 'UNTIL_COMPARISON' ] . format ( RoutineNumber )
        return OutputText
    
    def OutputIfComparisonAsm ( self , OutputText , RoutineNumber ) :
        OutputText = OutputText + self . ASM_TEXT [ 'IF_COMPARISON' ] . format ( RoutineNumber )
        return OutputText
    
    def OutputJumpToRoutine ( self , OutputText , RoutineNumber ) :
        OutputText = OutputText + self . ASM_TEXT [ 'JUMP_TO_ROUTINE_ASM' ] . format ( RoutineNumber )
        return OutputText
        
    def OutputMoveRegister ( self , OutputText , Register , Number ) :
        OutputText = OutputText + self . SET_REG_STRING . format ( Register , Number )
        return OutputText
    
    def OutputMoveStackRegister ( self , OutputText , Number ) :
        OutputText = self . OutputMoveRegister ( OutputText , self . REGISTERS [ 'STACK_TOP' ] , Number )
        return OutputText
        
    
    def CalcFunctionCall ( self , Operator , ArrayOfOperands , LeftOperand , WordArray , Index ) :
        OutputText = ''
        OriginalOffset = self . CurrentSTOffset
        Class = ''
        ArrayIndex = 0
        for CurrentOperand in ArrayOfOperands :
            if CurrentOperand . isdigit ( ) == True :
                OutputText = OutputText + self . AllocateByte ( CurrentOperand )
                ByteType = self . TypeTable [ self . BYTE_TYPE_NAME ]
                NewName = self . RETURN_TEMP_LETTER + str ( self . ReturnTempIndex )
                OutputText = OutputText + ';Declaring {}\n' . format ( NewName )
                ArrayOfOperands [ ArrayIndex ] = NewName
                NewSymbol = MySymbol ( NewName , ByteType )
                NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                self . GetCurrentST ( ) . Symbols [ NewName ] = NewSymbol
                self . ReturnTempIndex = self . ReturnTempIndex + 1
            ArrayIndex = ArrayIndex + 1
        if LeftOperand != '' :
            Found , CurrentSymbol = self . CheckCurrentSTs ( LeftOperand )
            Class = CurrentSymbol . Type
        for ReturnObject in self . GetActionReturnValues ( Class . Name , self . ResolveActionToAsm ( Operator , Class . Name ) ) :
            OutputText = OutputText + ';Adding return value {}\n'.format(ReturnObject.Name)
            ReturnType = self . TypeTable [ ReturnObject . Type ]
            OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( -ReturnType . Size )
            self . CurrentSTOffset = self . CurrentSTOffset + -ReturnType . Size
            
            NewName = self . RETURN_TEMP_LETTER + str ( self . ReturnTempIndex )
            ReturnType = ReturnObject . Type
            NewSymbol = MySymbol ( NewName , ReturnType )
            NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
            self . GetCurrentST ( ) . Symbols [ NewName ] = NewSymbol
            self . ReturnTempIndex = self . ReturnTempIndex + 1
            WordArray [ Index ] = NewName
        AfterReturnOffset = self . CurrentSTOffset
        FunctionName = self . ResolveActionToAsm ( Operator , Class )
        ActionParameters = self . GetTypeTable ( Class , FunctionName )
        Index = 0
        for CurrentOperand in ArrayOfOperands :
            OutputText = OutputText + ';Loading {}\n'.format(CurrentOperand)
            OperandOffset = 0
            Found , CurrentSymbol = self . CheckCurrentSTs ( CurrentOperand )
            OperandOffset = CurrentSymbol . Offset
            OutputText = OutputText + self . ASM_TEXT [ 'LOAD_TEXT' ] . format ( OperandOffset )
            self . CurrentSTOffset = self . CurrentSTOffset + -self . POINTER_SIZE
            if ActionParameters [ Index ] . Type != CurrentSymbol . Type . Name :
                PrintObject ( ActionParameters )
                PrintObject ( CurrentSymbol )
            Index = Index + 1
        if LeftOperand != '' :
            Found , CurrentSymbol = self . CheckCurrentSTs ( LeftOperand )
            Class = CurrentSymbol . Type
            OutputText = OutputText + ';Loading {}\n'.format(LeftOperand)
            OutputText = OutputText + self . ASM_TEXT [ 'LOAD_TEXT' ] . format ( CurrentSymbol . Offset )
            self . CurrentSTOffset = self . CurrentSTOffset + -self . POINTER_SIZE
        OutputText = OutputText + self . ASM_COMMANDS [ 'CALL' ] + self . SPACE + FunctionName + self . SPECIAL_CHARS [ 'NEWLINE' ]
        OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( AfterReturnOffset - self . CurrentSTOffset )
        self . CurrentSTOffset = AfterReturnOffset
        return OutputText , WordArray
            
    
    def DoOperation ( self , Index , WordArray , CurrentClass , OutputText ) :
        CurrentObject = ''
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
                    CompilerIssue . OutputError ( 'Class \'' + CurrentClass + '\' has no variable \'' + WordArray [ Index + 2 ] + '\'.' , self . EXIT_ON_ERROR , TokenObject )
            elif IsFound == False :
                CompilerIssue . OutputError ( 'Unknown ' + Operator + ' is not an allowed operator' , self . EXIT_ON_ERROR , TokenObject )
        elif WordArray [ Index + 1 ] == self . OPERATORS [ 'LEFT_PAREN' ] :
            if WordArray [ Index ] in self . OPERATORS :
                if WordArray [ Index + 3 ] == self . OPERATORS [ 'RIGHT_PAREN' ] :
                    WordArray . pop ( Index + 1 )
                    WordArray . pop ( Index + 3 )
            else :
                CurrentClass = ''
                if CurrentObject != '' :
                    Found , CurrentClass = self . CheckCurrentSTs ( CurrentObject )
                    CurrentClass = CurrentClass . type
                if self . GetTypeTable ( CurrentClass , WordArray [ Index ] ) :
                    self . ParameterArray = [ WordArray [ Index + 2 ] ] + self . ParameterArray
                    NewOutputText , WordArray = self . CalcFunctionCall ( WordArray [ Index ] , self . ParameterArray , CurrentObject , WordArray , Index )
                    OutputText = OutputText + NewOutputText
                    self . ParameterArray = [ ]
                    WordArray . pop ( Index )
                    WordArray . pop ( Index )
                    WordArray . pop ( Index )
                    WordArray . pop ( Index )
                else :
                    CompilerIssue . OutputError ( 'Function \'' + CurrentClass + ':' + WordArray [ Index ] + '\' does not exist.' , self . EXIT_ON_ERROR , TokenObject )
        elif WordArray [ Index + 1 ] == self . OPERATORS [ 'RIGHT_PAREN' ] :
            Index = Index - 2
        elif WordArray [ Index + 1 ] == self . SPECIAL_CHARS [ 'COMMA' ] :
            CallingFunction = True
            self . ParameterArray = [ WordArray [ Index ] ] + self . ParameterArray
            WordArray . pop ( Index )
            WordArray . pop ( Index )
        elif WordArray [ Index + 1 ] in self . OPERATORS . values ( ) :
            RightOperand = WordArray [ Index + 2 ]
            NewOutputText , WordArray = self . CalcFunctionCall ( WordArray [ Index + 1 ] , [ RightOperand ] , WordArray [ Index ] , WordArray , Index )
            OutputText = OutputText + NewOutputText
            
            WordArray . pop ( Index + 1 )
            WordArray . pop ( Index + 1 )
        return OutputText , Index , WordArray
        
    
    def Reduce ( self , Token , SavedWordArray , OutputText , IsInIf ) :
        WordIndex = 0
        CurrentClass = ''
        FunctionStack = [ ]
        while len ( SavedWordArray ) > 2 :
            Token1 = SavedWordArray [ WordIndex ]
            Token2 = SavedWordArray [ WordIndex + 1 ]
            Token3 = MyToken ( '' , -1 , '' )
            Token4 = MyToken ( '' , -1 , '' )
            Token5 = MyToken ( '' , -1 , '' )
            if len ( SavedWordArray ) - WordIndex > 2 :
                Token3 = SavedWordArray [ WordIndex + 2 ]
            if len ( SavedWordArray ) - WordIndex > 3 :
                Token4 = SavedWordArray [ WordIndex + 3 ]
            if len ( SavedWordArray ) - WordIndex > 4 :
                Token5 = SavedWordArray [ WordIndex + 4 ]
            if self . OpOneHighestPrecedence ( Token2 , Token4 ) :
                OutputText , WordIndex ,  SavedWordArray = self . DoOperation ( WordIndex , SavedWordArray , CurrentClass , OutputText )
            else :
                WordIndex = WordIndex + 2
                
            if len ( SavedWordArray ) - WordIndex < 2 :
                WordIndex = WordIndex - 2
            '''else :
                OutputText = self . DoOperation ( WordIndex , SavedWordArray , CurrentClass , OutputText )
                print ( 'Reducing to' , SavedWordArray )'''
        '''
        WordIndex = 0
        ExprCurrentClass = ''
        ExprCurrentFunction = ''
        while WordIndex < len ( SavedWordArray ) :
            Token = SavedWordArray [ WordIndex ]
            if self . CheckCurrentSTs ( Token ) == True :
            elif self . GetTypeTable ( Expr
            else :
                CompilerIssue . OutputError ( '\'end\' found when not in any upper scope' , self . EXIT_ON_ERROR , TokenObject )'''
        return OutputText
    
    def ProcessStartOfLine ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . KEYWORDS [ 'USING' ] :
            self . State = self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ]
        elif Token . Name == self . KEYWORDS [ 'CLASS' ] :
            self . State = self . MAIN_STATES [ 'CLASS_AFTER' ]
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'CLASS' ] , self . CurrentSTOffset ) )
        elif Token . Name == self . KEYWORDS [ 'ACTION' ] :
            self . State = self . MAIN_STATES [ 'ACTION_AFTER' ]
            self.  CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
            self . CurrentSTOffset = deepcopy ( self . ACTION_DECLARATION_OFFSET )
            self . ActionTypeDeclared = False
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'ACTION' ] , self . CurrentSTOffset ) )
        elif Token . Name == self . KEYWORDS [ 'END' ] :
            if len ( self . STStack ) == 0 :
                CompilerIssue . OutputError ( '\'end\' found when not in any upper scope' , self . EXIT_ON_ERROR , TokenObject )
            CurrentST = self . GetCurrentST ( )
            # There is an initial scope (global) so this should be three (global, class, function)
            if CurrentST . Type == self . SCOPE_TYPES [ 'IF' ]\
                or CurrentST . Type == self . SCOPE_TYPES [ 'REPEAT' ] :
                OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( CurrentST . Offset - self . CurrentSTOffset )
                self . CurrentSTOffset = CurrentST . Offset
                if CurrentST . Type == self . SCOPE_TYPES [ 'REPEAT' ] :
                    OutputText = self . OutputJumpToRoutine ( OutputText , CurrentST . RoutineNumber )
                    OutputText = self . OutputAsmRoutine ( OutputText , CurrentST . RoutineNumber + 1 )
                if CurrentST . Type == self . SCOPE_TYPES [ 'IF' ] :
                    OutputText = self . OutputJumpToRoutine ( OutputText , CurrentST . EndRoutineNumber )
                    OutputText = self . OutputAsmRoutine ( OutputText , CurrentST . RoutineNumber )
                OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( CurrentST . Offset - CurrentST . OffsetAfterComparison )
                if CurrentST . Type == self . SCOPE_TYPES [ 'IF' ] :
                    OutputText = self . OutputAsmRoutine ( OutputText , CurrentST . EndRoutineNumber )
            elif self . CurrentFunction != None :
                self . CurrentFunction = None
                self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
                OutputText = self . CalcActionReturnOutput ( OutputText )
            elif self . CurrentClass != None :
                self . CurrentClass = None
            self . STStack . pop ( len ( self . STStack ) - 1 )
        elif Token . Name == self . KEYWORDS [ 'IF' ] :
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'IF' ] , self . CurrentSTOffset , self . RoutineCounter ) )
            self . RoutineCounter = self . RoutineCounter + 2
            LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex + 1 )
            OutputText = self . Reduce ( Token , LineWordArray , OutputText , True )
            OutputText = self . OutputIfComparisonAsm ( OutputText , self . GetCurrentST ( ) . RoutineNumber )
            self . GetCurrentST ( ) . OffsetAfterComparison = self . CurrentSTOffset
        elif Token . Name == self . KEYWORDS [ 'REPEAT' ] :
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'REPEAT' ] , self . CurrentSTOffset , self . RoutineCounter ) )
            self . RoutineCounter = self . RoutineCounter + 2
            self . State = self . MAIN_STATES [ 'AFTER_REPEAT' ]
        elif Token . Name == self . KEYWORDS [ 'ELSE_IF' ] :
            CurrentST = self . GetCurrentST ( )
            OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( CurrentST . Offset - self . CurrentSTOffset )
            self . CurrentSTOffset = CurrentST . Offset
            OutputText = self . OutputJumpToRoutine ( OutputText , CurrentST . EndRoutineNumber )
            OutputText = self . OutputAsmRoutine ( OutputText , CurrentST . RoutineNumber )
            OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( CurrentST . Offset - CurrentST . OffsetAfterComparison )
            CurrentST . RoutineNumber = self . RoutineCounter
            self . RoutineCounter = self . RoutineCounter + 1
            LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex + 1 )
            OutputText = self . Reduce ( Token , LineWordArray , OutputText , True )
            OutputText = self . OutputIfComparisonAsm ( OutputText , self . GetCurrentST ( ) . RoutineNumber )
            self . GetCurrentST ( ) . OffsetAfterComparison = self . CurrentSTOffset
        elif Token . Name == self . KEYWORDS [ 'ELSE' ] :
            CurrentST = self . GetCurrentST ( )
            OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( CurrentST . Offset - self . CurrentSTOffset )
            self . CurrentSTOffset = CurrentST . Offset
            OutputText = self . OutputJumpToRoutine ( OutputText , CurrentST . EndRoutineNumber )
            OutputText = self . OutputAsmRoutine ( OutputText , CurrentST . RoutineNumber )
            OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( CurrentST . Offset - CurrentST . OffsetAfterComparison )
            CurrentST . RoutineNumber = self . RoutineCounter
            self . RoutineCounter = self . RoutineCounter + 1
            self . GetCurrentST ( ) . OffsetAfterComparison = self . CurrentSTOffset
        elif self . CurrentFunction != None and self . CurrentFunctionType == self . FUNCTION_TYPES [ 'ASM' ] :
            OutputText = OutputText + Token
        elif self . IsValidName ( Token ) == True :
            if Token . Name in self . TypeTable :
                if self . TypeTable [ Token ] . IsFunction == False :
                    self . SavedType = Token
                    self . State = self . MAIN_STATES [ 'DECLARING_VARIABLE' ]
                else :
                    Found = self . CheckCurrentSTs ( Token )
                    LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                    OutputText = self . Reduce ( Token , LineWordArray , OutputText , False )
            elif self . CheckCurrentSTs ( Token  . Name ) :
                print ( Token . Name , self . TypeTable , 'asfd' )
                Found = self . CheckCurrentSTs ( Token )
                LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                OutputText = self . Reduce ( Token , LineWordArray , OutputText , False )
            else :
                CompilerIssue . OutputError ( 'Type or symbol \'' + Token + '\' not found' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText
    
    def ProcessUsingWaitingForWord ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name . isalnum ( ) == False :
            CompilerIssue . OutputError ( '\'' + Token . Name + '\' is not alphanumeric' , self . EXIT_ON_ERROR , TokenObject )
        else :
            self . SavedLine . append ( Token )
            self . State = self . MAIN_STATES [ 'USING_AFTER_WORD' ]
        return SavedWordArray , WordIndex , OutputText
    
    def ProcessUsingAfterWord ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'PERIOD' ] :
            self . SavedLine . append ( Token )
            self . State = self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ]
        elif Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            Path = self . ConvertToPath ( self . SavedLine )
            Path = Path + self . SPECIAL_CHARS [ 'PERIOD' ] + self . PROGRAM_EXTENSION
            Text = self . ReadFile ( Path )
            MyLexer = Lexer ( )
            NewTokens = MyLexer . MakeTokens ( Text , Path )
            FirstWordArray = SavedWordArray [ 0 : WordIndex + 1 : ]
            SecondWordArray = SavedWordArray [ WordIndex : len ( SavedWordArray ) : ]
            SavedWordArray = FirstWordArray + NewTokens + SecondWordArray
            self . SavedLine = [ ]
            self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        else :
            CompilerIssue . OutputError ( '\'' + Token . Name + '\' is not a period or newline' , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText
    
    def PrintParsingStatus ( self , Token ) :
        ClassName = ''
        if self . CurrentClass != None :
            ClassName = self . CurrentClass . Name
        FunctionName = ''
        if self . CurrentFunction != None :
            FunctionName = self . CurrentFunction . Name
        print ( 'Parsing ' , Token . Name , self . State , ClassName , self . CurrentFunction , len ( self . STStack ) , self . SavedLine )
    
    def ParseToken ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        self . PrintParsingStatus ( Token )
        if self . State == self . MAIN_STATES [ 'START_OF_LINE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessStartOfLine ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'DECLARING_VARIABLE' ] :
            if self . CurrentFunctionType == self . FUNCTION_TYPES [ 'NORMAL' ] :
                if Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_START' ] :
                    self . State = self . MAIN_STATES [ 'MAKING_TEMPLATE' ]
                elif self . SavedType in self . TypeTable :
                    if Token not in self . GetCurrentST ( ) . Symbols :
                        NewSymbol = MySymbol ( Token , self . TypeTable [ self . SavedType ] )
                        self . CurrentSTOffset = self . CurrentSTOffset - self . TypeTable [ self . SavedType ] . Size
                        NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                        self . GetCurrentST ( ) . Symbols [ Token ] = NewSymbol
                        if self . CurrentClass != '' :
                            self . TypeTable [ self . CurrentClass ] . Size = self . TypeTable [ self . CurrentClass ] . Size + self . TypeTable [ self . SavedType ] . Size
                            self . TypeTable [ self . CurrentClass ] . InnerTypes [ Token ] = NewSymbol
                        OutputText = OutputText + ';Declaring {}\n' . format ( Token )
                        OutputText = self . CalcDeclarationOutput ( self . SavedType , OutputText )
                        LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                        OutputText = self . Reduce ( Token , LineWordArray , OutputText , False )
                        self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
                    else :
                        CompilerIssue . OutputError ( 'A variable named ' + Token + ' has already been declared' , self . EXIT_ON_ERROR )
                else :
                    CompilerIssue . OutputError ( 'The type \'' + self . SavedType + '\' is not currently a declared type and is not template start ' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'AFTER_DECLARING_VARIABLE' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected newline encountered \'' + Token + '\'' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'MAKING_TEMPLATE' ] :
            if self . IsValidName ( Token ) == True :
                if Token in self . TypeTable :
                    if self . TypeTable [ Token ] . IsFunction == False :
                        self . State = self . MAIN_STATES [ 'AFTER_TEMPLATE_NAME' ]
                    else :
                       CompilerIssue . OutputError ( 'Template type \'' + Token + '\' was found to be a function not class', self . EXIT_ON_ERROR , TokenObject ) 
                else :
                    CompilerIssue . OutputError ( 'Template type \'' + Token + '\' not found in type table', self . EXIT_ON_ERROR , TokenObject )
            else :
                CompilerIssue . OutputError ( 'Expected valid type for template instead of \'' + Token + '\'', self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'AFTER_TEMPLATE_NAME' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
                self . State = self . MAIN_STATES [ 'MAKING_TEMPLATE' ]
            elif Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_END' ] :
                self . State = self . MAIN_STATES [ 'DECLARING_VARIABLE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . SPECIAL_CHARS [ 'COMMA' ] + '\' or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_END' ] + '\' instead of \'' + Token + '\'' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessUsingWaitingForWord ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'USING_AFTER_WORD' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessUsingAfterWord ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER' ] :
            if self . IsValidName ( Token ) == False :
                CompilerIssue . OutputError ( Token + ' is in the wrong format for a class name' , self . EXIT_ON_ERROR , TokenObject )
            else :
                self . TypeTable [ Token ] = Type ( Token )
                self . CurrentClass = self . TypeTable [ Token ]
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_NAME' ]
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_NAME' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            elif Token . Name == self . KEYWORDS [ 'SIZE' ] :
                self . State = self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ]
            elif Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_START' ] :
                self . State = self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . KEYWORDS [ 'SIZE' ] + '\' or newline or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_START' ] + '\'' , self . EXIT_ON_ERROR , Token )
        elif self . State == self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ] :
            if self . IsValidName ( Token ) == False :
                CompilerIssue . OutputError ( Token + ' is in the wrong format for a template name' , self . EXIT_ON_ERROR , TokenObject )
            else :
                self . TypeTable [ self . CurrentClass ] . Templates [ Token ] = set ( )
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATE_NAME' ]
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATE_NAME' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
                self . State = self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ]
            elif Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_END' ] :
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATES' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . SPECIAL_CHARS [ 'COMMA' ] + '\' or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_END' ] + '\'.'  , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATES' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            elif Token . Name == self . KEYWORDS [ 'SIZE' ] :
                self . State = self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ]
            else :
                CompilerIssue . OutputError ( 'Expected \'' + self . KEYWORDS [ 'SIZE' ] + '\' or newline' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ] :
            if Token . Name . isdigit ( ) == True :
                self . TypeTable [ self . CurrentClass ] . Size = int ( Token . Name )
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_DECLARING_SIZE' ]
            else :
                CompilerIssue . OutputError ( 'Expected number to go after' + self . KEYWORDS [ 'SIZE' ] , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_DECLARING_SIZE' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected newline after declaring class size' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER' ] :
            if Token . Name == self . KEYWORDS [ 'ASM' ] :
                if self . ActionTypeDeclared == True :
                    CompilerIssue . OutputError ( '\'' + self . KEYWORDS [ 'ASM' ] + '\' declared twice on function' , self . EXIT_ON_ERROR , TokenObject )
                else :
                    self . CurrentFunctionType = self . FUNCTION_TYPES [ 'ASM' ]
                    self . ActionTypeDeclared = True
            elif Token . Name == self . KEYWORDS [ 'NORMAL' ] :
                if self . ActionTypeDeclared == True :
                    CompilerIssue . OutputError ( '\'' + self . KEYWORDS [ 'NORMAL' ] + '\' declared twice on function' , self . EXIT_ON_ERROR , TokenObject )
                else :
                    self . CurrentFunctionType = self . FUNCTION_TYPES [ 'NORMAL' ]
                    self . ActionTypeDeclared = True
            elif self . IsValidName ( Token ) == True :
                if self . CurrentClass != '' :
                    if Token . Name == self . KEYWORDS [ 'ON' ] :
                        self . State = self . MAIN_STATES [ 'ACTION_AFTER_ON' ]
                    else :
                        Found , OutSymbol = self . CheckCurrentSTs ( Token )
                        if self . ResolveActionToAsm ( Token , self . CurrentClass ) in self . CurrentTypeTable ( ) :
                            CompilerIssue . OutputError ( self . CurrentClass + ' already has a action named ' + Token , self . EXIT_ON_ERROR , TokenObject )
                        else :
                            self . CurrentTypeTable ( ) [ Token ] = Function ( self . CurrentFunction )
                            self . CurrentFunction = Token
                            self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
                else :
                    Found , OutSymbol = self . CheckCurrentSTs ( Token )
                    if self . ResolveActionToAsm ( Token , self . CurrentClass ) in self . CurrentTypeTable ( ) :
                        CompilerIssue . OutputError ( self . CurrentClass + ' already has a action named ' + Token , self . EXIT_ON_ERROR , TokenObject )
                    else :
                        self . TypeTable [ Token ] = Function ( Token )
                        self . CurrentFunction = Token
                        self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
            else :
                CompilerIssue . OutputError ( Token + ' is in the wrong format for a method name' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_ON' ] :
            if self . CanResolveSymbolAction ( Token ) :
                if self . ResolveActionToAsm ( Token , self . CurrentClass ) in self . CurrentTypeTable ( ) :
                    CompilerIssue . OutputError ( self . CurrentClass + ' has already overloaded operator \'' + Token + '\'' , self . EXIT_ON_ERROR , TokenObject )
                else :
                    self . CurrentFunction = self . ResolveActionToAsm ( Token , self . CurrentClass )
                    self . TypeTable [ self . CurrentClass ] . InnerTypes [ self . CurrentFunction ] = Function ( self . CurrentFunction )
                    self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
            else :
                CompilerIssue . OutputError ( 'Cannot overload operator \'' + Token + '\'' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_NAME' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'LEFT_PAREN' ] :
                self . State = self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ]
            elif Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                OutputText = self . OutputActionStartCode ( OutputText )
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected left paren or newline in action declaration' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ] :
            if self . IsValidName ( Token ) :
                if Token in self . TypeTable :
                    self . SavedType = Token
                    self . State = self . MAIN_STATES [ 'ACTION_PARAM_NAME' ]
                else :
                    CompilerIssue . OutputError ( 'Unknown type \'' + Token + '\'' , self . EXIT_ON_ERROR , TokenObject )
            else :
                CompilerIssue . OutputError ( 'Expected variable or right paren in action declaration' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'ACTION_PARAM_NAME' ] :
            if self . IsValidName ( Token ) :
                if Token in self . CurrentTypeTable ( ) :
                    CompilerIssue . OutputError ( 'There is already a \'' + Token + '\' in the current scope' , self . EXIT_ON_ERROR , TokenObject )
                else :
                    NewSymbol = MySymbol ( Token , self . SavedType )
                    self . CurrentSTOffset = self . CurrentSTOffset - self . TypeTable [ self . SavedType ] . Size
                    NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                    self . GetCurrentST ( ) . Symbols [ Token ] = NewSymbol
                    self . CurrentTypeTable ( ) . append ( NewSymbol )
                    self . State = self . MAIN_STATES [ 'ACTION_AFTER_PARAM' ]
            else :
                CompilerIssue . OutputError ( 'Invalid variable name in action declaration' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_PARAM' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
                self . State = self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ]
            elif Token . Name == self . SPECIAL_CHARS [ 'RIGHT_PAREN' ] :
                self . State = self . MAIN_STATES [ 'ACTION_AT_END' ]
        elif self . State == self . MAIN_STATES [ 'ACTION_AT_END' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . CurrentSTOffset = deepcopy ( self . ACTION_DEFINITION_OFFSET )
                OutputText = self . OutputActionStartCode ( OutputText )
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            elif Token . Name == self . KEYWORDS [ 'RETURNS' ] :
                self . State = self . MAIN_STATES [ 'RETURN_WAITING_FOR_PARAM' ]
            else :
                CompilerIssue . OutputError ( 'Expected NEWLINE or ' , self . KEYWORDS [ 'RETURNS' ] , ' after action' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'RETURN_WAITING_FOR_PARAM' ] :
            if Token in self . TypeTable :
                NewSymbol = MySymbol ( deepcopy ( self . EMPTY_STRING ) , Token )
                self . CurrentSTOffset = self . CurrentSTOffset - self . TypeTable [ Token ] . Size
                NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                self . GetActionReturnValues ( self . CurrentClass , self . CurrentFunction ) . append ( NewSymbol )
                self . State = self . MAIN_STATES [ 'RETURN_AT_END' ]
            else :
                CompilerIssue . OutputError ( 'The type {} is not a currently valid type' . format ( Token ) , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'RETURN_AT_END' ] :
            if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
                self . CurrentSTOffset = deepcopy ( self . ACTION_DEFINITION_OFFSET )
                OutputText = self . OutputActionStartCode ( OutputText )
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            else :
                CompilerIssue . OutputError ( 'Expected NEWLINE after return values' , self . EXIT_ON_ERROR , TokenObject )
        elif self . State == self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ] :
            if Token . Name == self . COLON :
                self . State = self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ]
            elif Token in self . ClassTypeTable ( self . SavedLeftOperand . Name ) :
                self . SavedOperator = Token
                self . State = self . MAIN_STATES [ 'WAITING_FOR_RIGHT_OPERATOR' ]
            else :
                CompilerIssue . OutputError ( 'Cound not find ' + Token + ' in ' + self . SavedLeftOperand . Name + ' which is of type '
                    + self . SavedLeftOperand . Type , self . EXIT_ON_ERROR , TokenObject )
                self . State = self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ]
        elif self . State == self . MAIN_STATES [ 'AFTER_REPEAT' ] :
            if Token != self . KEYWORDS [ 'WHILE' ] and Token != self . KEYWORDS [ 'UNTIL' ] :
                CompilerIssue . OutputError ( 'Expected \'{}\' or \'{}\' after {}' . format ( self . KEYWORDS [ 'WHILE' ] , self . KEYWORDS [ 'UNTIL' ] , self . KEYWORDS [ 'REPEAT' ] )
                    , self . EXIT_ON_ERROR , TokenObject )
            else :
                OutputText = self . OutputAsmRoutine ( OutputText , self . GetCurrentST ( ) . RoutineNumber )
                LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex + 1 )
                OutputText = self . Reduce ( Token , LineWordArray , OutputText , True )
                if Token . Name == self . KEYWORDS [ 'WHILE' ] :
                    OutputText = self . OutputWhileComparisonAsm ( OutputText , self . GetCurrentST ( ) . RoutineNumber + 1 )
                else :
                    OutputText = self . OutputUntilComparisonAsm ( OutputText , self . GetCurrentST ( ) . RoutineNumber + 1 )
                self . GetCurrentST ( ) . OffsetAfterComparison = self . CurrentSTOffset
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        return SavedWordArray , WordIndex , OutputText
    
    def ResolveActionToName ( self , Action , Class ) :
        Output = ''
        if Action . Name in self . MAIN_METHOD_NAMES :
            Output = Output + self . MAIN_METHOD_NAMES [ Action . Name ]
        else :
            Output = Output + Action . Name
        return Output
    
    def ResolveActionToAsm ( self , Action , Class ) :
        Output = ''
        if Class . Name != '' :
            Output = Output + Class . Name + self . FUNCTION_OUTPUT_DELIMITER
        Output = Output + self . ResolveActionToName ( Action , Class )
        return Output
            
    
    def CanResolveSymbolAction ( self , ActionSymbol ) :
        Output = True
        if ActionSymbol in self . OPERATORS and ActionSymbol in self . MAIN_METHOD_NAMES :
            Output = True
        return Output
    
    def CalcActionReturnOutput ( self , OutputText ) :
        OutputText = OutputText + self . SPECIAL_CHARS [ 'NEWLINE' ] + self . ASM_TEXT [ 'STACK_FRAME_END' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        OutputText = OutputText + 'ret' + self . SPECIAL_CHARS [ 'NEWLINE' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        return OutputText
    
    def CalcFunctionName ( self , Class , Function ) :
        OutputText = ''
        OutputText = OutputText + self . ResolveActionToName ( Function , Class )
        OutputText = OutputText + self . SPECIAL_CHARS [ 'COLON' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        OutputText = OutputText + self . SPECIAL_CHARS [ 'NEWLINE' ] + self . ASM_TEXT [ 'STACK_FRAME_BEGIN' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        return OutputText
    
    def CalcCallLine ( self , OutputText , FunctionName ) :
        OutputText = OutputText + self . ASM_COMMANDS [ 'CALL' ] + self . SPACE + FunctionName + self . SPECIAL_CHARS [ 'NEWLINE' ]
        return OutputText
    
    def CalcDeclarationOutput ( self , SavedType , OutputText ) :
        
        OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( -self . TypeTable [ SavedType ] . Size ) + self . SPECIAL_CHARS [ 'NEWLINE' ]
        OutputText = OutputText + self . ASM_TEXT [ 'DEFAULT_CREATE' ] . format ( -self . POINTER_SIZE , self . CurrentSTOffset )
        OutputText = self . CalcCallLine ( OutputText , self . ResolveActionToAsm ( 'create' , self . TypeTable [ SavedType ] . Name ) )
        OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( self . POINTER_SIZE )
        return OutputText
    
    def OutputActionStartCode ( self , OutputText ) :
        OutputText = OutputText + self . CalcFunctionName ( self . CurrentClass , self . CurrentFunction )
        #for Parameter in self . CurrentTypeTable ( ) :
            #OutputText = OutputText + 'add rsp , ' + str ( self . TypeTable [ Parameter . Type ] . Size ) + self . SPECIAL_CHARS [ 'NEWLINE' ]
        return OutputText
    
    def GetUntilNewline ( self , SavedWordArray , WordIndex ) :
        LineWordArray = [ ]
        TempWordIndex = WordIndex
        while SavedWordArray [ WordIndex ] . Name != self . SPECIAL_CHARS [ 'NEWLINE' ] :
            LineWordArray . append ( SavedWordArray [ WordIndex ] )
            WordIndex = WordIndex + 1
        return LineWordArray , WordIndex
    
    def GetCurrentST ( self ) :
        return self . STStack [ len ( self . STStack ) - 1 ]
    
    def CheckCurrentSTs ( self , NameOfSymbol ) :
        Found = False
        OutSymbol = None
        Index = 0
        StackHeight = len ( self . STStack ) - 1
        while Found == False and StackHeight - Index >= 0 :
            if NameOfSymbol in self . STStack [ StackHeight - Index ] . Symbols :
                Found = True
                OutSymbol = self . STStack [ StackHeight - Index ] . Symbols [ NameOfSymbol ]
            Index = Index + 1
        return Found , OutSymbol
        
    def CurrentTypeTable ( self ) :
        OutTable = self . TypeTable
        if self . CurrentFunction != None :
            OutTable = self . CurrentFunction . Parameters
        elif self . CurrentClass != None :
            OutTable = self . CurrentClass . InnerTypes
        return OutTable
    
    def GetTypeTable ( self , Class , Function ) :
        OutTable = self . TypeTable
        if Class != '' :
            OutTable = self . TypeTable [ Class ] . InnerTypes
        if Function != '' :
            OutTable = OutTable [ Function ] . Parameters
        return OutTable
    
    def GetActionReturnValues ( self , Class , Function ) :
        OutTable = self . TypeTable
        if Class != None :
            OutTable = Class . InnerTypes
        OutTable = OutTable [ Function ] . ReturnValues
        return OutTable
    
    
    def IsValidName ( self , Token ) :
        Output = True
        if Token . Name [ 0 ] . isalpha ( ) == False or Token . Name . isalnum ( ) == False :
            Output = False
        return Output
    
    def ConvertToPath ( self , PathWordArray ) :
        Text = ''
        for Token in PathWordArray :
            Text = Text + Token . Name
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
        self . LineNumber = 1
        self . FileName = ''
    
    def AppendWordToSavedArray ( self , Text ) :
        self . SavedWordArray . append ( MyToken ( Text , self . LineNumber , self . FileName ) ) 
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
                if self . SavedWordArray [ len ( self . SavedWordArray ) - 1 ] . Name == self . ACTION_TEXT :
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
        if self . State == self . MAIN_STATES [ 'IN_ONE_LINE_COMMENT' ] or self . State == self . MAIN_STATES [ 'IN_MULTILINE_COMMENT' ]\
            or self . State == self . MAIN_STATES [ 'IN_ASM_FUNCTION' ] :
            self . AddCharacterToSavedWord ( CurrentLetter )
    
    def IsSavedWordExisting ( self ) :
        Output = False
        if self . SavedWord != self . SAVED_WORD_DEFAULT :
            Output = True
        return Output
    
    def DoLetterIsMeaningfulInSetup ( self ,
        CurrentLetter ) :
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
            self . LineNumber = self . LineNumber + 1
        else :
            self . AddCharacterToSavedWord ( CurrentLetter )
    
    def MakeTokens ( self , InputText , FileName ) :
        self . FileName = FileName
        Position = 0
        LineNumber = 0
        InputTextLength = len ( InputText )
        while ( Position < InputTextLength ) :
            CurrentLetter = InputText [ Position ]
            self . ProcessLetterInSetup ( CurrentLetter )
            Position = Position + 1
        if self . SavedWord != '' :
            self. SavedWordArray . append ( MyToken ( self . SavedWord , self . LineNumber , FileName ) )
        print ( 'self . SavedWordArray = ' + str ( self . SavedWordArray ) )
        return self . SavedWordArray


class Compiler ( ) :
    BEGINNING_TEXT = '''format ELF executable 3
segment readable executable
entry Main\n\n
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
        OutputText = self . CalcOutputText ( InputText , InputFileName )
        self . WriteOutputFile ( OutputFileName + self . FASM_EXTENSION , OutputText )
    
    def CalcOutputText ( self , InputText , Path ) :
        OutputText = ''
        OutputText = OutputText + self . GetBeginningText ( )
        OutputText = self . ProgramTranslation ( InputText , OutputText , Path )
        return OutputText
    
    def ProgramTranslation ( self , InputText , OutputText , Path ) :
        MyLexer = Lexer ( )
        MyParser = Parser ( )
        SavedWordArray = MyLexer . MakeTokens ( InputText , Path )
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
