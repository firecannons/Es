#include "Parser.h"

string Parser::Parse(const vector<Token> & Tokens, const string & CodeFileName)
{
    Initialize(Tokens, CodeFileName);
    
    RunParse();
    
    return string("asm here ") + Tokens[0].Contents + string(" ") + OutputAsm;
}

void Parser::RunParse()
{
    GetNextToken();
    while(IsNextToken() == true)
    {
        Operate();
        GetNextToken();
    }
}    

void Parser::Initialize(const vector<Token> & Tokens, const string & CodeFileName)
{
    this->Tokens = Tokens;
    State = PARSER_STATE::START_OF_LINE;
    Position = 0;
    OutputAsm = string("");
    HasToken = false;
    SavedUsingIdents.clear();
    ScopeStack.push_back(& GlobalScope);
    CurrentCodeFileName = CodeFileName;
    CurrentFunction = NULL;
    CurrentClass.Type = NULL;
    IsAsmFunction = false;
    TemplateVariableCounter = 0;
}

void Parser::GetNextToken()
{
    if(HasToken == true)
    {
        Position = Position + 1;
    }
    else
    {
        HasToken = true;
    }
    CurrentToken = Tokens[Position];
}

bool Parser::IsNextToken()
{
    bool Output = true;
    unsigned int CheckPosition = Position;
    if(HasToken == true)
    {
        CheckPosition = CheckPosition + 1;
    }
    if(CheckPosition >= Tokens.size())
    {
        Output = false;
    }
    return Output;
}

void Parser::Operate()
{
    if(State == PARSER_STATE::START_OF_LINE)
    {
        ParseStartOfLine();
    }
    else if(State == PARSER_STATE::EXPECT_USING_IDENT)
    {
        ParseExpectUsingIdent();
    }
    else if(State == PARSER_STATE::EXPECT_USING_DOT_OR_NEWLINE)
    {
        ParseExpectUsingDotOrNewline();
    }
    else if(State == PARSER_STATE::EXPECT_CLASS_NAME)
    {
        ParseExpectClassName();
    }
    else if(State == PARSER_STATE::EXPECT_TEMPLATE_START_OR_NEWLINE_OR_SIZE)
    {
        ParseExpectTemplateStartOrNewlineOrSize();
    }
    else if(State == PARSER_STATE::EXPECT_CLASS_SIZE_NUMBER)
    {
        ParseExpectClassSizeNumber();
    }
    else if(State == PARSER_STATE::EXPECT_CLASS_TEMPLATE_NAME)
    {
        ParseExpectClassTemplateName();
    }
    else if(State == PARSER_STATE::EXPECT_CLASS_TEMPLATE_END_OR_COMMA)
    {
        ParseExpectClassTemplateEndOrComma();
    }
    else if(State == PARSER_STATE::EXPECT_CLASS_DECL_NEWLINE)
    {
        ParseExpectClassDeclNewline();
    }
    else if(State == PARSER_STATE::EXPECT_ACTION_NAME)
    {
        ParseExpectActionName();
    }
    else if(State == PARSER_STATE::EXPECT_ACTION_NAME_OR_ACTION_TYPE)
    {
        ParseExpectActionNameOrActionType();
    }
    else if(State == PARSER_STATE::EXPECT_RETURNS_OR_LPAREN_OR_NEWLINE)
    {
        ParseExpectReturnsOrLParenOrNewline();
    }
    else if(State == PARSER_STATE::EXPECT_TYPE)
    {
        ParseExpectType();
    }
    else if(State == PARSER_STATE::EXPECT_TEMPLATE_START_OR_IDENT)
    {
        ParseExpectTemplateStartOrIdent();
    }
    else if(State == PARSER_STATE::EXPECT_TEMPLATE_START_OR_NEWLINE)
    {
        ParseExpectTemplateStartOrNewline();
    }
    else if(State == PARSER_STATE::EXPECT_TOKEN_UNTIL_END)
    {
        ParseExpectTokenUntilEnd();
    }
    else if(State == PARSER_STATE::EXPECT_PARAMETER_NAME)
    {
        ParseExpectParameterName();
    }
    else if(State == PARSER_STATE::EXPECT_RETURNS_NEWLINE)
    {
        ParseExpectReturnsNewline();
    }
    else if(State == PARSER_STATE::EXPECT_NEWLINE_AFTER_END)
    {
        ParseExpectNewlineAfterEnd();
    }
    else if(State == PARSER_STATE::EXPECT_COMMA_OR_RPAREN)
    {
        ParseExpectCommaOrRParen();
    }
    else if(State == PARSER_STATE::EXPECT_NEWLINE_OR_RETURNS)
    {
        ParseExpectNewlineOrReturns();
    }
}

