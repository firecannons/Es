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
        self . DereferenceOffset = 0
        self . IsFunction = False
        self . Templates = [ ]
        self . IsReference = False
        self . IsDereferenced = False
        self . ActLikeReference = False

class Function ( ) :
    def __init__ ( self , Name ) :
        self . Name = Name
        self . Parameters = [ ]
        self . ReturnValues = [ ]
        self . IsFunction = True
        self . Templates = [ ]
        self . TypeOfCode = Parser . FUNCTION_TYPES [ 'NORMAL' ]

class Type ( ) :
    
    def __init__ ( self , Name ) :
        self . Name = Name
        self . InnerTypes = { }
        self . Size = 0
        self . IsFunction = False
        self . Templates = [ ]
        self . TemplatedCode = [ ]

class TemplateElem ( ) :
    def __init__ ( self , Name ) :
        self . Name = Name

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

class CodeFunction ( ) :
    def __init__ ( self , Code ) :
        self . Code = Code

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
        'AFTER_REPEAT' : 29 ,
        'TEMPLATED_CODE' : 30
        
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
        'ELSE' : 'else' ,
        'REFERENCE' : 'reference' ,
        'RETURN' : 'return' ,
        'SIZE_OF' : 'SizeOf' ,
        'GET_CLASS_NAME' : 'GetClassName' ,
        'GET_RESOLVED_CLASS_NAME' : 'GetResolvedClassName'
        
    }
    
    ASM_REPLACE_STRINGS = [ KEYWORDS [ 'SIZE_OF' ] , KEYWORDS [ 'GET_CLASS_NAME' ] , KEYWORDS [ 'GET_RESOLVED_CLASS_NAME' ] ]
    
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
    
    # Operator Precedence is opposite of operator eval order
    OPERATOR_EVAL_ORDER = [
        { OPERATORS [ 'COLON' ] } ,
        { OPERATORS [ 'PLUS' ] , OPERATORS [ 'MINUS' ] , OPERATORS [ 'MULT' ] , OPERATORS [ 'DIVIDE' ] } ,
        { OPERATORS [ 'IS_EQUAL' ] , OPERATORS [ 'NOT_EQUAL' ] , OPERATORS [ 'GREATER_THAN' ] , OPERATORS [ 'GREATER_OR_EQUAL' ] , OPERATORS [ 'LESS_OR_EQUAL' ] , OPERATORS [ 'LESS_THAN' ] } ,
        { OPERATORS [ 'EQUALS' ] } ,
        { SPECIAL_CHARS [ 'COMMA' ] } ,
        { OPERATORS [ 'LEFT_PAREN' ] , OPERATORS [ 'RIGHT_PAREN' ] }
    ]
    
    ASM_COMMANDS = {
        'CALL' : 'call'
    }
    
    POINTER_SIZE = 4
    
    ASM_ROUTINE_LETTER = 'S'
    
    ZERO_SHIFT = 0
    
    ASM_TEXT = {
        'LOAD_TEXT' : 'add esp, {}\n' . format ( -POINTER_SIZE ) +\
            'mov ebx, ebp\n' +\
            'add ebx, {}\n' +\
            'mov [esp], ebx\n' ,
        'MOVE_EBX_TO_LOCATION' : 'mov ebx, ebp\n' +\
            'add ebx, {}\n' ,
        'PLACE_ECX_AT_OFFSET' : 'mov ebx, ebp\n' +\
            'add ebx, {}\n' +\
            'mov [ebx], ecx\n' ,
        'DEREFERENCE_EBX' : 'mov ebx, [ebx]\n' ,
        'SHIFT_EBX' : 'add ebx, {}\n' ,
        'INSERT_EBX' : 'mov [esp], ebx\n' ,
        'EBX_TO_ECX' : 'mov ecx, ebx\n' ,
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
    TEMPLATE_DELIMITER = '__'
    
    REGISTERS = {
        'STACK_TOP' : 'esp'
    }
    
    BYTE_SIZE = 1
    
    SPACE = ' '
    
    RETURN_TEMP_LETTER = '['
    TEMPLATE_VARIABLE_BEGIN = '[T'
    
    SCOPE_TYPES = {
        'IF' : 0 ,
        'REPEAT' : 1 ,
        'GLOBAL' : 2 ,
        'CLASS' : 3 ,
        'ACTION' : 4
    }
    
    BYTE_TYPE_NAME = 'Byte'
    
    SELF_OBJECT_NAME = 'Me'
    ACTION_DECLARATION_OFFSET = 0
    ACTION_DEFINITION_OFFSET = 0
    ACTION_DECLARATION_PARAM_OFFSET = 8
    CLASS_DECLARATION_OFFSET = 0
    NORMAL_TOKEN_SIZE = 1
    
    def __init__ ( self ) :
        self . State = deepcopy ( self . MAIN_STATES [ 'START_OF_LINE' ] )
        self . SavedLine = [ ]
        self . TypeTable = { }
        self . STStack = self . GetStartingScopeStack ( )
        self . CurrentClass = None
        self . CurrentFunction = None
        self . SavedType = ''
        self . CurrentSTOffset = 0
        self . SavedLeftOperand = ''
        self . TemplateItemNumber = 0
        self . ParameterArray = [ ]
        self . ReturnTempIndex = 0
        self . RoutineCounter = 0
        self . CurrentToken = None
        self . CurrentTokenObject = None
        self . CurrentlyReference = False
        self . AfterReturnOffset = 0
        self . SavedTemplates = [ ]
        self . TempTemplateClass = None
        self . CodeArray = [ ]
        self . TempSavedTemplate = [ ]
        self . TemplateTempIndex = 0
    
    def GetStartingScopeStack ( self ) :
        STStack = [ Scope ( self . SCOPE_TYPES [ 'GLOBAL' ] , 0 ) ]
        return STStack
    
    def ParseTokens ( self , SavedWordArray , OutputText ) :
        WordIndex = 0
        while WordIndex < len ( SavedWordArray ) :
            self . CurrentTokenObject = SavedWordArray [ WordIndex ]
            Token = self . CurrentTokenObject
            self . CurrentToken = Token
            SavedWordArray , WordIndex , OutputText = self . ParseToken ( Token , SavedWordArray , WordIndex , OutputText )
            WordIndex = WordIndex + 1
        return OutputText , SavedWordArray
    
    def Parse ( self , SavedWordArray , OutputText ) :
        OutputText , SavedWordArray = self . ParseTokens ( SavedWordArray , OutputText )
        OutputText = self . CombineCodeArray ( self . CodeArray ) + OutputText
        print ( self . TypeTable , self . TypeTable [ 'Pointer' ] )
        print ( self . TypeTable [ 'Pointer' ] . InnerTypes )
        return OutputText , SavedWordArray
    
    def CombineCodeArray ( self , CodeArray ) :
        OutputText = ''
        for Temp in CodeArray :
            OutputText = OutputText + Temp . Code
        return OutputText
    
    def GetOperatorDepth ( self , Token ) :
        Depth = -1
        if Token . Name == self . EMPTY_STRING :
            Depth = len ( self . OPERATOR_EVAL_ORDER )
        DepthIndex = 0
        while DepthIndex < len ( self . OPERATOR_EVAL_ORDER ) and Depth == -1 :
            if Token . Name in self . OPERATOR_EVAL_ORDER [ DepthIndex ] :
                Depth = DepthIndex
            DepthIndex = DepthIndex + 1
        if Depth == -1 :
            CompilerIssue . OutputError ( 'Operator \'' + Token . Name + '\' is not an allowed operator' , self . EXIT_ON_ERROR , Token )
        return Depth
    
    def OpOneHighestPrecedence ( self , Op1 , Op2 ) :
        print ( self . State , 'self . State' )
        Output = True
        Depth1 = self . GetOperatorDepth ( Op1 )
        Depth2 = self . GetOperatorDepth ( Op2 )
        if Depth2 < Depth1 :
            Output = False
        return Output
    
    def AllocateByte ( self , CurrentOperand ) :
        OutputText = ''
        OutputText = OutputText + self . ASM_TEXT [ 'ALLOC_BYTE' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        OutputText = OutputText + self . ASM_TEXT [ 'SET_CURRENT_BYTE' ] . format ( CurrentOperand . Name ) + self . SPECIAL_CHARS [ 'NEWLINE' ]
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

    def GetNextTempVariableIndex ( self ) :
        self.ReturnTempIndex = self . ReturnTempIndex + 1
        return self . ReturnTempIndex - 1

    def AllocateByteFromNumber ( self , CurrentOperand , OutputText , ArrayOfOperands , ArrayIndex ) :
        OutputText = OutputText + self . AllocateByte ( CurrentOperand )
        ByteType = self . TypeTable [ self . BYTE_TYPE_NAME ]
        NewName = self . RETURN_TEMP_LETTER + str ( self . GetNextTempVariableIndex ( ) )
        OutputText = OutputText + ';Declaring {} {}\n'.format(NewName , self . CurrentSTOffset )
        NewSymbol = MySymbol ( NewName , ByteType )
        ArrayOfOperands [ ArrayIndex ] = NewSymbol
        NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
        self . GetCurrentST ( ) . Symbols [ NewName ] = NewSymbol
        return OutputText , ArrayOfOperands

    def GetObjectTypeName ( self , Object ) :
        ClassName = ''
        if Object is not None :
            ClassName = Object . Type . Name
        return ClassName

    def GetObjectType ( self , Object ) :
        Type = None
        if Object is not None :
            Type = Object . Type
        return Type

    def GetTypeName ( self , Type ) :
        TypeName = ''
        if Type != None :
            TypeName = Type . Name
        return TypeName
    
    def PrintWordArray ( self , WordArray ) :
        Ar = [ ]
        for el in WordArray :
            Ar . append ( el . Name )
        print ( Ar )

    def AddReturnValue ( self , ReturnObject , WordArray , Index , OutputText ) :
        OutputText = OutputText + ';Adding return value {}\n'.format(ReturnObject.Name)
        ReturnType = ReturnObject.Type
        OutputText = OutputText + self.ASM_TEXT['SHIFT_STRING'].format(-ReturnType.Size)
        self.CurrentSTOffset = self.CurrentSTOffset + -ReturnType.Size

        NewName = self.RETURN_TEMP_LETTER + str(self.ReturnTempIndex)
        ReturnType = ReturnObject.Type
        NewSymbol = MySymbol(NewName, ReturnType)
        NewSymbol.Offset = deepcopy(self.CurrentSTOffset)
        self.GetCurrentST().Symbols[NewName] = NewSymbol
        self.ReturnTempIndex = self.ReturnTempIndex + 1
        # Put a temporary variable into the return value.  This is for scenarios like S1 = S2 + 1.  This
        #   will turn into S1 = [temp].  Also remember that = does not return anything (for the moment).
        WordArray[Index] = MyToken ( NewName , WordArray [ Index - 1 ] . LineNumber , WordArray [ Index - 1 ] . FileName )
        return WordArray , Index , OutputText
    
    def OutputPointerShift ( self ) :
        OutputText = ''
        OutputText = OutputText + self.ASM_TEXT['SHIFT_STRING'].format(-self . POINTER_SIZE)
        return OutputText
    
    def LoadReference ( self , CurrentSymbol ) :
        OutputText = ''
        OutputText = OutputText + self . OutputPointerShift ( )
        OutputText = OutputText + self.ASM_TEXT['MOVE_EBX_TO_LOCATION'].format(CurrentSymbol.Offset)
        OutputText = OutputText + self.ASM_TEXT['DEREFERENCE_EBX']
        if True == True :
            OutputText = OutputText + self.ASM_TEXT['SHIFT_EBX'].format(CurrentSymbol . DereferenceOffset)
        OutputText = OutputText + self.ASM_TEXT['INSERT_EBX']
        OutputText = OutputText + '; loading a reference!' + CurrentSymbol . Name + '\n' 
        return OutputText
    
    def LoadValue ( self , CurrentSymbol ) :
        OutputText = ''
        OutputText = OutputText + self . OutputPointerShift ( )
        OutputText = OutputText + self.ASM_TEXT['MOVE_EBX_TO_LOCATION'].format(CurrentSymbol.Offset)
        OutputText = OutputText + self.ASM_TEXT['INSERT_EBX']
        return OutputText
    
    def LoadParameter ( self , CurrentOperand , OutputText ) :
        OperandOffset = 0
        self . CheckIfObjectInTokenValid ( CurrentOperand )
        Found, CurrentSymbol = self.CheckCurrentSTs(CurrentOperand)
        OperandOffset = CurrentSymbol.Offset
        if CurrentSymbol . IsReference == False :
            OutputText = OutputText + self . LoadValue ( CurrentSymbol )
        else :
            OutputText = OutputText + self . LoadReference ( CurrentSymbol )
        self.CurrentSTOffset = self.CurrentSTOffset + -self.POINTER_SIZE
        return OutputText

    def OutputParameterLoad ( self , CurrentOperand , OutputText ) :
        OutputText = OutputText + ';Loading {} {}\n'.format(CurrentOperand.Name, self . CurrentSTOffset)
        OutputText = self . LoadParameter ( CurrentOperand , OutputText )
        return OutputText

    def LoadCallingObject ( self , Object , OutputText ) :
        OutputText = OutputText + ';Loading a {} object\n'.format( Object . Type . Name )
        OutputText = self . LoadParameter ( Object , OutputText )
        return OutputText
    
    def OutputCallFunction ( self , FunctionName , OutputText , ShiftAmount ) :
        OutputText = OutputText + self.ASM_COMMANDS['CALL'] + self.SPACE + FunctionName + self.SPECIAL_CHARS['NEWLINE']
        OutputText = OutputText + self.ASM_TEXT['SHIFT_STRING'].format(ShiftAmount)
        return OutputText

    def CheckIfObjectInTokenValid ( self , Token ) :
        print ( 'testing objet' , Token . Name )
        if Token != None :
            if Token . Name . isdigit ( ) == False :
                Found , Symbol = self . CheckCurrentSTs ( Token )
                if Found == False :
                    CompilerIssue . OutputError ( 'No variable named {} found' . format ( Token . Name ) , self . EXIT_ON_ERROR , Token )
    
    def AllocateLiterals ( self , OutputText , ArrayOfOperands ) :
        ArrayIndex = 0
        for CurrentOperand in ArrayOfOperands :
            if CurrentOperand . Name . isdigit ( ) == True :
                OutputText , ArrayOfOperands = self . AllocateByteFromNumber ( CurrentOperand , OutputText , ArrayOfOperands , ArrayIndex )
            ArrayIndex = ArrayIndex + 1
        return OutputText , ArrayOfOperands
    
    def AddReturnValues ( self , TypeName , FunctionName , WordArray , Index , OutputText ) :
        for ReturnObject in self . GetTypeObjectFromNames ( TypeName , FunctionName ) . ReturnValues :
            WordArray , Index , OutputText = self . AddReturnValue ( ReturnObject , WordArray , Index , OutputText )
        return WordArray , Index , OutputText
    
    def LoadParameters ( self ,  ArrayOfOperands , OutputText ) :
        # We reverse it because the order of pushing of operands is reversed
        ReverseOperandArray = reversed ( ArrayOfOperands )
        for CurrentOperand in ReverseOperandArray :
            OutputText = self . OutputParameterLoad ( CurrentOperand , OutputText )
        return OutputText
    
    def SetTemplatesIfObjectExists ( self , Object , Default ) :
        Templates = Default
        if Object != None :
            Templates = Object . Templates
        return Templates
    
    def ResolveActionDetails ( self , Operator , Object ) :
        Type = self . GetObjectType ( Object )
        TypeName = self . GetTypeName ( Type )
        Templates = self . SetTemplatesIfObjectExists ( Object , [ ] )
        print ( 'Code: 992' , Object , Templates )
        FunctionName = self . ResolveActionToAsm ( Operator , Type , Templates )
        return Type , TypeName , FunctionName
    
    def LoadValues ( self , OutputText , ArrayOfOperands , TypeName , FunctionName , WordArray , Index , Object , Type ) :
        WordArray , Index , OutputText = self . AddReturnValues ( TypeName , FunctionName , WordArray , Index , OutputText )
        self . AfterReturnOffset = self . CurrentSTOffset
        OutputText = self . LoadParameters ( ArrayOfOperands , OutputText )
        if Type != None :
            OutputText = self . LoadCallingObject ( Object , OutputText )
        return OutputText , ArrayOfOperands , WordArray , Index
    
    def CalcFunctionCall ( self , Operator , ArrayOfOperands , Object , WordArray , Index ) :
        OutputText = ''
        Type , TypeName , FunctionName = self . ResolveActionDetails ( Operator , Object )
        OutputText , ArrayOfOperands , WordArray , Index = self . LoadValues ( OutputText , ArrayOfOperands , TypeName , FunctionName , WordArray , Index , Object , Type )
        self . PrintWordArray ( ArrayOfOperands )
        OutputText = self . OutputCallFunction ( FunctionName , OutputText , self . AfterReturnOffset - self.CurrentSTOffset )
        self . CurrentSTOffset = self . AfterReturnOffset
        return OutputText , WordArray

    def DoColonOperation ( self , Index , WordArray , OutputText ) :
        IsFunction = False
        IsSymbol = True
        IsFound , CurrentObject = self . CheckCurrentSTs ( WordArray [ Index ] )
        IsFound , TypeOfScopeIn = self . GetTypeOfScope ( WordArray [ Index ] )
        if TypeOfScopeIn == self . SCOPE_TYPES [ 'CLASS' ] :
            CurrentObject = self . GetCurrentST ( ) [ self . SELF_OBJECT_NAME ]
        self . PrintWordArray ( WordArray )
        print ( CurrentObject , WordArray [ Index ] . Name )
        CurrentClass = CurrentObject . Type
        NextToken = WordArray [ Index + 2 ]
        NextName = NextToken . Name
        for i in self . TypeTable [ CurrentClass . Name ] . InnerTypes :
            print ( 'ope' , i )
        print ( 'wer' , NextToken . Name )
        if NextToken . Name not in self . TypeTable [ CurrentClass . Name ] . InnerTypes :
            NextName = self . ResolveActionToAsm ( NextToken , CurrentClass )
        print ( 'metest' , WordArray [ Index + 2 ] , CurrentClass , CurrentClass . Name , NextName , self . TypeTable [ CurrentClass . Name ] . InnerTypes )
        ObjectTwo = self . TypeTable [ CurrentClass . Name ] . InnerTypes [ NextName ]
        if ObjectTwo . IsFunction == True :
            IsFunction = True
            IsSymbol = False
        if IsSymbol == True :
            if WordArray [ Index + 2 ] . Name in self . TypeTable [ CurrentClass . Name ] . InnerTypes :
                NewType = ObjectTwo . Type
                CurrentClass = self . TypeTable [ NewType . Name ]
                WordArray . pop ( Index )
                WordArray . pop ( Index )
                
                NewName = self.RETURN_TEMP_LETTER + str(self.ReturnTempIndex)
                NewSymbol = MySymbol(NewName, NewType)
                LeftObjectOffset = 0
                if CurrentObject . IsReference == True :
                    if CurrentObject . IsDereferenced == False :
                        OutputText = OutputText + self . LoadReference ( CurrentObject )
                        self.CurrentSTOffset = self.CurrentSTOffset + - self . POINTER_SIZE
                        NewSymbol . IsDereferenced = True
                    NewSymbol.Offset = self.CurrentSTOffset
                    NewSymbol . IsReference = True
                    NewSymbol . DereferenceOffset = CurrentObject . DereferenceOffset + ObjectTwo.Offset
                    OutputText = OutputText + ';Shifting Deref Offset{} = {} + {}\n'.format(NewSymbol . DereferenceOffset , CurrentObject . DereferenceOffset , ObjectTwo.Offset )
                    OutputText = OutputText + ';Names: {} : {} -> {}\n'.format(CurrentObject . Name , ObjectTwo . Name , ObjectTwo.Offset )
                else :
                    NewSymbol.Offset = deepcopy(CurrentObject.Offset) + deepcopy(ObjectTwo.Offset)
                
                
                OutputText = OutputText + ';ok{}\n'.format(NewSymbol . Offset)
                
                print ( self . TypeTable [ CurrentClass . Name ] . InnerTypes , CurrentClass , CurrentObject , NewType . Name , CurrentObject.Offset , ObjectTwo.Offset , 'sdaf' )
                self.GetCurrentST().Symbols[NewName] = NewSymbol
                self.ReturnTempIndex = self.ReturnTempIndex + 1
                WordArray[Index] = MyToken ( NewName , WordArray [ Index - 1 ] . LineNumber , WordArray [ Index - 1 ] . FileName )
            else :
                CompilerIssue . OutputError ( 'Class \'' + CurrentClass . Name + '\' has no variable \'' + WordArray [ Index + 2 ] . Name + '\'.' , self . EXIT_ON_ERROR , WordArray [ Index ] )
        elif IsFunction == True :
            Index = Index + 2
        return Index , WordArray , OutputText

    def DoLeftParenOperation ( self , Index , WordArray , OutputText ) :
        CallingObject = None
        self . PrintWordArray ( WordArray )
        if Index >= 2 :
            if WordArray [ Index - 1 ] . Name == self . OPERATORS [ 'COLON' ] :
                print ( 'booya' )
                IsFound , CallingObject = self . CheckCurrentSTs ( WordArray [ Index - 2 ] )
                WordArray . pop ( Index - 2 )
                WordArray . pop ( Index - 2 )
                Index = Index - 2
        ar = []
        for i in WordArray :
            ar . append ( i.Name )
        print ( len ( WordArray ) , ar , CallingObject )
        if WordArray [ Index + 3 ] . Name == self . OPERATORS [ 'RIGHT_PAREN' ] :
            if Lexer . IsValidName ( WordArray [ Index ] . Name ) == True :
                ActionName = WordArray [ Index ] . Name
                if CallingObject != None :
                    ActionName = self . ResolveActionToAsm ( WordArray [ Index ] , CallingObject . Type , CallingObject . Templates )
                    print ( 'ugg' , self . GetObjectTypeName ( CallingObject ) , ActionName , CallingObject . Name , CallingObject.Templates )
                if self . GetTypeTableFromNames ( self . GetObjectTypeName ( CallingObject ) , ActionName ) :
                    self . ParameterArray = self . ParameterArray + [ WordArray [ Index + 2 ] ]
                    OutputText , self . ParameterArray = self . AllocateLiterals ( OutputText , self . ParameterArray )
                    NewOutputText , WordArray = self . CalcFunctionCall ( WordArray [ Index ] , self . ParameterArray , CallingObject , WordArray , Index )
                    OutputText = OutputText + NewOutputText
                    self . ParameterArray = [ ]
                    self . PrintWordArray ( WordArray )
                    WordArray . pop ( Index + 1 )
                    WordArray . pop ( Index + 1 )
                    WordArray . pop ( Index + 1 )
                    Index = self . RemoveWordIndexIfNoReturn ( Index , WordArray , CallingObject , ActionName )
                else :
                    CompilerIssue . OutputError ( 'The class \'' + Object . Type . Name + '\' does not have a function \'' + WordArray [ Index + 1 ] . Name + '\'.' ,
                        self . EXIT_ON_ERROR , WordArray [ Index ] )
            else :
                self . DropParens ( Index , WordArray )
                Index = Index + 1
        else :
            Index = Index + 2
        return Index , WordArray , OutputText

    def DoCommaOperation ( self , Index , WordArray , OutputText ) :
        CallingFunction = True
        self . ParameterArray = self . ParameterArray + [ WordArray [ Index ] ]
        WordArray . pop ( Index )
        WordArray . pop ( Index )
        return Index , WordArray , OutputText
    
    def CalcRefCopy ( self , LeftRef , RightRef ) :
        OutputText = ''
        OutputText = OutputText + self . ASM_TEXT [ 'MOVE_EBX_TO_LOCATION' ] . format ( RightRef . Offset )
        if RightRef . IsReference == True :
            OutputText = OutputText + self . ASM_TEXT [ 'DEREFERENCE_EBX' ]
        OutputText = OutputText + self . ASM_TEXT [ 'EBX_TO_ECX' ]
        OutputText = OutputText + self . ASM_TEXT [ 'PLACE_ECX_AT_OFFSET' ] . format ( LeftRef . Offset )
        return OutputText

    def DoOperatorActionCall ( self , Index , WordArray , OutputText ) :
        RightOperand = WordArray [ Index + 2 ]
        self . CheckIfObjectInTokenValid ( RightOperand )
        Found , Object = self . CheckCurrentSTs ( WordArray [ Index ] )
        IsFound , TypeOfScopeIn = self . GetTypeOfScope ( WordArray [ Index ] )
        if TypeOfScopeIn == self . SCOPE_TYPES [ 'CLASS' ] :
            Object = self . GetCurrentST ( ) [ self . SELF_OBJECT_NAME ]
        for i in self . STStack :
            ar = []
            for i2 in i . Symbols :
                ar . append ( i2  )
            print ( ar )
            
        print ( Found , Object , WordArray [ Index ] . Name , len ( self . STStack ) , 'asdfwe' )
        if Found == False :
            CompilerIssue . OutputError ( 'No variable named \'' + WordArray [ Index ] . Name + '\' found in current scope.' , self . EXIT_ON_ERROR , WordArray [ Index ] )
        else :
            OutputText , ArrayOfOperands = self . AllocateLiterals ( OutputText , [ RightOperand ] )
            Found , RightRef = self . CheckCurrentSTs ( ArrayOfOperands [ 0 ] )
            if Object . ActLikeReference == True and WordArray [ Index + 1 ] . Name == self . OPERATORS [ 'EQUALS' ] :
                if Object . Type == RightRef . Type :
                    OutputText = OutputText + self . CalcRefCopy ( Object , RightRef )
                else :
                    CompilerIssue . OutputError ( 'Reference ' + Object . Name + ' is of a different type than ' + RightOperand . Name ,
                        self . EXIT_ON_ERROR , WordArray [ Index ] )
            else :
                if self . IsInTypeTable ( Object . Type . Name , self . ResolveActionToAsm ( WordArray [ Index + 1 ] , Object . Type , Object . Templates ) ) == True :
                    NewOutputText , WordArray = self . CalcFunctionCall ( WordArray [ Index + 1 ] , ArrayOfOperands , Object , WordArray , Index )
                    OutputText = OutputText + NewOutputText
                else :
                    print ( Object . Templates , WordArray [ Index ] . Name , self . TypeTable [ 'Integer' ] , self . TypeTable [ 'Integer' ] . InnerTypes , self . ResolveActionToAsm ( WordArray [ Index + 1 ] , Object . Type , Object . Templates ) )
                    CompilerIssue . OutputError ( 'The class \'' + Object . Type . Name + '\' does not have a function \'' + WordArray [ Index + 1 ] . Name + '\'.' ,
                        self . EXIT_ON_ERROR , WordArray [ Index ] )
            WordArray . pop ( Index + 1 )
            WordArray . pop ( Index + 1 )
        return Index , WordArray , OutputText
    
    def DoEmptyActionCall ( self , Index , WordArray , OutputText ) :
        CallingObject = None
        if Index >= 2 :
            if WordArray [ Index - 1 ] . Name == self . OPERATORS [ 'COLON' ] :
                IsFound , CallingObject = self . CheckCurrentSTs ( WordArray [ Index - 2 ] )
                WordArray . pop ( Index - 2 )
                WordArray . pop ( Index - 2 )
                Index = Index - 2
        ar = []
        for i in WordArray :
            ar . append ( i.Name )
        print ( len ( WordArray ) , ar )
        if WordArray [ Index + 2 ] . Name == self . OPERATORS [ 'RIGHT_PAREN' ] :
            if Lexer . IsValidName ( WordArray [ Index ] . Name ) == True :
                ActionName = WordArray [ Index ] . Name
                if CallingObject != None :
                    ActionName = self . ResolveActionToAsm ( WordArray [ Index ] , CallingObject . Type )
                if self . IsInTypeTable ( self . GetObjectTypeName ( CallingObject ) , ActionName ) :
                    self . ParameterArray = [ ]
                    OutputText , self . ParameterArray = self . AllocateLiterals ( OutputText , self . ParameterArray )
                    NewOutputText , WordArray = self . CalcFunctionCall ( WordArray [ Index ] , self . ParameterArray , CallingObject , WordArray , Index )
                    OutputText = OutputText + NewOutputText
                    print ( type ( OutputText ) , type ( NewOutputText ) )
                    self . ParameterArray = [ ]
                    WordArray . pop ( Index + 1 )
                    WordArray . pop ( Index + 1 )
                    Index = self . RemoveWordIndexIfNoReturn ( Index , WordArray , CallingObject , ActionName )
                    self . PrintWordArray ( WordArray )
                else :
                    CompilerIssue . OutputError ( 'No function named \'' + WordArray [ Index ] . Name + '\'.' ,
                        self . EXIT_ON_ERROR , WordArray [ Index ] )
            else :
                self . DropParens ( Index , WordArray )
                Index = Index + 1
        else :
            Index = Index + 2
        return Index , WordArray , OutputText
    
    def RemoveWordIndexIfNoReturn ( self , Index , WordArray , CallingObject , ActionName ) :
        Class = None
        ClassName = ''
        if CallingObject != None :
            Class = CallingObject . Type
            ClassName = Class . Name
        print ( ClassName , ActionName )
        ActionSymbol = self . GetTypeObjectFromNames ( ClassName , ActionName )
        Table = self . GetTypeTableFromNames ( ClassName , ActionName )
        print ( 'return values' , ActionSymbol . ReturnValues , Table , ActionSymbol , ActionSymbol . Name )
        if len ( ActionSymbol . ReturnValues ) == 0 :
            WordArray . pop ( Index )
        return Index
    
    def CanDropParens ( self , Index , WordArray ) :
        Output = False
        if WordArray [ Index + 3 ] == self . OPERATORS [ 'RIGHT_PAREN' ] and WordArray [ Index + 1 ] == self . OPERATORS [ 'LEFT_PAREN' ] :
            Output = True
        return Output
    
    def DropParens ( self , Index , WordArray ) :
        WordArray . pop ( Index + 3 )
        WordArray . pop ( Index + 1 )
        Index = Index + 1
    
    def IsParenAheadTwo ( self , Index , WordArray ) :
        Output = False
        if len ( WordArray ) > Index + 2 :
            if WordArray [ Index + 2 ] . Name == self . OPERATORS [ 'LEFT_PAREN' ] :
                Output = True
        return Output

    def DoOperation ( self , Index , WordArray , OutputText ) :
        if self . IsParenAheadTwo ( Index , WordArray ) == True :
            Index = Index + 1
        elif WordArray [ Index + 1 ] . Name == self . OPERATORS [ 'LEFT_PAREN' ] :
            Index , WordArray , OutputText = self . DoLeftParenOperation ( Index , WordArray , OutputText )
        elif WordArray [ Index + 1 ] . Name == self . OPERATORS [ 'COLON' ] :
            Index , WordArray , OutputText = self . DoColonOperation ( Index , WordArray , OutputText )
        elif WordArray [ Index + 1 ] . Name == self . OPERATORS [ 'RIGHT_PAREN' ] :
            Index = Index - 2
        elif WordArray [ Index + 1 ] . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
            Index , WordArray , OutputText = self . DoCommaOperation ( Index , WordArray , OutputText )
        elif WordArray [ Index + 1 ] . Name in self . OPERATORS . values ( ) :
            Index , WordArray , OutputText = self . DoOperatorActionCall ( Index , WordArray , OutputText )
        else :
            CompilerIssue . OutputError ( 'Could not reduce \'' + WordArray [ Index + 1 ] . Name + '\'.' , self . EXIT_ON_ERROR , TokenObject )
        return OutputText , Index , WordArray
    
    def IsRightParenNext ( self , Index , WordArray ) :
        Output = False
        if WordArray [ Index + 1 ] . Name == self . OPERATORS [ 'RIGHT_PAREN' ] :
            Output = True
        return Output
    
    def IsParensWithEmpty ( self , Index , WordArray ) :
        Output = False
        if WordArray [ Index + 1 ] . Name == self . OPERATORS [ 'LEFT_PAREN' ] and WordArray [ Index + 2 ] . Name == self . OPERATORS [ 'RIGHT_PAREN' ] :
            Output = True
        print ( 'wersdf' , WordArray [ Index + 1 ] . Name , WordArray [ Index + 2 ] . Name , Output )
        return Output
    
    def FunctionCallParen ( self , Index , WordArray ) :
        Output = False
        if len ( WordArray ) - Index >= 4 :
            if Lexer . IsValidName ( WordArray [ Index + 2 ] . Name ) == True and WordArray [ Index + 3 ] . Name == self . OPERATORS [ 'LEFT_PAREN' ] :
                Output = True
        return Output

    def Reduce ( self , Token , SavedWordArray , OutputText , IsInIf ) :
        WordIndex = 0
        CurrentClass = None
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
            print ('testng' , Token1 . Name , Token2 . Name , Token3 . Name , Token4 . Name , Token5 . Name , type ( OutputText ) )
            self . PrintWordArray ( SavedWordArray )
            self . PrintWordArray ( self . ParameterArray )
            if self . IsParenAheadTwo ( WordIndex , SavedWordArray ) == True :
                WordIndex = WordIndex + 1
            elif self . IsRightParenNext ( WordIndex , SavedWordArray ) == True :
                WordIndex = WordIndex - 2
            elif self . FunctionCallParen ( WordIndex , SavedWordArray ) == True :
                WordIndex = WordIndex + 2
            elif self . IsParensWithEmpty ( WordIndex , SavedWordArray ) == True :
                WordIndex , SavedWordArray , OutputText = self . DoEmptyActionCall ( WordIndex , SavedWordArray , OutputText )
            elif self . OpOneHighestPrecedence ( Token2 , Token4 ) :
                OutputText , WordIndex ,  SavedWordArray = self . DoOperation ( WordIndex , SavedWordArray , OutputText )
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
            elif self . GetTypeTableFromNames ( Expr
            else :
                CompilerIssue . OutputError ( '\'end\' found when not in any upper scope' , self . EXIT_ON_ERROR , TokenObject )'''
        return OutputText
    
    
    def DoActionOnStartOfLine ( self ) :
        self . State = self . MAIN_STATES [ 'ACTION_AFTER' ]
        self . SavedFunctionCodeType = self . FUNCTION_TYPES [ 'NORMAL' ]
        self . CurrentSTOffset = deepcopy ( self . ACTION_DECLARATION_OFFSET )
        self . CurrentParamOffset = deepcopy ( self . ACTION_DECLARATION_PARAM_OFFSET )
        self . ActionTypeDeclared = False
        self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'ACTION' ] , self . CurrentSTOffset ) )


    def ProcessStartOfLine ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        print ( Token . Name )
        if Token . Name == self . KEYWORDS [ 'USING' ] :
            self . State = self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ]
        elif Token . Name == self . KEYWORDS [ 'CLASS' ] :
            self . State = self . MAIN_STATES [ 'CLASS_AFTER' ]
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'CLASS' ] , self . CurrentSTOffset ) )
        elif Token . Name == self . KEYWORDS [ 'ACTION' ] :
            self . DoActionOnStartOfLine ( )
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
                OutputText = self . CalcActionReturnOutput ( OutputText , self . CurrentFunction )
                self . CurrentFunction = None
                NewCodeFunction = CodeFunction ( OutputText )
                self . CodeArray . append ( NewCodeFunction )
                OutputText = deepcopy ( self . EMPTY_STRING )
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
        elif Token . Name == self . KEYWORDS [ 'RETURN' ] :
            OutputText , SavedWordArray , WordIndex = self . DoReturnStatement ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . CurrentFunction != None and self . CurrentFunction . TypeOfCode == self . FUNCTION_TYPES [ 'ASM' ] :
            Token = self . PossibleTemplateASMReplace ( Token , WordIndex , SavedWordArray )
            OutputText = OutputText + Token . Name
        elif Lexer . IsValidName ( Token . Name ) == True :
            Found , OutSymbol = self . CheckCurrentSTs ( Token )
            if self . IsCurrentlyValidType ( Token ) == True :
                Token , WordIndex , SavedWordArray = self . PossibleTemplateConvert ( Token , WordIndex , SavedWordArray )
                if self . TypeTable [ Token . Name ] . IsFunction == False :
                    self . SavedType = self . TypeTable [ Token . Name ]
                    self . State = self . MAIN_STATES [ 'DECLARING_VARIABLE' ]
                else :
                    Found = self . CheckCurrentSTs ( Token )
                    LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                    OutputText = self . Reduce ( Token , LineWordArray , OutputText , False )
            elif Found == True :
                Found , OutSymbol = self . CheckCurrentSTs ( Token )
                LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                OutputText = self . Reduce ( Token . Name , LineWordArray , OutputText , False )
            else :
                CompilerIssue . OutputError ( 'Type or symbol \'' + Token . Name + '\' not found' , self . EXIT_ON_ERROR , Token )
        else :
            print ( 'screw up' , Token . Name )
        return SavedWordArray , WordIndex , OutputText
    
    def PossibleTemplateASMReplace ( self , Token , Index , WordArray ) :
        if self . IsSavedTemplatesExisting ( ) == True :
            Token = self . DoAsmTemplateReplace ( Token , Index , WordArray )
        return Token
    
    def DoAsmTemplateReplace ( self , Token , Index , WordArray ) :
        StartPosition = 0
        for Item in self . ASM_REPLACE_STRINGS :
            FoundPosition = Token . Name . find ( Item , StartPosition )
            while FoundPosition != Lexer . FIND_NOT_FOUND :
                AfterNamePosition = FoundPosition + len ( Item )
                LeftParenPosition = self . GoUntilNotWhiteSpace ( Token . Name , AfterNamePosition )
                print ( 'Code: 993' , FoundPosition , AfterNamePosition , LeftParenPosition )
                self . AsmNextCheck ( LeftParenPosition , Item , Token )
                self . AsmLetterCheck ( Token . Name [ LeftParenPosition ] , self .  OPERATORS [ 'LEFT_PAREN' ] , Item , Token )
                NameStartPosition = LeftParenPosition + 1
                NameEndPosition = self . GetNameEndPosition ( Token . Name , NameStartPosition )
                RightParenPosition = self . GoUntilNotWhiteSpace ( Token . Name , NameEndPosition )
                self . AsmNextCheck ( RightParenPosition , Item , Token )
                self . AsmLetterCheck ( Token . Name [ RightParenPosition ] , self .  OPERATORS [ 'RIGHT_PAREN' ] , Item , Token )
                TypeName = Token . Name [ NameStartPosition : NameEndPosition ]
                ResultString = self . CalcNewAsmString ( Item , TypeName , Token , Index , WordArray )
                Token . Name = Token . Name [ 0 : FoundPosition ] + ResultString + Token . Name [ RightParenPosition + 1 : ]
                StartPosition = FoundPosition + 1
                FoundPosition = Token . Name . find ( Item , StartPosition )
            StartPosition = 0
        return Token
    
    def CalcNewAsmString ( self , FunctionName , TypeName , Token , Index , WordArray ) :
        ResultString = ''
        if FunctionName == self . KEYWORDS [ 'SIZE_OF' ] :
            TypeName = self . PossibleTemplateConvertFromName ( TypeName , Token , Index , WordArray )
            print ( 'Code: 991' , TypeName , FunctionName )
            Type = self . GetTypeObjectFromNames ( TypeName , '' )
            ResultString = str ( Type . Size )
        elif FunctionName == self . KEYWORDS [ 'GET_CLASS_NAME' ] :
            TypeName = self . PossibleTemplateConvertFromName ( TypeName , Token , Index , WordArray )
            ResultString = TypeName
        elif FunctionName == self . KEYWORDS [ 'GET_RESOLVED_CLASS_NAME' ] :
            TypeName = self . PossibleTemplateConvertFromName ( TypeName , Token , Index , WordArray )
            ResultString = self . GetResolvedClassName ( TypeName , [] )
        return ResultString
    
    def GetNameEndPosition ( self , Name , StartPosition ) :
        EndPosition = StartPosition
        while Lexer . IsVariableAllowedLetter ( Name [ EndPosition ] ) == True :
            EndPosition = EndPosition + 1
        return EndPosition
    
    def GoUntilNotWhiteSpace ( self , Text , Position ) :
        while Text [ Position ]  . isspace ( ) == True :
            Position = Position + 1
            if Position >= len ( Text ) :
                Position = Lexer . FIND_NOT_FOUND
        return Position
    
    def AsmNextCheck ( self , Position , Name , Token ) :
        if Position == Lexer . FIND_NOT_FOUND :
            CompilerIssue . OutputError ( 'Non-space character required next to ' + Name + ' in assembly code.' , self . EXIT_ON_ERROR , Token )
    
    def AsmLetterCheck ( self , Letter , TestLetter , Name , Token ) :
        if Letter != TestLetter :
            CompilerIssue . OutputError ( 'Expected ' + TestLetter + ' found ' + Letter + ' next to ' + Name + ' in assembly code.' , self . EXIT_ON_ERROR , Token )
    
    def PossibleTemplateConvert ( self , Token , Index , WordArray ) :
        Token . Name = self . PossibleTemplateConvertFromName ( Token . Name , Token , Index , WordArray )
        return Token , Index , WordArray
    
    def PossibleTemplateConvertFromName ( self , Name , Token , Index , WordArray ) :
        if self . IsValidTemplateElemName ( self . CurrentClass , Name ) == True :
            TemplateParts = Name . split ( )
            if len ( TemplateParts ) > self . NORMAL_TOKEN_SIZE :
                WordArray . insert ( Index + 1 , MyToken ( self . KEYWORDS [ 'REFERENCE' ] , Token . LineNumber , Token . FileName ) )
            Position = self . FindNameInTemplates ( self . CurrentClass , Name )
            print ( 'Code: 1000' , Position , self . CurrentClass . Name , Name , self . GetLatestSavedTemplate ( ) , self . SavedTemplates )
            Name = self . GetLatestSavedTemplate ( ) [ Position ]
            print ( 'te' , Name )
        return Name
    
    def IsValidTemplateElem ( self , Class , Token ) :
        Output = self . IsValidTemplateElemName ( Class , Token . Name )
        return Output
    
    def IsValidTemplateElemName ( self , Class , Name ) :
        Output = False
        if Class != None :
            if self . HasTemplates ( self . CurrentClass ) == True :
                if Name in self . CurrentClass . Templates :
                    Output = True
        return Output
    
    def IsCurrentlyValidType ( self , Token ) :
        Output = False
        if Token . Name in self . TypeTable :
            Output = True
        if self . IsValidTemplateElem ( self . CurrentClass , Token ) == True :
            Output = True
        return Output
            
    
    def GetSizeOfSymbol ( self , TestSymbol ) :
        Size = TestSymbol . Type . Size
        if TestSymbol . IsReference == True :
            Size = self . POINTER_SIZE
        return Size
            
    
    def SumUpParameterSizes ( self , CurrentClass , CurrentFunction ) :
        Sum = 0
        if CurrentClass != None :
            Sum = Sum + self . POINTER_SIZE
        for Param in self . CurrentFunction . Parameters :
            self . GetSizeOfSymbol ( Param )
            Sum = Sum + self . GetSizeOfSymbol ( Param )
        return Sum
    
    def DoReturnStatement ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        PrevIndex = WordIndex
        LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex + 1 )
        OutputText = self . Reduce ( Token , LineWordArray , OutputText , True )
        Found , RetObject = self . CheckCurrentSTs ( SavedWordArray [ PrevIndex + 1 ] )
        DestinationOffset = self . ACTION_DECLARATION_PARAM_OFFSET + self . SumUpParameterSizes ( self . CurrentClass , self . CurrentFunction )
        OutputText = OutputText + self . ASM_TEXT [ 'LOAD_TEXT' ] . format ( RetObject . Offset )
        OutputText = OutputText + self . ASM_TEXT [ 'LOAD_TEXT' ] . format ( DestinationOffset )
        self . CurrentSTOffset = self . CurrentSTOffset - self . POINTER_SIZE
        ActionName = self . ResolveActionNameToAsm ( self . OPERATORS [ 'EQUALS' ] , RetObject . Type )
        OutputText = self . OutputCallFunction ( ActionName , OutputText , self . AfterReturnOffset - self.CurrentSTOffset )
        return OutputText , SavedWordArray , WordIndex
        

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
    
    def AddVariableToTemplateLine ( self , SavedWordArray , WordIndex , LatestTemplate , ClassName ) :
        NewName = self.TEMPLATE_VARIABLE_BEGIN + str(self.TemplateTempIndex)
        NewSymbol = MySymbol(NewName, self . TypeTable [ ClassName ] )
        NewSymbol . Templates = LatestTemplate
        self.GetCurrentST().Symbols[NewName] = NewSymbol
        self . TemplateTempIndex = self . TemplateTempIndex + 1
        SavedWordArray [ WordIndex ] = NewSymbol
        return SavedWordArray , WordIndex
    
    def ConvertTemplatesToStructure ( self , Templates , ClassName , SavedWordArray , WordIndex ) :
        self . TypeTable [ ClassName ] . Templates . append ( [ ] )
        LatestTemplate = self . TypeTable [ ClassName ] . Templates [ len ( self . TypeTable [ ClassName ] . Templates ) - 1 ]
        LatestTemplate = [ None ] * len ( Templates )
        for Index in range ( len ( Templates ) ) :
            T = Templates [ Index ]
            Found , OutSymbol = self . CheckCurrentSTsByName ( T )
            if Found == True :
                LatestTemplate [ Index ] = MySymbol ( T , OutSymbol . Type )
                LatestTemplate [ Index ] . Templates = OutSymbol . Templates
            else :
                LatestTemplate [ Index ] = MySymbol ( T , self . TypeTable [ T ] )
                LatestTemplate [ Index ] . Templates = None
            Index = Index + 1
        print('PARSING TEMPLATED CLASS: ', ClassName, 'with', Templates)
        self . SavedTemplates . append ( LatestTemplate )
        self . CompileTemplatedClass ( self . TypeTable [ ClassName ] )
        print('ENDPARSE TEMPLATED CLASS: ', ClassName, 'with', Templates)
        SavedWordArray , WordIndex = self . AddVariableToTemplateLine ( SavedWordArray , WordIndex , LatestTemplate , ClassName )
        return SavedWordArray , WordIndex
                
    
    def TemplateEndReduce ( self , SavedWordArray , WordIndex ) :
        print ( 'safd' )
        OnToken = SavedWordArray [ WordIndex ]
        BeforeToken = SavedWordArray [ WordIndex - 1 ]
        if OnToken . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
            self . TempSavedTemplate . append ( OnToken . Name )
            SavedWordArray . pop ( WordIndex )
            SavedWordArray . pop ( WordIndex )
        elif BeforeToken . Name == self . SPECIAL_CHARS [ 'TEMPLATE_START' ] :
            self . TempSavedTemplate . append ( OnToken . Name )
            WordIndex = WordIndex - 2
            ClassToken = SavedWordArray [ WordIndex ]
            SavedWordArray . pop ( WordIndex )
            SavedWordArray . pop ( WordIndex )
            SavedWordArray . pop ( WordIndex )
            SavedWordArray , WordIndex = self . ConvertTemplatesToStructure ( self . TempSavedTemplate , ClassToken . Name , SavedWordArray , WordIndex )
            self . TempSavedTemplate = [ ]
        return SavedWordArray , WordIndex
    
    def TemplateReduce ( self , SavedWordArray ) :
        WordIndex = 0
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
            self . PrintWordArray ( SavedWordArray )
            print ( WordIndex )
            print (  Token2 . Name , self . SPECIAL_CHARS [ 'TEMPLATE_END' ])
            if Token2 . Name == self . SPECIAL_CHARS [ 'TEMPLATE_END' ] :
                SavedWordArray , WordIndex = self . TemplateEndReduce ( SavedWordArray , WordIndex )
            else :
                WordIndex = WordIndex + 2

            if len ( SavedWordArray ) - WordIndex < 2 :
                WordIndex = WordIndex - 2
        return SavedWordArray
    
    def PopLastElement ( self , NewWordArray ) :
        NewWordArray . pop ( len ( NewWordArray ) - 1 )
        return NewWordArray

    def ProcessDeclaringVariable ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        Found , OutSymbol = self . CheckCurrentSTs ( self . SavedType )
        if Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_START' ] :
            print ( 'were' , SavedWordArray [ WordIndex ] . Name , SavedWordArray [ WordIndex + 1 ] . Name , SavedWordArray [ WordIndex + 2 ] . Name )
            WordIndex = WordIndex - 1
            NewWordArray , NewWordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
            NewWordArray = self . PopLastElement ( NewWordArray )
            ResultArray = self . TemplateReduce ( NewWordArray )
            print ( 'were' , SavedWordArray [ WordIndex ] . Name , SavedWordArray [ WordIndex + 1 ] . Name , SavedWordArray [ WordIndex + 2 ] . Name , ResultArray )
            FirstWordArray = SavedWordArray [ 0 : WordIndex ]
            SecondWordArray = SavedWordArray [ NewWordIndex - 1 : len ( SavedWordArray ) ]
            SavedWordArray = FirstWordArray + ResultArray + SecondWordArray
            print ( 'were2' , SavedWordArray [ WordIndex ] . Name , SavedWordArray [ WordIndex + 1 ] . Name , SavedWordArray [ WordIndex + 2 ] . Name , SavedWordArray [ WordIndex + 3 ] . Name , SavedWordArray [ WordIndex + 4 ] . Name )
        elif self . SavedType . Name in self . TypeTable or Found == True :
            if Token . Name not in self . GetCurrentST ( ) . Symbols :
                if Token . Name == self . KEYWORDS [ 'REFERENCE' ] :
                    if self . CurrentlyReference == False :
                        self . CurrentlyReference = True
                    else :
                        CompilerIssue . OutputError ( 'References to references are not allowed.' , self . EXIT_ON_ERROR , Token )
                else :
                    NewSymbol = MySymbol ( Token . Name , self . TypeTable [ self . SavedType . Name ] )
                    if Found == True :
                        NewSymbol . Type = OutSymbol . Type
                        NewSymbol . Templates = OutSymbol . Templates
                    AddSize = self . TypeTable [ self . SavedType . Name ] . Size
                    NewSymbol . Templates = deepcopy ( self . TempSavedTemplate )
                    print ( 'Code: 1233' , NewSymbol . Name , NewSymbol . Templates , self . SavedTemplates )
                    if self . CurrentlyReference == True :
                        NewSymbol . ActLikeReference = True
                        NewSymbol . IsReference = True
                        AddSize = self . POINTER_SIZE
                    if self . CurrentClass != None and self . CurrentFunction == None :
                        self . TypeTable [ self . CurrentClass . Name ] . Size = self . TypeTable [ self . CurrentClass . Name ] . Size +\
                            AddSize
                        NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                        self . TypeTable [ self . CurrentClass . Name ] . InnerTypes [ Token . Name ] = NewSymbol
                        self . CurrentSTOffset = self . CurrentSTOffset + AddSize
                        self . GetCurrentST ( ) . Symbols [ Token . Name ] = NewSymbol
                    else :
                        self . CurrentSTOffset = self . CurrentSTOffset - AddSize
                        NewSymbol . Offset = deepcopy ( self . CurrentSTOffset )
                        self . GetCurrentST ( ) . Symbols [ Token . Name ] = NewSymbol
                        OutputText = OutputText + ';Declaring {} {}\n' . format ( Token . Name , self . CurrentSTOffset )
                        print ( self . TypeTable , '\n\n\n\n\n' , self . SavedType . Name , Token . Name )
                        OutputText = self . CalcDeclarationOutput ( NewSymbol , self . CurrentlyReference , OutputText )
                        LineWordArray , WordIndex = self . GetUntilNewline ( SavedWordArray , WordIndex )
                        OutputText = self . Reduce ( Token , LineWordArray , OutputText , False )
                    self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
                    self . CurrentlyReference = False
                self . TempSavedTemplate = [ ]
            else :
                CompilerIssue . OutputError ( 'A variable named ' + Token . Name + ' has already been declared' , self . EXIT_ON_ERROR , Token )
        else :
            CompilerIssue . OutputError ( 'The type \'' + self . SavedType . Name + '\' is not currently a declared type and is not template start ' , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText
    
    def RemoveSavedTemplatesIfExist ( self ) :
        if len ( self . SavedTemplates ) > 0 :
            self . SavedTemplates . pop ( )
        
    def AppendToSavedTemplates ( self , Templates = [ ] ) :
        self . SavedTemplates . append ( Templates )

    def ProcessAfterDeclaringVariable ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        else :
            CompilerIssue . OutputError ( 'Expected newline encountered \'' + Token . Name + '\'' , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText
    
    # The template functions with "class" in the name are for instantiating templates, like Array<Letter>
    def ProcessMakingTemplate ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Lexer . IsValidName ( Token . Name ) == True :
            if Token . Name in self . TypeTable :
                if self . TypeTable [ Token . Name ] . IsFunction == False :
                    self . State = self . MAIN_STATES [ 'AFTER_TEMPLATE_NAME' ]
                    self . TempSavedTemplate . append ( Token . Name )
                else :
                   CompilerIssue . OutputError ( 'Template type \'' + Token . Name + '\' was found to be a function not class', self . EXIT_ON_ERROR , TokenObject )
            else :
                CompilerIssue . OutputError ( 'Template type \'' + Token . Name + '\' not found in type table', self . EXIT_ON_ERROR , Token )
        else :
            CompilerIssue . OutputError ( 'Expected valid type for template instead of \'' + Token + '\'', self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessAfterTemplateName ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
            self . State = self . MAIN_STATES [ 'MAKING_TEMPLATE' ]
        elif Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_END' ] :
            print ( 'Code: 1232' , self . SavedTemplates )
            self . CompileTemplatedClass ( self . SavedType )
            print ( 'Code: 1231' , self . SavedTemplates )
            self . State = self . MAIN_STATES [ 'DECLARING_VARIABLE' ]
        elif Token . Name == self . KEYWORDS [ 'REFERENCE' ] :
            self . SetLatestTempSavedTemplateToReference ( )
        else :
            CompilerIssue . OutputError ( 'Expected \'' + self . SPECIAL_CHARS [ 'COMMA' ] + '\' or \'' +
                self . SPECIAL_CHARS [ 'TEMPLATE_END' ] + '\' instead of \'' + Token . Name + '\'' , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText
    
    def SetLatestTempSavedTemplateToReference ( self ) :
        Element = self . GetLatestTempSavedTemplateElement ( )
        Element = Element + self . SPACE + self . KEYWORDS [ 'REFERENCE' ]
    
    def GetLatestTempSavedTemplateElement ( self ) :
        Element = None
        if len ( self . TempSavedTemplate ) > 0 :
            Element = self . TempSavedTemplate [ len ( self . TempSavedTemplate ) - 1 ]
        return Element

    def ProcessClassAfter ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Lexer . IsValidName ( Token . Name ) == False :
            CompilerIssue . OutputError ( Token . Name + ' is in the wrong format for a class name' , self . EXIT_ON_ERROR , Token )
        else :
            if self . IsInTypeTable ( Token . Name , '' ) == True :
                CompilerIssue . OutputError ( 'There is already a class named \'' + Token . Name + '\'.' , self . EXIT_ON_ERROR , Token )
            else :
                self . TypeTable [ Token . Name ] = Type ( Token . Name )
                self . CurrentClass = self . TypeTable [ Token . Name ]
                self . State = self . MAIN_STATES [ 'CLASS_AFTER_NAME' ]
                self . CurrentSTOffset = self . CLASS_DECLARATION_OFFSET
                print ( 'declaring' , Token . Name )
        return SavedWordArray , WordIndex , OutputText

    def ProcessClassAfterName ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        elif Token . Name == self . KEYWORDS [ 'SIZE' ] :
            self . State = self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ]
        elif Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_START' ] :
            self . State = self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ]
        else :
            CompilerIssue . OutputError ( 'Expected \'' + self . KEYWORDS [ 'SIZE' ] + '\' or newline or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_START' ] + '\'' , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText

    def ProcessClassMakingTemplate ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Lexer . IsValidName ( Token . Name ) == False :
            CompilerIssue . OutputError ( Token + ' is in the wrong format for a template name' , self . EXIT_ON_ERROR , TokenObject )
        else :
            Table = self . GetTypeObject ( self . CurrentClass , self . CurrentFunction )
            Table . Templates . append ( Token . Name )
            self . State = self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATE_NAME' ]
        return SavedWordArray , WordIndex , OutputText

    def ProcessClassAfterTemplateName ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
            self . State = self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ]
        elif Token . Name == self . SPECIAL_CHARS [ 'TEMPLATE_END' ] :
            self . State = self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATES' ]
        else :
            CompilerIssue . OutputError ( 'Expected \'' + self . SPECIAL_CHARS [ 'COMMA' ] + '\' or \'' + self . SPECIAL_CHARS [ 'TEMPLATE_END' ] + '\'.'  , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessClassAfterTemplates ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            if self . HasTemplates ( self . GetInnerMostObject ( ) ) == True :
                self . State = self . MAIN_STATES [ 'TEMPLATED_CODE' ]
            else :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        elif Token . Name == self . KEYWORDS [ 'SIZE' ] :
            self . State = self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ]
        else :
            CompilerIssue . OutputError ( 'Expected \'' + self . KEYWORDS [ 'SIZE' ] + '\' or newline' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessClassDeclaringSize ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name . isdigit ( ) == True :
            self . CurrentClass . Size = int ( Token . Name )
            self . State = self . MAIN_STATES [ 'CLASS_AFTER_DECLARING_SIZE' ]
        else :
            CompilerIssue . OutputError ( 'Expected number to go after' + self . KEYWORDS [ 'SIZE' ] , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText
    
    def HasTemplates ( self , Object ) :
        Output = False
        if Object . Templates != None :
            if len ( Object . Templates ) > 0 :
                Output = True
        return Output
    
    def GetInnerMostObject ( self ) :
        Object = self . GetTypeObject ( self . CurrentClass , self . CurrentFunction )
        return Object

    def ProcessClassAfterDeclaringSize ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            if self . HasTemplates ( self . GetInnerMostObject ( ) ) == True :
                self . State = self . MAIN_STATES [ 'TEMPLATED_CODE' ]
            else :
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        else :
            CompilerIssue . OutputError ( 'Expected newline after declaring class size' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText
    
    def AddSelfParameterToCurrentFunction ( self ) :
        SelfSymbol = MySymbol ( self . SELF_OBJECT_NAME , self . CurrentClass )
        SelfSymbol . Templates = self . GetLatestSavedTemplate ( )
        SelfSymbol . Offset = self . CurrentParamOffset
        SelfSymbol . IsReference = True
        self . GetCurrentST ( ) . Symbols [ self . SELF_OBJECT_NAME ] = SelfSymbol
        self . CurrentTypeTable ( ) . append ( SelfSymbol )
        self . CurrentParamOffset = self . CurrentParamOffset + self . POINTER_SIZE

    def ProcessActionAfter ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . KEYWORDS [ 'ASM' ] :
            if self . ActionTypeDeclared == True :
                CompilerIssue . OutputError ( '\'' + self . KEYWORDS [ 'ASM' ] + '\' declared twice on function' , self . EXIT_ON_ERROR , TokenObject )
            else :
                self . SavedFunctionCodeType = self . FUNCTION_TYPES [ 'ASM' ]
                self . ActionTypeDeclared = True
        elif Token . Name == self . KEYWORDS [ 'NORMAL' ] :
            if self . ActionTypeDeclared == True :
                CompilerIssue . OutputError ( '\'' + self . KEYWORDS [ 'NORMAL' ] + '\' declared twice on function' , self . EXIT_ON_ERROR , TokenObject )
            else :
                self . SavedFunctionCodeType = self . FUNCTION_TYPES [ 'NORMAL' ]
                self . ActionTypeDeclared = True
        elif Lexer . IsValidName ( Token . Name ) == True :
            if self . CurrentClass != None :
                if Token . Name == self . KEYWORDS [ 'ON' ] :
                    self . State = self . MAIN_STATES [ 'ACTION_AFTER_ON' ]
                else :
                    Found , OutSymbol = self . CheckCurrentSTs ( Token )
                    ActionName = self . ResolveActionToAsm ( Token , self . CurrentClass )
                    if ActionName in self . CurrentTypeTable ( ) :
                        if self . CurrentClass != None :
                            CompilerIssue . OutputError ( self . CurrentClass . Type + ' already has a action named ' + Token . Name , self . EXIT_ON_ERROR , Token )
                    else :
                        self . CurrentTypeTable ( ) [ ActionName ] = Function ( ActionName )
                        self . CurrentFunction = self . CurrentTypeTable ( ) [ ActionName ]
                        self . CurrentFunction . Templates = self . CurrentFunction . Templates + self . CurrentClass . Templates
                        self . CurrentFunction . TypeOfCode = self . SavedFunctionCodeType
                        self . AddSelfParameterToCurrentFunction ( )
                        self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
            else :
                Found , OutSymbol = self . CheckCurrentSTs ( Token )
                ActionName = self . ResolveActionToAsm ( Token , self . CurrentClass )
                if ActionName in self . CurrentTypeTable ( ) :
                    CompilerIssue . OutputError ( self . CurrentClass . Name + ' already has a action named ' + Token . Name , self . EXIT_ON_ERROR , TokenObject )
                else :
                    self . CurrentFunction = Function ( ActionName )
                    self . CurrentFunction . TypeOfCode = self . SavedFunctionCodeType
                    self . TypeTable [ ActionName ] = self . CurrentFunction
                    self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
        else :
            CompilerIssue . OutputError ( Token + ' is in the wrong format for a method name' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessActionAfterOn ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if self . CanResolveSymbolAction ( Token ) :
            if self . ResolveActionToAsm ( Token , self . CurrentClass ) in self . CurrentTypeTable ( ) :
                CompilerIssue . OutputError ( self . CurrentClass . Name + ' has already overloaded operator \'' + Token . Name + '\'' , self . EXIT_ON_ERROR , Token )
            else :
                Name = self . ResolveActionToAsm ( Token , self . CurrentClass )
                self . CurrentFunction = Function ( Name )
                self . CurrentFunction . TypeOfCode = self . SavedFunctionCodeType
                self . TypeTable [ self . CurrentClass . Name ] . InnerTypes [ self . CurrentFunction . Name ] = self . CurrentFunction
                self . CurrentFunction . Templates = self . CurrentFunction . Templates + self . CurrentClass . Templates
                self . AddSelfParameterToCurrentFunction ( )
                self . State = self . MAIN_STATES [ 'ACTION_AFTER_NAME' ]
        else :
            CompilerIssue . OutputError ( 'Cannot overload operator \'' + Token + '\'' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessActionAfterName ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'LEFT_PAREN' ] :
            self . State = self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ]
        elif Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            OutputText = self . OutputFunctionDeclarationEnd ( OutputText )
        else :
            CompilerIssue . OutputError ( 'Expected left paren or newline in action declaration' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessActionNewParameter ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Lexer . IsValidName ( Token . Name ) :
            if self . IsCurrentlyValidType ( Token ) == True :
                Token , WordIndex , SavedWordArray = self . PossibleTemplateConvert ( Token , WordIndex , SavedWordArray )
                print('fire', Token.Name, Token, SavedWordArray[WordIndex-1].Name, SavedWordArray[WordIndex].Name, SavedWordArray[WordIndex+3].Name)
                for i in range(10):
                    print(SavedWordArray[WordIndex+i-5].Name)
                if isinstance(Token.Name, str) == False:
                    print('fire2', Token.Name.Name, SavedWordArray[WordIndex+1].Name)
                self . SavedType = self . TypeTable [ Token . Name ]
                self . State = self . MAIN_STATES [ 'ACTION_PARAM_NAME' ]
            else :
                CompilerIssue . OutputError ( 'Unknown type \'' + Token . Name + '\'' , self . EXIT_ON_ERROR , Token )
        elif Token . Name == self . SPECIAL_CHARS [ 'RIGHT_PAREN' ] :
            self . State = self . MAIN_STATES [ 'ACTION_AT_END' ]
        else :
            CompilerIssue . OutputError ( 'Expected variable or right paren in action declaration' , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText

    def ProcessActionParamName ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Lexer . IsValidName ( Token . Name ) :
            if Token . Name in self . CurrentTypeTable ( ) :
                CompilerIssue . OutputError ( 'There is already a \'' + Token . Name + '\' in the current scope' , self . EXIT_ON_ERROR , Token )
            else :
                if Token . Name == self . KEYWORDS [ 'REFERENCE' ] :
                    self . CurrentlyReference = True
                else :
                    NewSymbol = MySymbol ( Token . Name , self . SavedType )
                    NewSymbol . ActLikeReference = True
                    NewSymbol . IsReference = True
                    if self . CurrentlyReference == True :
                        NewSymbol . ActLikeReference = True
                    NewSymbol . Offset = deepcopy ( self . CurrentParamOffset )
                    self . GetCurrentST ( ) . Symbols [ Token . Name ] = NewSymbol
                    self . CurrentTypeTable ( ) . append ( NewSymbol )
                    self . CurrentParamOffset = self . CurrentParamOffset + self . POINTER_SIZE
                    print ( self . GetCurrentST ( ) . Symbols [ Token . Name ] . IsReference , Token . Name , self . CurrentFunction . Name , 'weoisfeife' )
                    self . CurrentlyReference = False
                    self . State = self . MAIN_STATES [ 'ACTION_AFTER_PARAM' ]
        else :
            CompilerIssue . OutputError ( 'Invalid variable name in action declaration' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessActionAfterParam ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'COMMA' ] :
            self . State = self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ]
        elif Token . Name == self . SPECIAL_CHARS [ 'RIGHT_PAREN' ] :
            self . State = self . MAIN_STATES [ 'ACTION_AT_END' ]
        return SavedWordArray , WordIndex , OutputText

    def ProcessActionAtEnd ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            OutputText = self . OutputFunctionDeclarationEnd ( OutputText )
        elif Token . Name == self . KEYWORDS [ 'RETURNS' ] :
            self . State = self . MAIN_STATES [ 'RETURN_WAITING_FOR_PARAM' ]
        else :
            CompilerIssue . OutputError ( 'Expected NEWLINE or ' , self . KEYWORDS [ 'RETURNS' ] , ' after action' , self . EXIT_ON_ERROR , TokenObject )
        return SavedWordArray , WordIndex , OutputText

    def ProcessReturnWaitingForParam ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if self . IsCurrentlyValidType ( Token ) == True :
            Token , WordIndex , SavedWordArray = self . PossibleTemplateConvert ( Token , WordIndex , SavedWordArray )
            CurrentClass = self . GetTypeObjectFromNames ( Token . Name , '' )
            NewSymbol = MySymbol ( deepcopy ( self . EMPTY_STRING ) , CurrentClass )
            self . CurrentSTOffset = self . CurrentSTOffset - CurrentClass . Size
            NewSymbol . Offset = deepcopy ( self . ACTION_DECLARATION_PARAM_OFFSET + self . POINTER_SIZE * len ( self . CurrentFunction . Parameters ) )
            self . GetActionReturnValues ( self . CurrentClass , self . CurrentFunction ) . append ( NewSymbol )
            self . State = self . MAIN_STATES [ 'RETURN_AT_END' ]
        else :
            CompilerIssue . OutputError ( 'The type {} is not a currently valid type' . format ( Token . Name ) , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText
    
    def OutputFunctionDeclarationEnd ( self , OutputText ) :
        self . CurrentSTOffset = deepcopy ( self . ACTION_DEFINITION_OFFSET )
        OutputText = self . OutputActionStartCode ( OutputText )
        self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        return OutputText

    def ProcessReturnAtEnd ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . SPECIAL_CHARS [ 'NEWLINE' ] :
            OutputText = self . OutputFunctionDeclarationEnd ( OutputText )
        else :
            print ( 'Code: 990' , SavedWordArray [ WordIndex ] . Name , SavedWordArray [ WordIndex - 3 ] . Name , SavedWordArray [ WordIndex - 2 ] . Name , SavedWordArray [ WordIndex - 1 ] . Name ,
                SavedWordArray [ WordIndex ] . Name , SavedWordArray [ WordIndex+ 1 ] . Name , SavedWordArray [ WordIndex + 2 ] . Name , SavedWordArray [ WordIndex + 3 ] . Name )
            print ( self . SavedTemplates )
            CompilerIssue . OutputError ( 'Expected NEWLINE after return values' , self . EXIT_ON_ERROR , Token )
        return SavedWordArray , WordIndex , OutputText

    def ProcessWaitingForOperator ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name == self . COLON :
            self . State = self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ]
        elif Token in self . ClassTypeTable ( self . SavedLeftOperand . Name ) :
            self . SavedOperator = Token
            self . State = self . MAIN_STATES [ 'WAITING_FOR_RIGHT_OPERATOR' ]
        else :
            CompilerIssue . OutputError ( 'Cound not find ' + Token + ' in ' + self . SavedLeftOperand . Name + ' which is of type '
                + self . SavedLeftOperand . Type , self . EXIT_ON_ERROR , TokenObject )
            self . State = self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ]
        return SavedWordArray , WordIndex , OutputText

    def ProcessAfterRepeat ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        if Token . Name != self . KEYWORDS [ 'WHILE' ] and Token . Name != self . KEYWORDS [ 'UNTIL' ] :
            CompilerIssue . OutputError ( 'Expected \'{}\' or \'{}\' after {}' . format ( self . KEYWORDS [ 'WHILE' ] , self . KEYWORDS [ 'UNTIL' ] , self . KEYWORDS [ 'REPEAT' ] )
                , self . EXIT_ON_ERROR , Token )
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
    
    def DoScopeSwitch ( self , Token ) :
        if Token . Name == self . KEYWORDS [ 'CLASS' ] :
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'CLASS' ] , self . CurrentSTOffset ) )
        elif Token . Name == self . KEYWORDS [ 'ACTION' ] :
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'ACTION' ] , self . CurrentSTOffset ) )
        elif Token . Name == self . KEYWORDS [ 'IF' ] :
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'IF' ] , self . CurrentSTOffset ) )
        elif Token . Name == self . KEYWORDS [ 'REPEAT' ] :
            self . STStack . append ( Scope ( self . SCOPE_TYPES [ 'REPEAT' ] , self . CurrentSTOffset , self . RoutineCounter ) )
        if Token . Name == self . KEYWORDS [ 'END' ] :
            CurrentST = self . GetCurrentST ( )
            if CurrentST . Type == self . SCOPE_TYPES [ 'CLASS' ] :
                self . CurrentClass = None
                self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
            self . STStack . pop ( len ( self . STStack ) - 1 )
    
    def ProcessTemplatedCode ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        self . CurrentClass . TemplatedCode . append ( Token )
        self . DoScopeSwitch ( Token )
        return SavedWordArray , WordIndex , OutputText
    
    def GetClassStack ( self ) :
        STStack = self . GetStartingScopeStack ( )
        STStack . append ( Scope ( self . SCOPE_TYPES [ 'CLASS' ] , 0 ) )
        return STStack
    
    def PrepareToCompileTemplatedClass ( self , TempClass ) :
        OldState = self . State
        OldScopeStack = self . STStack
        OldClass = self . CurrentClass
        OldFunction = self . CurrentFunction
        OldSTOffset = self . CurrentSTOffset
        OldSavedType = self . SavedType
        OldTempSavedTemplate = self . TempSavedTemplate
        self . TempSavedTemplate = [ ]
        self . STStack = self . GetClassStack ( )
        self . CurrentClass = TempClass
        self . CurrentFunction = None
        self . State = self . MAIN_STATES [ 'START_OF_LINE' ]
        self . CurrentSTOffset = self . CLASS_DECLARATION_OFFSET
        return OldState , OldScopeStack , OldClass , OldFunction , OldSTOffset , OldSavedType , OldTempSavedTemplate
    
    def IsSavedTemplatesExisting ( self ) :
        Output = False
        if len ( self . SavedTemplates ) > 0 :
            Output = True
        return Output
    
    def GetLatestSavedTemplate ( self ) :
        Result = [ ]
        if len ( self . SavedTemplates ) > 0 :
            Result = self . SavedTemplates [ len ( self . SavedTemplates ) - 1 ]
        return Result
    
    def GetNameWithSavedTemplates ( self , TempClass ) :
        Latest = self . GetLatestSavedTemplate ( )
        Name = TempClass . Name
        for Template in Latest :
            Name = Name + self . TEMPLATE_DELIMITER + Template
        return Name
    
    def CreateNewTemplateClass ( self , TempClass ) :
        TempClass . Name = self . GetNameWithSavedTemplates ( TempClass )
        self . TypeTable [ TempClass . Name ] = TempClass
        return TempClass
    
    def EndCompileTemplatedClass ( self , OldState , OldScopeStack , OldClass , OldFunction , OldSTOffset , OldSavedType , OldTempSavedTemplate ) :
        self . State = OldState
        self . STStack = OldScopeStack
        self . CurrentClass = OldClass
        self . CurrentFunction = OldFunction
        self . CurrentSTOffset = OldSTOffset
        self . SavedType = OldSavedType
        self . TempSavedTemplate = OldTempSavedTemplate
        self . SavedTemplates . pop ( )
    
    def CopyFunctionParametersToScope ( self , InnerType ) :
        print ( 'testing' , InnerType . Name , InnerType . Parameters )
        for Param in InnerType . Parameters :
            self . GetCurrentST ( ) . Symbols [ Param . Name ] = Param
    
    def CompileClass ( self , TempClass ) :
        OldState , OldScopeStack , OldClass , OldFunction , OldSTOffset , OldSavedType , OldTempSavedTemplate = self . PrepareToCompileTemplatedClass ( TempClass )
        self . PrintWordArray ( TempClass . TemplatedCode )
        print ( 'hit 1' )
        NewText , SavedWordArray = self . ParseTokens ( TempClass . TemplatedCode , '' )
        self . EndCompileTemplatedClass ( OldState , OldScopeStack , OldClass , OldFunction , OldSTOffset , OldSavedType , OldTempSavedTemplate )
    
    def PrintNewlines ( self , Number ) :
        for i in range ( Number ) :
            print ( '' )
    
    def CompileTemplatedClass ( self , Class ) :
        #self . TempTemplateClass = self . AdjustForTemplates ( Class , self . SavedTemplates )
        print ( 'going in' , Class . Name , self . GetLatestSavedTemplate ( ) )
        self . CompileClass ( Class )
        print ( 'going out' )
    
    def AdjustForTemplates ( self , Class , Templates ) :
        NewClass = deepcopy ( Class )
        NewClass = self . ReplaceTypes ( NewClass , Templates )
        NewClass . Size = self . RecalculateSize ( NewClass )
        return NewClass
    
    def RecalculateSize ( self , Class ) :
        Sum = 0
        for InnerType in self . GetElementsOfType ( Class ) :
            Sum = Sum + InnerType . Type . Size
        return Sum
    
    def GetElementsOfType ( self , Type ) :
        Elements = [ ]
        for ElemName in Type . InnerTypes :
            if Type . InnerTypes [ ElemName ] . IsFunction == False :
                Elements . append ( Type . InnerTypes [ ElemName ] )
        return Elements
    
    def ReplaceTypes ( self , NewClass , Templates ) :
        for Elem in self . GetElementsOfType ( NewClass ) :
            Position = self . FindInTemplates ( NewClass , Elem . Type )
            if Position >= 0 :
                NewClass . InnerTypes [ ElemName ] . Type = self . TypeTable [ Templates [ Position ] ]
                NewClass . InnerTypes [ Templates [ Position ] ] = NewClass . InnerTypes . pop ( Elem . Name )
        return NewClass
    
    def FindInTemplates ( self , Class , NewType ) :
        Position = self . FindNameInTemplates ( self , Class , NewType )
        return Position
    
    def FindNameInTemplates ( self , Class , TemplateName ) :
        Position = -1
        Index = 0
        for Template in Class . Templates :
            if Template == TemplateName :
                Position = Index
            Index = Index + 1
        return Position
    
    def IsScopeTemplated ( self , Object ) :
        Output = False
        if len ( Object . Templates ) > 0 :
            Output = True
        return Output

    def PrintParsingStatus ( self , Token ) :
        ClassName = ''
        if self . CurrentClass != None :
            ClassName = self . CurrentClass . Name
        FunctionName = ''
        if self . CurrentFunction != None :
            FunctionName = self . CurrentFunction . Name
        print ( 'Parsing ' , Token . Name , self . State , ClassName , self . CurrentFunction , len ( self . STStack ) , self . SavedLine )

    def ParseToken ( self , Token , SavedWordArray , WordIndex , OutputText ) :
        #self . PrintParsingStatus ( Token )
        if self . State == self . MAIN_STATES [ 'START_OF_LINE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessStartOfLine ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'DECLARING_VARIABLE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessDeclaringVariable ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'AFTER_DECLARING_VARIABLE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessAfterDeclaringVariable ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'MAKING_TEMPLATE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessMakingTemplate ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'AFTER_TEMPLATE_NAME' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessAfterTemplateName ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'USING_WAITING_FOR_WORD' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessUsingWaitingForWord ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'USING_AFTER_WORD' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessUsingAfterWord ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessClassAfter ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_NAME' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessClassAfterName ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_MAKING_TEMPLATE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessClassMakingTemplate ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATE_NAME' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessClassAfterTemplateName ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_TEMPLATES' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessClassAfterTemplates ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_DECLARING_SIZE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessClassDeclaringSize ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'CLASS_AFTER_DECLARING_SIZE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessClassAfterDeclaringSize ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessActionAfter ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_ON' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessActionAfterOn ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_NAME' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessActionAfterName ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'ACTION_NEW_PARAMETER' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessActionNewParameter ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'ACTION_PARAM_NAME' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessActionParamName ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'ACTION_AFTER_PARAM' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessActionAfterParam ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'ACTION_AT_END' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessActionAtEnd ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'RETURN_WAITING_FOR_PARAM' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessReturnWaitingForParam ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'RETURN_AT_END' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessReturnAtEnd ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'WAITING_FOR_OPERATOR' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessWaitingForOperator ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'AFTER_REPEAT' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessAfterRepeat ( Token , SavedWordArray , WordIndex , OutputText )
        elif self . State == self . MAIN_STATES [ 'TEMPLATED_CODE' ] :
            SavedWordArray , WordIndex , OutputText = self . ProcessTemplatedCode ( Token , SavedWordArray , WordIndex , OutputText )
        return SavedWordArray , WordIndex , OutputText
    
    def AddTemplatesToOutput ( self , Templates ) :
        Output = ''
        if Templates != None :
            for Index in range ( len ( Templates ) ) :
                Output = Output + Templates [ Index ] . Type . Name + self . FUNCTION_OUTPUT_DELIMITER
        return Output
        
    def ResolveActionNameToAsm ( self , ActionName , Class , Templates = None ) :
        Output = ''
        Output = Output + self . GetResolvedClassNameFromClass ( Class , Templates )
        Output = Output + self . ResolveActionNameToName ( ActionName , Templates )
        return Output
    
    def ResolveActionNameToName ( self , ActionName , Templates = None ) :
        Output = ''
        if ActionName in self . MAIN_METHOD_NAMES :
            Output = Output + self . MAIN_METHOD_NAMES [ ActionName ]
        else :
            Output = Output + ActionName
        return Output

    def ResolveActionToAsm ( self , Action , Class , Templates = None ) :
        Output = ''
        Output = Output + self . GetResolvedClassNameFromClass ( Class , Templates )
        Output = Output + self . ResolveActionNameToName ( Action . Name , Templates )
        return Output
    
    def GetResolvedClassNameFromClass ( self , Class , Templates = None ) :
        Output = ''
        if Class != None :
            Output = Output + self . GetResolvedClassName ( Class . Name , Templates )
        return Output
    
    def PrintSavedTemplateArray(self, Ar):
        for i in Ar:
            print(len(i))
            for r in i:
                print(r)
    
    def GetResolvedClassName ( self , ClassName , Templates = None ) :
        Output = ''
        if ClassName != None :
            Output = Output + ClassName + self . FUNCTION_OUTPUT_DELIMITER
        if Templates == None and self . IsSavedTemplatesExisting ( ) == True :
            Templates = self . GetLatestSavedTemplate ( )
        print('Code 194:' , ClassName, Templates, type(Templates) , self . GetLatestSavedTemplate ( ), len(self.SavedTemplates))
        self.PrintSavedTemplateArray(self.SavedTemplates)
        Output = Output + self . AddTemplatesToOutput ( Templates )
        return Output

    def CanResolveSymbolAction ( self , ActionSymbol ) :
        Output = True
        if ActionSymbol in self . OPERATORS and ActionSymbol in self . MAIN_METHOD_NAMES :
            Output = True
        return Output

    def CalcActionReturnOutput ( self , OutputText , Function ) :
        print ( Function )
        if Function . TypeOfCode == self . FUNCTION_TYPES [ 'NORMAL' ] :
            OutputText = OutputText + self . SPECIAL_CHARS [ 'NEWLINE' ] + self . ASM_TEXT [ 'STACK_FRAME_END' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        OutputText = OutputText + 'ret' + self . SPECIAL_CHARS [ 'NEWLINE' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        return OutputText

    def CalcFunctionName ( self , Class , Function ) :
        OutputText = ''
        OutputText = OutputText + self . ResolveActionNameToName ( Function . Name , [ ] )
        OutputText = OutputText + self . SPECIAL_CHARS [ 'COLON' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        print ( type ( Function ) )
        print ( Function )
        print ( Function . __dict__ )
        if Function . TypeOfCode == self . FUNCTION_TYPES [ 'NORMAL' ] :
            OutputText = OutputText + self . SPECIAL_CHARS [ 'NEWLINE' ] + self . ASM_TEXT [ 'STACK_FRAME_BEGIN' ] + self . SPECIAL_CHARS [ 'NEWLINE' ]
        return OutputText

    def CalcDeclarationOutput ( self , NewSymbol , IsCurrentlyReference , OutputText ) :
        NewDataSize = NewSymbol . Type . Size
        if IsCurrentlyReference == True :
            NewDataSize = self . POINTER_SIZE
        OutputText = OutputText + self . ASM_TEXT [ 'SHIFT_STRING' ] . format ( -NewDataSize ) + self . SPECIAL_CHARS [ 'NEWLINE' ]
        if IsCurrentlyReference == False :
            OutputText = OutputText + self . ASM_TEXT [ 'DEFAULT_CREATE' ] . format ( -self . POINTER_SIZE , self . CurrentSTOffset )
            print ( 'Code: 1234' , NewSymbol . Name , NewSymbol . Templates )
            OutputText = self . OutputCallFunction ( self . ResolveActionToAsm ( Function ( 'create' ) , NewSymbol . Type , NewSymbol . Templates ) , OutputText , self . POINTER_SIZE )
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

    def CheckCurrentSTs ( self , Symbol ) :
        Found = False
        OutSymbol = None
        Index = 0
        StackHeight = len ( self . STStack ) - 1
        while Found == False and Index <= StackHeight :
            if Symbol . Name in self . STStack [ StackHeight - Index ] . Symbols :
                Found = True
                OutSymbol = self . STStack [ StackHeight - Index ] . Symbols [ Symbol . Name ]
            Index = Index + 1
        return Found , OutSymbol
    
    def CheckCurrentSTsByName ( self , Name ) :
        Found = False
        OutSymbol = None
        Index = 0
        StackHeight = len ( self . STStack ) - 1
        while Found == False and Index <= StackHeight :
            if Name in self . STStack [ StackHeight - Index ] . Symbols :
                Found = True
                OutSymbol = self . STStack [ StackHeight - Index ] . Symbols [ Name ]
            Index = Index + 1
        return Found , OutSymbol
    
    def GetTypeOfScope ( self , Symbol ) :
        Found = False
        OutType = None
        Index = 0
        StackHeight = len ( self . STStack ) - 1
        while Found == False and StackHeight >= Index :
            if Symbol . Name in self . STStack [ StackHeight - Index ] . Symbols :
                Found = True
                OutType = self . STStack [ StackHeight - Index ] . Type
            Index = Index + 1
        return Found , OutType

    def CurrentTypeTable ( self ) :
        OutTable = self . TypeTable
        if self . CurrentFunction != None :
            OutTable = self . CurrentFunction . Parameters
        elif self . CurrentClass != None :
            OutTable = self . CurrentClass . InnerTypes
        return OutTable
    
    def IsInTypeTable ( self , ClassName , FunctionName ) :
        Output = False
        OutTable = self . TypeTable
        if ClassName != '' :
            if ClassName in OutTable :
                if FunctionName == '' :
                    Output = True
                OutTable = self . TypeTable [ ClassName ] . InnerTypes
        if FunctionName != '' :
            if FunctionName in OutTable :
                Output = True
        return Output

    def GetTypeTableFromNames ( self , ClassName , FunctionName ) :
        OutTable = self . TypeTable
        if ClassName != '' :
            OutTable = self . TypeTable [ ClassName ] . InnerTypes
            print ( OutTable , self . TypeTable [ ClassName ] . InnerTypes , self . TypeTable [ ClassName ] , ClassName , self . TypeTable )
        if FunctionName != '' :
            OutTable = OutTable [ FunctionName ] . Parameters
        return OutTable

    def GetTypeObjectFromNames ( self , ClassName , FunctionName ) :
        OutTable = self . TypeTable
        if ClassName != '' :
            OutTable = self . TypeTable [ ClassName ]
            if FunctionName != '' :
                OutTable = OutTable . InnerTypes [ FunctionName ]
        elif FunctionName != '' :
            OutTable = OutTable [ FunctionName ]
        return OutTable

    def GetTypeObject ( self , Class , Function ) :
        OutTable = self . TypeTable
        if Class != None :
            OutTable = self . TypeTable [ Class . Name ]
            if Function != None :
                OutTable = OutTable . InnerTypes [ Function . Name ]
        elif Function != None :
            OutTable = OutTable [ Function . Name ]
        return OutTable
    
    def GetActionReturnValues ( self , Class , Function ) :
        return Function . ReturnValues
    
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
    VARIABLE_SPECIAL_LETTERS = '_'
    
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
    SEPARATE_LETTERS = '()'
    
    FIND_NOT_FOUND = NEGATIVE_ONE
    
    TOKEN_KINDS = {
        'VARIABLE_LETTERS' : 0 ,
        'SPECIAL' : 1 ,
        'SEPARATE' : 2
    }
    
    def __init__ ( self ) :
        self . SavedWord = deepcopy ( self . SAVED_WORD_DEFAULT )
        self . SavedWordArray = deepcopy ( self . SAVED_WORD_ARRAY_DEFAULT )
        self . State = self . MAIN_STATES [ 'NORMAL' ]
        self . StartingQuotation = self . QUOTATIONS [ 0 ]
        self . LineNumber = 1
        self . FileName = ''
        self . CurrentTokenKind = None
        self . SavedTokenLineNumber = self . LineNumber
    
    def AppendWordToSavedArray ( self , Text ) :
        self . SavedWordArray . append ( MyToken ( Text , self . SavedTokenLineNumber , self . FileName ) ) 
        self . EraseSavedWord ( )
        self . SavedTokenLineNumber = self . LineNumber

    def PrintLexingState ( self , Text , State ) :
        print ('Lexing \'' + Text + '\'', 'self . State = ' + str(self.State))
    
    def ProcessAppendWord ( self , Text ) :
        #self . PrintLexingState ( Text , self . State )
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
    
    def EraseSavedWord ( self ) :
        self . SavedWord = self . SAVED_WORD_DEFAULT
    
    def IsLetterNewLine ( self , Letter ) :
        Output = False
        if Letter == self . NEWLINE :
            Output = True
        return Output
    
    def IsOkVariableStartLetter ( Letter ) :
        Output = True
        if Letter == False and Letter not in Lexer . VARIABLE_SPECIAL_LETTERS :
            Output = False
        return Output
    
    def IsValidName ( Word ) :
        Output = True
        if len ( Word ) < 1 :
            Output = False
        if Lexer . IsOkVariableStartLetter ( Word [ 0 ] ) == False :
            Output = False
        for CurrentLetter in Word :
            if Lexer . IsVariableAllowedLetter ( CurrentLetter ) == False :
                Output = False
        return Output
    
    def IsVariableAllowedLetter ( CurrentLetter ) :
        Output = False
        if CurrentLetter . isalnum ( ) == True or CurrentLetter in Lexer . VARIABLE_SPECIAL_LETTERS :
            Output = True
        return Output
    
    def DoLetterIsNewLine ( self , Letter ) :
        if self . IsSavedWordExisting ( ) == True :
            self . ProcessAppendWord ( self . SavedWord )
        self . AddCharacterToSavedWord ( Letter )
        self . ProcessAppendWord ( self . SavedWord )
    
    def SetCurrentTokenKind ( self , CurrentLetter ) :
        self . CurrentTokenKind = self . TOKEN_KINDS [ 'VARIABLE_LETTERS' ]
        if self . IsLetterSeparateLetter ( CurrentLetter ) == True :
            self . CurrentTokenKind = self . TOKEN_KINDS [ 'SEPARATE' ]
        if Lexer . IsVariableAllowedLetter ( CurrentLetter ) == False :
            self . CurrentTokenKind = self . TOKEN_KINDS [ 'SPECIAL' ]
    
    def GetTokenKind ( self , CurrentLetter ) :
        Type = self . TOKEN_KINDS [ 'VARIABLE_LETTERS' ]
        if Lexer . IsVariableAllowedLetter ( CurrentLetter ) == False  :
            if self . IsLetterSeparateLetter ( CurrentLetter ) == True :
                Type = self . TOKEN_KINDS [ 'SEPARATE' ]
            else :
                Type = self . TOKEN_KINDS [ 'SPECIAL' ]
        return Type
    
    def IsOfSameTokenKindAsSavedWord ( self , CurrentLetter ) :
        Output = False
        Kind = self . GetTokenKind ( CurrentLetter )
        if Kind == self . CurrentTokenKind :
            Output = True
        return Output
    
    def DoDefaultIfSavedWordExists ( self , CurrentLetter ) :
        IsOfSameTokenKind = self . IsOfSameTokenKindAsSavedWord ( CurrentLetter )
        if IsOfSameTokenKind == False :
            self . ProcessAppendWord ( self . SavedWord )
    
    def DoDefault ( self , CurrentLetter ) :
        if self . IsSavedWordExisting ( ) == True :
            self . DoDefaultIfSavedWordExists ( CurrentLetter )
        self . AddCharacterToSavedWord ( CurrentLetter )
        self . SetCurrentTokenKind ( CurrentLetter )
    
    def IsLetterSeparateLetter ( self , CurrentLetter ) :
        Output = False
        if CurrentLetter in self . SEPARATE_LETTERS :
            Output = True
        return Output
    
    def ProcessSeparateLetter ( self , CurrentLetter ) :
        if self . IsSavedWordExisting ( ) == True :
            self . ProcessAppendWord ( self . SavedWord )
        self . AddCharacterToSavedWord ( CurrentLetter )
        self . SetCurrentTokenKind ( CurrentLetter )

    def ProcessLetterInSetup ( self ,
        CurrentLetter ) :
        if self . IsLetterWhiteSpace ( CurrentLetter ) == True :
            self . DoLetterIsWhiteSpaceInSetup ( CurrentLetter )
        elif self . IsLetterNewLine ( CurrentLetter ) :
            self . DoLetterIsNewLine ( CurrentLetter )
            self . LineNumber = self . LineNumber + 1
        elif self . IsLetterSeparateLetter ( CurrentLetter ) :
            self . ProcessSeparateLetter ( CurrentLetter )
        else :
            self . DoDefault ( CurrentLetter )
    
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
        #for i in SavedWordArray :
        #    print ( i . Name )
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