void Parser::ParseStartOfLine()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["USING"])
    {
        State = PARSER_STATE::EXPECT_USING_IDENT;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["CLASS"])
    {
        if(CurrentClass.Type != NULL)
        {
            OutputStandardErrorMessage(string("Cannot create class while already in class ") + CurrentClass.Type->Name + string("."), CurrentToken);
        }
        else if(CurrentFunction != NULL)
        {
            OutputStandardErrorMessage(string("Cannot create class while already in function ") + CurrentFunction->Name + string("."), CurrentToken);
        }
        else
        {
            State = PARSER_STATE::EXPECT_CLASS_NAME;
        }
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["ACTION"])
    {
        if(CurrentFunction != NULL)
        {
            OutputStandardErrorMessage(string("Cannot create new action while inside another action."), CurrentToken);
        }
        else
        {
            State = PARSER_STATE::EXPECT_ACTION_NAME_OR_ACTION_TYPE;
        }
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["END"])
    {
        State = PARSER_STATE::EXPECT_NEWLINE_AFTER_END;
        EndCurrentScope();
    }
}

void Parser::ParseExpectUsingIdent()
{
    SavedUsingIdents.push_back(CurrentToken.Contents);
    State = PARSER_STATE::EXPECT_USING_DOT_OR_NEWLINE;
}

void Parser::ParseExpectUsingDotOrNewline()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["DOT"])
    {
        State = PARSER_STATE::EXPECT_USING_IDENT;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        string Path = ConvertSavedUsingIdentsToPath();
        State = PARSER_STATE::START_OF_LINE;
        Compiler NextCompiler;
        vector<Token> NewTokens = NextCompiler.GetTokens(Path);
        Tokens.insert(Tokens.begin() + Position, NewTokens.begin(), NewTokens.end());
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline or period at end of 'using' statement ") + InsteadErrorMessage(CurrentToken.Contents), CurrentToken);
    }
}

void Parser::OutputStandardErrorMessage(const string & Message, const Token & OutToken)
{
    PrintError(GetFileNameErrorMessage() + GetErrorLineNumberText(OutToken) + Message);
}

string Parser::GetFileNameErrorMessage()
{
    string FileNameErrorMessage = string("In ") + CurrentCodeFileName + string(": ");
    return FileNameErrorMessage;
}

string Parser::GetErrorLineNumberText(const Token & OutToken)
{
    string LineNumberError = string("Error on line ") + to_string(OutToken.LineNumber) + string(": ");
    return LineNumberError;
}

string Parser::InsteadErrorMessage(const string & WrongString)
{
    string Message = string("instead of '") + WrongString + string("'");
    return Message;
}

string Parser::ConvertSavedUsingIdentsToPath()
{
    string OutputPath = "";
    OutputPath = OutputPath + SavedUsingIdents[0];
    unsigned int Index = 1;
    while(Index < SavedUsingIdents.size())
    {
        OutputPath = OutputPath + GlobalKeywords.ReservedWords["FORWARD_SLASH"] + SavedUsingIdents[Index];
        Index = Index + 1;
    }
    OutputPath = OutputPath + EXTENSION;
    return OutputPath;
}

void Parser::ParseExpectClassName()
{
    if(IsValidClassName(CurrentToken.Contents) == false)
    {
        OutputStandardErrorMessage(GetNameErrorText(CurrentToken.Contents) + string(" is not a valid class name."), CurrentToken);
    }
    else if(TypeTableContains(CurrentToken.Contents) != false)
    {
        OutputStandardErrorMessage(string("A class named ") + CurrentToken.Contents + string(" has already been declared."), CurrentToken);
    }
    else
    {
        BaseType NewClassBase;
        NewClassBase.Name = CurrentToken.Contents;
        NewClassBase.InitializeBlankCompiledTemplate();
        TypeTable.insert(pair<string,BaseType>(CurrentToken.Contents, NewClassBase));
        CurrentClass.Type = &TypeTable[CurrentToken.Contents];
        State = PARSER_STATE::EXPECT_TEMPLATE_START_OR_NEWLINE_OR_SIZE;
    }
}

string Parser::GetNameErrorText(const string & Input)
{
    string NameErrorText = string("The name '") + Input + string("'");
    return NameErrorText;
}

bool Parser::IsValidClassName(const string & Input)
{
    bool Output = IsValidIdent(Input);
    return Output;
}

bool Parser::TypeTableContains(const string & Input)
{
    bool Output = false;
    map<string,BaseType>::iterator it = TypeTable.find(Input);
    if(it != TypeTable.end())
    {
        Output = true;
    }
    return Output;
}

void Parser::ParseExpectTemplateStartOrNewlineOrSize()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        CurrentClass.Type->InitializeBlankCompiledTemplate();
        CurrentClass.Type->IsTemplated = false;
        CurrentClass.Templates = &CurrentClass.Type->CompiledTemplates[DEFAULT_COMPILED_TEMPLATE_INDEX];
        ScopeStack.push_back(&CurrentClass.Templates->MyScope);
        State = PARSER_STATE::START_OF_LINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        CurrentClass.Type->IsTemplated = true;
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_NAME;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["SIZE"])
    {
        CurrentClass.Type->InitializeBlankCompiledTemplate();
        CurrentClass.Type->IsTemplated = false;
        CurrentClass.Templates = &CurrentClass.Type->CompiledTemplates[DEFAULT_COMPILED_TEMPLATE_INDEX];
        ScopeStack.push_back(&CurrentClass.Templates->MyScope);
        State = PARSER_STATE::EXPECT_CLASS_SIZE_NUMBER;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected '<' or newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectClassTemplateName()
{
    if(IsValidClassTemplateName(CurrentToken.Contents) == true)
    {
        CurrentClass.Type->PossibleTemplates.push_back(CurrentToken.Contents);
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_END_OR_COMMA;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected valid template name for class ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

bool Parser::IsValidIdent(const string & Input)
{
    bool Output = true;
    unsigned int Index = 0;
    while(Index < Input.size())
    {
        if(isalnum(Input[Index]) == false)
        {
            Output = false;
        }
        Index = Index + 1;
    }
    return Output;
}

bool Parser::IsValidClassTemplateName(const string & Input)
{
    bool Output = IsValidIdent(Input);
    return Output;
}

void Parser::ParseExpectClassTemplateEndOrComma()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
    {
        State = PARSER_STATE::EXPECT_CLASS_DECL_NEWLINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["COMMA"])
    {
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_NAME;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected '>' or newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectClassDeclNewline()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        if(CurrentClass.Type->IsTemplated == true)
        {
            State = PARSER_STATE::EXPECT_TOKEN_UNTIL_END;
        }
        else
        {
            State = PARSER_STATE::START_OF_LINE;
        }
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectClassSizeNumber()
{
    if(IsNumber(CurrentToken.Contents) == true)
    {
        CurrentClass.Type->CompiledTemplates[DEFAULT_COMPILED_TEMPLATE_INDEX].Size = stoi(CurrentToken.Contents);
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected a number ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

bool Parser::IsNumber(const string & Input)
{
    bool Output = true;
    unsigned int Index = 0;
    while(Index < Input.size())
    {
        if(isdigit(Input[Index]) == false)
        {
            Output = false;
        }
        Index = Index + 1;
    }
    return Output;
}

void Parser::ParseExpectActionName()
{
    if(DoesSetContain(CurrentToken.Contents, GlobalKeywords.OverloadableOperators) == true || IsValidActionName(CurrentToken.Contents) == true)
    {
        Function NewFunction;
        NewFunction.IsAsm = IsAsmFunction;
        GetCurrentScope()->Functions.emplace(CurrentToken.Contents, NewFunction);
        CurrentFunction = &GetCurrentScope()->Functions[CurrentToken.Contents];
        ScopeStack.push_back(&CurrentFunction->MyScope);
        State = PARSER_STATE::EXPECT_RETURNS_OR_LPAREN_OR_NEWLINE;
    }
    else
    {
        OutputStandardErrorMessage(GetNameErrorText(CurrentToken.Contents) + string(" is not a valid action name."), CurrentToken);
    }
}

bool Parser::IsValidActionName(const string & Input)
{
    bool Output = IsValidIdent(Input);
    return Output;
}

void Parser::ParseExpectReturnsOrLParenOrNewline()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["RETURNS"])
    {
        State = PARSER_STATE::EXPECT_TYPE;
        TypeMode = TYPE_PARSE_MODE::PARSING_RETURNS;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LPAREN"])
    {
        State = PARSER_STATE::EXPECT_TYPE;
        TypeMode = TYPE_PARSE_MODE::PARSING_PARAM;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected 'returns' or '(' ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectType()
{
    if(IsValidIdent(CurrentToken.Contents) == true)
    {
        if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM)
        {
            State = PARSER_STATE::EXPECT_TEMPLATE_START_OR_IDENT;
        }
        else if(TypeMode == TYPE_PARSE_MODE::PARSING_RETURNS)
        {
            State = PARSER_STATE::EXPECT_TEMPLATE_START_OR_NEWLINE;
        }
        CurrentParsingType.Type = &TypeTable[CurrentToken.Contents];
        CurrentParsingType.Templates = CurrentParsingType.Type->GetFirstCompiledTemplate();
    }
    else
    {
        OutputStandardErrorMessage(string("Expected valid type name ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectActionNameOrActionType()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["ASM"])
    {
        IsAsmFunction = true;
        State = PARSER_STATE::EXPECT_ACTION_NAME;
    }
    else
    {
        IsAsmFunction = false;
        ParseExpectActionName();
    }
}

void Parser::ParseExpectTemplateStartOrIdent()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        // At this point, parse the template
        ParseTemplates();
        State = PARSER_STATE::EXPECT_PARAMETER_NAME;
    }
    else if(IsValidIdent(CurrentToken.Contents) == true)
    {
        // Go to the next part
        ParseExpectParameterName();
        State = PARSER_STATE::EXPECT_COMMA_OR_RPAREN;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected '<' or valid variable name ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectTemplateStartOrNewline()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        // At this point, parse the template
        ParseTemplates();
        State = PARSER_STATE::EXPECT_RETURNS_NEWLINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        CurrentFunction->ReturnType = CurrentParsingType;
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected '<' or newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectTokenUntilEnd()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["END"])
    {
        CurrentClass.Type = NULL;
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        CurrentClass.Type->Tokens.push_back(CurrentToken);
    }
}

Scope * Parser::GetCurrentScope()
{
    Scope * CurrentScope = ScopeStack[ScopeStack.size() - 1];
    return CurrentScope;
}

void Parser::ParseTemplates()
{
    InitializeTemplateTokens();
    InitializeTemplateParse();
    ParseTemplateTokens();
}

void Parser::InitializeTemplateTokens()
{
    unsigned int TemplateDeepness = 0;
    TemplateTokens.clear();
    TemplateTokens.push_back(Tokens[Position - 1]);
    bool TemplatesFinished = false;
    unsigned int Index = Position;
    while(TemplatesFinished == false && Index < Tokens.size())
    {
        if(Index >= Tokens.size())
        {
            OutputStandardErrorMessage(string("Hit end of input while parsing template."), Tokens[Index - 1]);
        }
        TemplateTokens.push_back(Tokens[Index]);
        if(Tokens[Index].Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
        {
            TemplateDeepness = TemplateDeepness + 1;
        }
        else if(Tokens[Index].Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
        {
            TemplateDeepness = TemplateDeepness - 1;
            if(TemplateDeepness == 0)
            {
                TemplatesFinished = true;
            }
        }
        Index = Index + 1;
    }
    Position = Index - 1;
}

void Parser::ParseTemplateTokens()
{
    while(TemplateTokens.size() > 3)
    {
        OperateTemplateTokens();
    }
}

void Parser::InitializeTemplateParse()
{
    TemplateTokenIndex = 0;
    CurrentParsingType.Type->InitializeBlankCompiledTemplate();
    CurrentParsingType.Templates = CurrentParsingType.Type->GetLastCompiledTemplate();
}

void Parser::OperateTemplateTokens()
{
    if(TemplateTokens[TemplateTokenIndex + 1].Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
    {
        if(IsTemplateVariable(TemplateTokens[TemplateTokenIndex].Contents) == true)
        {
            StoredParsedTemplates.push_back(GetTemplateFromVariable(TemplateTokens[TemplateTokenIndex].Contents));
            TemplateTokens.erase(TemplateTokens.begin() + TemplateTokenIndex);
            TemplateTokens.erase(TemplateTokens.begin() + (TemplateTokenIndex - 1));
        }
        else if(IsAType(TemplateTokens[TemplateTokenIndex].Contents) == true)
        {
            TemplatedType NewType;
            NewType.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
            NewType.Templates = NewType.Type->GetLastCompiledTemplate();
            StoredParsedTemplates.push_back(NewType);
            TemplateTokens.erase(TemplateTokens.begin() + TemplateTokenIndex);
            TemplateTokens.erase(TemplateTokens.begin() + (TemplateTokenIndex - 1));
        }
        else
        {
            OutputStandardErrorMessage(string("Unknown type name ") + TemplateTokens[TemplateTokenIndex].Contents, TemplateTokens[TemplateTokenIndex]);
        }
        TemplateTokenIndex = TemplateTokenIndex - 2;
        
    }
    else if(TemplateTokens[TemplateTokenIndex + 1].Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        if(TemplateTokens[TemplateTokenIndex + 2].Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
        {
            TypeTable[TemplateTokens[TemplateTokenIndex].Contents].InitializeBlankCompiledTemplate();
            CurrentParsingType.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
            CurrentParsingType.Templates = TypeTable[TemplateTokens[TemplateTokenIndex].Contents].GetLastCompiledTemplate();
            CurrentParsingType.Templates->Templates = StoredParsedTemplates;
            // At this point compile the tokens of the templated class (CurrentParsingType.Type) with (CurrentClsas = CurrentParsingType).
            TemplateTokens.erase(TemplateTokens.begin() + (TemplateTokenIndex + 2));
            TemplateTokens.erase(TemplateTokens.begin() + (TemplateTokenIndex + 1));
            string TemplateVariable = GetNextTemplateVariable();
            TemplateTokens[TemplateTokenIndex].Contents = TemplateVariable;
            TemplateVariableTable.emplace(TemplateVariable, CurrentParsingType);
        }
        else
        {
            TemplateTokenIndex = TemplateTokenIndex + 2;
        }
    }
    else
    {
        TemplateTokenIndex = TemplateTokenIndex + 2;
    }
    
}

bool Parser::IsInCurrentScope(const string & VariableName)
{
    bool Output = false;
    if(DoesMapContain(VariableName, ScopeStack[ScopeStack.size() - 1]->Objects) == true)
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsInAnyScope(const string & VariableName)
{
    bool Output = false;
    unsigned Index = 0;
    while(Index < ScopeStack.size() && Output == false)
    {
        if(DoesMapContain(VariableName, ScopeStack[ScopeStack.size() - 1 - Index]->Objects) == true)
        {
            Output = true;
        }
    }
    return Output;
}

Object * Parser::GetInCurrentScope(const string & VariableName)
{
    Object * Variable = &ScopeStack[ScopeStack.size() - 1]->Objects[VariableName];
    return Variable;
}

Object * Parser::GetInAnyScope(const string & VariableName)
{
    bool IsFound = false;
    Object * Variable = NULL;
    unsigned Index = 0;
    while(Index < ScopeStack.size() && IsFound == false)
    {
        if(DoesMapContain(VariableName, ScopeStack[ScopeStack.size() - 1 - Index]->Objects) == true)
        {
            Variable = &ScopeStack[ScopeStack.size() - 1 - Index]->Objects[VariableName];
            IsFound = true;
        }
    }
    return Variable;
}

bool Parser::IsAType(const string & TypeName)
{
    bool Output = false;
    if(DoesMapContain(TypeName, TypeTable) == true)
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsTemplateVariable(const string & VariableName)
{
    bool Output = false;
    if(DoesMapContain(VariableName, TemplateVariableTable) == true)
    {
        Output = true;
    }
    return Output;
}

TemplatedType Parser::GetTemplateFromVariable(const string & VariableName)
{
    TemplatedType Output;
    if(DoesMapContain(VariableName, TemplateVariableTable) == true)
    {
        Output = TemplateVariableTable[VariableName];
    }
    return Output;
}

string Parser::GetNextTemplateVariable()
{
    string Output = TEMPLATE_VARIABLE_NAME_PREFIX + to_string(TemplateVariableCounter);
    TemplateVariableCounter = TemplateVariableCounter + 1;
    return Output;
}

void Parser::ParseExpectParameterName()
{
    Object NewParamObject;
    NewParamObject.Name = CurrentToken.Contents;
    NewParamObject.Type = CurrentParsingType;
    CurrentFunction->MyScope.Objects.emplace(NewParamObject.Name, NewParamObject);
    CurrentFunction->Parameters.push_back(&NewParamObject);
}

void Parser::ParseExpectReturnsNewline()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::EndCurrentScope()
{
    if(CurrentFunction != NULL)
    {
        CurrentFunction = NULL;
    }
    else if(CurrentClass.Type != NULL)
    {
        CurrentClass.Type = NULL;
    }
    ScopeStack.pop_back();
}

void Parser::ParseExpectNewlineAfterEnd()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectCommaOrRParen()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["COMMA"])
    {
        State = PARSER_STATE::EXPECT_TYPE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["RPAREN"])
    {
        State = PARSER_STATE::EXPECT_NEWLINE_OR_RETURNS;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected ',' or ')' ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectNewlineOrReturns()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        State = PARSER_STATE::START_OF_LINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["RETURNS"])
    {
        State = PARSER_STATE::EXPECT_TYPE;
        TypeMode = TYPE_PARSE_MODE::PARSING_RETURNS;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected ',' or ')' ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}