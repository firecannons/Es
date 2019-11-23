#include "Parser.h"

string Parser::Parse(const vector<Token> & Tokens)
{
    Initialize(Tokens);
    
    RunParse();

    AppendInitialASM();
    
    return OutputAsm;
}

void Parser::RunParse()
{
    GetNextToken();
    while(IsNextToken() == true)
    {
        Operate();
        GetNextToken();
    }
    OutputTypeTable();
}    

void Parser::Initialize(const vector<Token> & Tokens)
{
    this->Tokens = Tokens;
    State = PARSER_STATE::START_OF_LINE;
    Position = 0;
    OutputAsm = string("");
    HasToken = false;
    SavedUsingIdents.clear();
    GlobalScope.Origin = SCOPE_ORIGIN::GLOBAL;
    ScopeStack.push_back(& GlobalScope);
    CurrentFunction = NULL;
    CurrentClass.Type = NULL;
    IsAsmFunction = false;
    TemplateVariableCounter = 0;
    TemporaryVariableCounter = 0;
    LabelCounter = 0;
    WasVariableFound = false;
    InitializeOperatorOrdering();
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
    cout << CurrentToken.Contents << " " << State << endl;
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
    else if(State == PARSER_STATE::EXPECT_VARIABLE_NAME)
    {
        ParseExpectVariableName();
    }
    else if(State == PARSER_STATE::EXPECT_FIRST_OPERATOR_OR_NEWLINE)
    {
        ParseExpectFirstOperatorOrNewline();
    }
    else if(State == PARSER_STATE::EXPECT_NEWLINE_AFTER_VARIABLE_DECLARATION)
    {
        ParseExpectNewlineAfterVariableDeclaration();
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
        if(IsFunctionScopeClosest() == true)
        {
            if(CurrentFunction->IsAsm == false)
            {
                OutputAsm = OutputAsm + GlobalASM.CalcDestroyStackFrameAsm();
                AppendNewlinesToOutputASM(2);
            }
            OutputAsm = OutputAsm + GlobalASM.CalcRetAsm();
            AppendNewlinesToOutputASM(2);
        }
        EndCurrentScope();
    }
    else
    {
        bool IsAsmFunction = false;
        if(CurrentFunction != NULL)
        {
            if(CurrentFunction->IsAsm == true)
            {
                IsAsmFunction = true;
                OutputAsm = OutputAsm + CurrentToken.Contents + GlobalKeywords.ReservedWords["NEW_LINE"];
            }
        }
        if(IsAsmFunction == false)
        {
            if(IsAType(CurrentToken.Contents) == true)
            {
                TypeMode = TYPE_PARSE_MODE::PARSING_NEW_VARIABLE;
                ParseExpectType();
            }
            else
            { // Change above line to just "else" when Me: is working.
                CopyUntilNextNewline();
                ReduceLine();
                State = PARSER_STATE::START_OF_LINE;
            }
        }
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
        if(DoesFileExist(Path) == false)
        {
            OutputStandardErrorMessage(string("Code file does not exist:  ") + Path, CurrentToken);
        }
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
    PrintError(GetFileNameErrorMessage(OutToken) + GetErrorLineNumberText(OutToken) + Message);
}

string Parser::GetFileNameErrorMessage(const Token & OutToken)
{
    string FileNameErrorMessage = string("In ") + OutToken.SourceFileName + string(": ");
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
        OutputPath = OutputPath + GlobalKeywords.ReservedWords["SLASH"] + SavedUsingIdents[Index];
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
        CurrentClass.Templates->MyScope.Origin = SCOPE_ORIGIN::CLASS;
        ScopeStack.push_back(&CurrentClass.Templates->MyScope);
        State = PARSER_STATE::START_OF_LINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        CurrentClass.Type->IsTemplated = true;
        ScopeStack.push_back(NULL);
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_NAME;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["SIZE"])
    {
        CurrentClass.Type->InitializeBlankCompiledTemplate();
        CurrentClass.Type->IsTemplated = false;
        CurrentClass.Templates = &CurrentClass.Type->CompiledTemplates[DEFAULT_COMPILED_TEMPLATE_INDEX];
        CurrentClass.Templates->MyScope.Origin = SCOPE_ORIGIN::CLASS;
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
        if(isalnum(Input[Index]) == false && Input[Index] != GlobalKeywords.ReservedWords["UNDER_SCORE"][0])
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
        cout << "two" << endl;
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
        string NextLabel = GetNextLabel();
        Function NewFunction;
        NewFunction.IsAsm = IsAsmFunction;
        NewFunction.HasReturnType = false;
        NewFunction.Label = NextLabel;
        NewFunction.Name = CurrentToken.Contents;
        NewFunction.MyScope.Origin = SCOPE_ORIGIN::FUNCTION;
        GetCurrentScope()->Functions.emplace(CurrentToken.Contents, NewFunction);
        CurrentFunction = &GetCurrentScope()->Functions[CurrentToken.Contents];
        ScopeStack.push_back(&CurrentFunction->MyScope);
        
        Object NewObject;
        NewObject.Name = GlobalKeywords.ReservedWords["ME"];
        NewObject.Type = CurrentClass;
        NewObject.Offset = GetNextParamOffset();
        NewObject.IsReference = true;
        GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
        CurrentFunction->Parameters.push_back(&GetCurrentScope()->Objects[NewObject.Name]);
        
        OutputAsm = OutputAsm + NextLabel + GlobalKeywords.ReservedWords["COLON"];
        if(DEBUG == true)
        {
            OutputCurrentFunctionToAsm();
        }
        AppendNewlinesToOutputASM(2);
        if(NewFunction.IsAsm == false)
        {
            OutputAsm = OutputAsm + GlobalASM.CalcCreateStackFrameAsm();
            AppendNewlinesToOutputASM(2);
        }
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
        CurrentFunction->HasReturnType = true;
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
        if(IsAType(CurrentToken.Contents) == true)
        {
            if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM || TypeMode == TYPE_PARSE_MODE::PARSING_NEW_VARIABLE)
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
            OutputStandardErrorMessage(string("No type '") + CurrentToken.Contents + string("'."), CurrentToken);
        }
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
        State = PARSER_STATE::EXPECT_VARIABLE_NAME;
    }
    else if(IsValidIdent(CurrentToken.Contents) == true)
    {
        // Go to the next part
        
        if(CurrentParsingType.Type->PossibleTemplates.size() != 0)
        {
            OutputStandardErrorMessage(string("Type '") + CurrentParsingType.Type->Name + "' expects templates.", CurrentToken);
        }
        ParseExpectVariableName();
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
    while(TemplateTokens.size() >= 3)
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

void Parser::RemoveTypeInTemplates()
{
    TemplateTokens.erase(TemplateTokens.begin() + TemplateTokenIndex);
    if(TemplateTokens[TemplateTokenIndex - 1].Contents != GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        TemplateTokens.erase(TemplateTokens.begin() + TemplateTokenIndex - 1);
    }
}

void Parser::OperateTemplateTokens()
{
    if(TemplateTokens[TemplateTokenIndex + 1].Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
    {
        if(IsTemplateVariable(TemplateTokens[TemplateTokenIndex].Contents) == true)
        {
            StoredParsedTemplates.push_back(GetTemplateFromVariable(TemplateTokens[TemplateTokenIndex].Contents));
            RemoveTypeInTemplates();
        }
        else if(IsAType(TemplateTokens[TemplateTokenIndex].Contents) == true)
        {
            TemplatedType NewType;
            NewType.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
            NewType.Templates = NewType.Type->GetLastCompiledTemplate();
            StoredParsedTemplates.push_back(NewType);
            RemoveTypeInTemplates();
        }
        else
        {
            OutputStandardErrorMessage(string("Unknown type name ") + TemplateTokens[TemplateTokenIndex].Contents, TemplateTokens[TemplateTokenIndex]);
        }
        TemplateTokenIndex = TemplateTokenIndex - 2;
        
    }
    else if(TemplateTokens[TemplateTokenIndex + 1].Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        if(TypeTable[TemplateTokens[TemplateTokenIndex].Contents].PossibleTemplates.size() == 0)
        {
            OutputStandardErrorMessage(string("Type '") + TemplateTokens[TemplateTokenIndex].Contents + "' is not templated. ", TemplateTokens[TemplateTokenIndex]);
        }
        if(TemplateTokens[TemplateTokenIndex + 2].Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
        {
            TypeTable[TemplateTokens[TemplateTokenIndex].Contents].InitializeBlankCompiledTemplate();
            CurrentParsingType.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
            CurrentParsingType.Templates = TypeTable[TemplateTokens[TemplateTokenIndex].Contents].GetLastCompiledTemplate();
            if(CurrentParsingType.Type->PossibleTemplates.size() != StoredParsedTemplates.size())
            {
                OutputStandardErrorMessage(string("Type '") + TemplateTokens[TemplateTokenIndex].Contents + "' expects " +
                    to_string(CurrentParsingType.Type->PossibleTemplates.size()) + " templates not " + to_string(StoredParsedTemplates.size()) + ".", TemplateTokens[TemplateTokenIndex]);
            }
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
            if(IsAType(TemplateTokens[TemplateTokenIndex].Contents) == false)
            {
                OutputStandardErrorMessage(string("Unknown type name ") + TemplateTokens[TemplateTokenIndex].Contents, TemplateTokens[TemplateTokenIndex]);
            }
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
        Index = Index + 1;
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
    WasVariableFound = false;
    Object * Variable = NULL;
    unsigned Index = 0;
    while(Index < ScopeStack.size() && WasVariableFound == false)
    {
        if(DoesMapContain(VariableName, ScopeStack[ScopeStack.size() - 1 - Index]->Objects) == true)
        {
            Variable = &ScopeStack[ScopeStack.size() - 1 - Index]->Objects[VariableName];
            WasVariableFound = true;
        }
        Index = Index + 1;
    }
    if(WasVariableFound == false)
    {
        OutputStandardErrorMessage(string("No variable '") + VariableName + string("' found."), CurrentToken);
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
        OutputStandardErrorMessage(string("Expected 'returns' or newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectVariableName()
{
    if(IsValidIdent(CurrentToken.Contents) == true)
    {
        Object NewParamObject;
        NewParamObject.Name = CurrentToken.Contents;
        NewParamObject.Type = CurrentParsingType;
        GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
        if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM)
        {
            GetCurrentScope()->Objects[NewParamObject.Name].Offset = GetNextParamOffset();
            CurrentFunction->Parameters.push_back(&CurrentFunction->MyScope.Objects[NewParamObject.Name]);
            State = PARSER_STATE::EXPECT_COMMA_OR_RPAREN;
        }
        else if(TypeMode == TYPE_PARSE_MODE::PARSING_NEW_VARIABLE)
        {
            if(IsClassScopeClosest() == true)
            {
                PositionObjectInClass(NewParamObject);
                State = PARSER_STATE::EXPECT_NEWLINE_AFTER_VARIABLE_DECLARATION;
            }
            else
            {
                AddNewVariableToStack(GetCurrentScope()->Objects[NewParamObject.Name]);
                State = PARSER_STATE::EXPECT_FIRST_OPERATOR_OR_NEWLINE;
            }
            
        }
    }
    else
    {
        OutputStandardErrorMessage(string("Invalid variable name ") + CurrentToken.Contents + string("."), CurrentToken);
    }
}

void Parser::ParseExpectFirstOperatorOrNewline()
{
    if(DoesSetContain(CurrentToken.Contents, GlobalKeywords.AfterDeclarationOperators) == true)
    {
        Position = Position - 1;
        CopyUntilNextNewline();
        ReduceLine();
        State = PARSER_STATE::START_OF_LINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline or '=' ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::CopyUntilNextNewline()
{
    ReduceTokens.clear();
    while(Position < Tokens.size() && Tokens[Position].Contents != GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        ReduceTokens.push_back(Tokens[Position]);
        Position = Position + 1;
    }
}

void Parser::ReduceLine()
{
    ReducePosition = 0;
    while(ReduceTokens.size() > 2)
    {
        OperateReduceTokens();
    }
}

void Parser::OperateReduceTokens()
{
    cout << ReduceTokens[ReducePosition].Contents << endl;
    OutputTokens(ReduceTokens);
    if(IsCurrentlyLeftParen() == true)
    {
        ReducePosition = ReducePosition + 1;
    }
    else if(IsFunctionCallCurrently() == true)
    {
        DoReduceFunctionCall();
    }
    else if(IsSingleVarInParens() == true)
    {
        DoSingleVarInParens();
    }
    else if(IsALeftParenInOperatorPosition() == true)
    {
        ReducePosition = ReducePosition + 2;
    }
    else if(IsAColonInNextOperatorPosition() == true)
    {
        DoColonReduce();
    }
    else if(IsAColonInFarOperatorPosition() == true)
    {
        ReducePosition = ReducePosition + 2;
    }
    else if(IsRParenNext() == true)
    {
        ReduceRParen();
    }
    else if(ReduceTokens.size() - ReducePosition <= 2)
    {
        ReducePosition = ReducePosition - 2;
    }
    else if(IsFirstOperatorHigherPrecedence() == true)
    {
        DoReduce();
    }
    else
    {
        ReducePosition = ReducePosition + 2;
    }
}

void Parser::InitializeOperatorOrdering()
{
    OperatorOrdering.clear();
    unordered_set<string> NewSet;
    
    NewSet.clear();
    NewSet.emplace(GlobalKeywords.ReservedWords["STAR"]);
    NewSet.emplace(GlobalKeywords.ReservedWords["SLASH"]);
    OperatorOrdering.push_back(NewSet);
    
    NewSet.clear();
    NewSet.emplace(GlobalKeywords.ReservedWords["PLUS"]);
    NewSet.emplace(GlobalKeywords.ReservedWords["MINUS"]);
    OperatorOrdering.push_back(NewSet);
    
    NewSet.clear();
    NewSet.emplace(GlobalKeywords.ReservedWords["IS_EQUAL"]);
    NewSet.emplace(GlobalKeywords.ReservedWords["NOT_EQUAL"]);
    NewSet.emplace(GlobalKeywords.ReservedWords["GREATER_THAN"]);
    NewSet.emplace(GlobalKeywords.ReservedWords["GREATER_OR_EQUAL"]);
    NewSet.emplace(GlobalKeywords.ReservedWords["LESS_OR_EQUAL"]);
    NewSet.emplace(GlobalKeywords.ReservedWords["LESS_THAN"]);
    OperatorOrdering.push_back(NewSet);
    
    NewSet.clear();
    NewSet.emplace(GlobalKeywords.ReservedWords["EQUALS"]);
    OperatorOrdering.push_back(NewSet);
}

bool Parser::IsCurrentlyLeftParen()
{
    bool Output = false;
    if(ReduceTokens[ReducePosition].Contents == GlobalKeywords.ReservedWords["LEFT_PAREN"])
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsFirstOperatorHigherPrecedence()
{
    bool Done = false;
    bool Output = false;
    unsigned int OrderingIndex = 0;
    while(OrderingIndex < OperatorOrdering.size() && Done == false)
    {
        if(DoesSetContain(ReduceTokens[ReducePosition + 1].Contents, OperatorOrdering[OrderingIndex]) == true)
        {
            Output = true;
            Done = true;
        }
        else if(ReduceTokens.size() - ReducePosition > 3)
        {
            if(DoesSetContain(ReduceTokens[ReducePosition + 3].Contents, OperatorOrdering[OrderingIndex]) == true)
            {
                Done = true;
            }
        }
        OrderingIndex = OrderingIndex + 1;
    }
    return Output;
}

void Parser::DoReduce()
{
    ReduceOperator();
}

void Parser::ReduceRParen()
{
    AddToArgList(ReducePosition);
    if(ReduceTokens[ReducePosition - 1].Contents == GlobalKeywords.ReservedWords["LPAREN"])
    {
        ReduceTokens.erase(ReduceTokens.begin() + ReducePosition);
    }
    else if(ReduceTokens[ReducePosition - 1].Contents == GlobalKeywords.ReservedWords["COMMA"])
    {
        ReduceTokens.erase(ReduceTokens.begin() + ReducePosition);
        ReduceTokens.erase(ReduceTokens.begin() + (ReducePosition - 1));
    }
    ReducePosition = ReducePosition - 2;
}

bool Parser::IsFunctionCallCurrently()
{
    bool Output = false;
    if(ReduceTokens[ReducePosition + 1].Contents == GlobalKeywords.ReservedWords["LPAREN"]
        && ReduceTokens[ReducePosition + 2].Contents == GlobalKeywords.ReservedWords["RPAREN"]
        && IsValidActionName(ReduceTokens[ReducePosition].Contents) == true)
    {
        Output = true;
    }
    return Output;
}

void Parser::DoReduceFunctionCall()
{
    Function * WantedFunction = NULL;
    bool IsCallingObject = false;
    if(ReducePosition >= 2)
    {
        if(ReduceTokens[ReducePosition - 1].Contents == GlobalKeywords.ReservedWords["COLON"])
        {
            IsCallingObject = true;
            AddToArgList(ReducePosition - 2);
            WantedFunction = &GetInAnyScope(ReduceTokens[ReducePosition - 2].Contents)->Type.Templates->MyScope.Functions[ReduceTokens[ReducePosition].Contents];
            ReduceTokens.erase(ReduceTokens.begin() + ReducePosition - 1);
            ReduceTokens.erase(ReduceTokens.begin() + ReducePosition - 1);
        }
    }
    if(IsCallingObject == false)
    {
        WantedFunction = &GetGlobalScope()->Functions[ReduceTokens[ReducePosition].Contents];
    }
    CallFunction(*WantedFunction);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
}

void Parser::ReduceOperator()
{
    AddToArgList(ReducePosition + 2);
    AddToArgList(ReducePosition);
    CallFunction(GetInAnyScope(ReduceTokens[ReducePosition].Contents)->Type.Templates->MyScope.Functions[ReduceTokens[ReducePosition + 1].Contents]);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition);
}

bool Parser::IsSingleVarInParens()
{
    bool Output = false;
    if(ReduceTokens[ReducePosition + 1].Contents == GlobalKeywords.ReservedWords["LPAREN"]
        && ReduceTokens[ReducePosition + 3].Contents == GlobalKeywords.ReservedWords["RPAREN"]
        && IsValidIdent(ReduceTokens[ReducePosition + 2].Contents) == true)
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsALeftParenInOperatorPosition()
{
    bool Output = false;
    if(ReduceTokens[ReducePosition + 1].Contents == GlobalKeywords.ReservedWords["LPAREN"]
        || ReduceTokens[ReducePosition + 3].Contents == GlobalKeywords.ReservedWords["LPAREN"])
    {
        Output = true;
    }
    return Output;
}

void Parser::DoSingleVarInParens()
{
    if(IsValidActionName(ReduceTokens[ReducePosition].Contents) == true)
    {
        ReducePosition = ReducePosition + 2;
    }
    else
    {
        ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 3);
        ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
        ReducePosition = ReducePosition - 1;
    }
}

bool Parser::IsAColonInNextOperatorPosition()
{
    bool Output = false;
    if(ReduceTokens[ReducePosition + 1].Contents == GlobalKeywords.ReservedWords["COLON"])
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsAColonInFarOperatorPosition()
{
    bool Output = false;
    if(ReduceTokens.size() - ReducePosition > 3)
    {
        if(ReduceTokens[ReducePosition + 3].Contents == GlobalKeywords.ReservedWords["COLON"])
        {
            Output = true;
        }
    }
    return Output;
}

void Parser::DoColonReduce()
{
    Object * CallingObject = GetInAnyScope(ReduceTokens[ReducePosition].Contents);
    Object * ScopeObject = &CallingObject->Type.Templates->MyScope.Objects[ReduceTokens[ReducePosition + 2].Contents];
    unsigned int OffsetShift = ScopeObject->Offset;
    Object NewObject;
    NewObject.Name = GetNextTemporaryVariable();
    ReduceTokens[ReducePosition + 2].Contents = NewObject.Name;
    NewObject.Type = ScopeObject->Type;
    NewObject.Offset = CallingObject->Offset + OffsetShift;
    GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 0);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 0);
}

void Parser::AppendInitialASM()
{
    string LabelString = GetGlobalScope()->Functions[MAIN_FUNCTION_NAME].Label;
    OutputAsm = GlobalASM.CalcStartOfFileAsm() + LabelString + GetNewlines(2) + OutputAsm;
}

string Parser::GetNextTemporaryVariable()
{
    string NextTemporaryVariable = TEMPORARY_VARIABLE_PREFIX + to_string(TemporaryVariableCounter);
    TemporaryVariableCounter = TemporaryVariableCounter + 1;
    return NextTemporaryVariable;
}

string Parser::GetNextLabel()
{
    string NextLabel = LABEL_PREFIX + to_string(LabelCounter);
    LabelCounter = LabelCounter + 1;
    return NextLabel;
}

bool Parser::IsFunctionScopeClosest()
{
    bool Output = false;
    if(GetClosestScopeOrigin() == SCOPE_ORIGIN::FUNCTION)
    {
        Output = true;
    }
    return Output;
}

void Parser::AppendNewlinesToOutputASM(const unsigned int Number)
{
    OutputAsm = OutputAsm + GetNewlines(Number);
}

string Parser::GetNewlines(const unsigned int Number)
{
    string Newlines = "";
    unsigned int Index = 0;
    while(Index < Number)
    {
        Newlines = Newlines + GlobalKeywords.ReservedWords["NEW_LINE"];
        Index = Index + 1;
    }
    return Newlines;
}

void Parser::OutputCurrentFunctionToAsm()
{
    string FunctionPath = SPACE + SEMICOLON + SPACE;
    if(CurrentClass.Type != NULL)
    {
        FunctionPath = FunctionPath + CurrentClass.Type->Name;
    }
    
    if(CurrentFunction != NULL)
    {
        FunctionPath = FunctionPath + GlobalKeywords.ReservedWords["COLON"] + CurrentFunction->Name;
    }
    OutputAsm = OutputAsm + FunctionPath;
}

void Parser::OutputDeclaringVariableToAsm(const string & VariableName)
{
    string Output = SPACE + SEMICOLON + SPACE;
    OutputAsm = OutputAsm + Output + string("Declaring ") + VariableName;
}

void Parser::AddToArgList(const unsigned int InPosition)
{
    string VariableName = ReduceTokens[InPosition].Contents;
    Object * NextArg = NULL;
    cout << "'" << VariableName << "' " << IsNumber(VariableName) << endl;
    if(IsNumber(VariableName) == true)
    {
        Object NumberObject;
        NumberObject.Name = GetNextTemporaryVariable();
        ReduceTokens[InPosition].Contents = NumberObject.Name;
        NumberObject.Type.Type = &TypeTable["Byte"];
        NumberObject.Type.Templates = TypeTable["Byte"].GetFirstCompiledTemplate();
        GetCurrentScope()->Objects.emplace(NumberObject.Name, NumberObject);
        AddNewVariableToStack(GetCurrentScope()->Objects[NumberObject.Name]);
        AddNumericalValueToTempInteger(VariableName);
        NextArg = GetInAnyScope(NumberObject.Name);
    }
    else
    {
        NextArg = GetInAnyScope(VariableName);
    }
    NextFunctionObjects.push_back(NextArg);
}

void Parser::AddNewVariableToStack(Object & NewObject)
{
    OutputAsm = OutputAsm + GlobalASM.CalcReserveSpaceAsm(NewObject.Type.Templates->Size);
    if(DEBUG == true)
    {
        OutputDeclaringVariableToAsm(NewObject.Name);
    }
    AppendNewlinesToOutputASM(1);
    MoveBackCurrentScopeOffset(NewObject);
}

void Parser::CallFunction(const Function & InFunction)
{
    AddReturnValue(InFunction);
    int StartOffset = GetCurrentScope()->Offset;
    PushArguments();
    OutputCallAsm(InFunction);
    if(DEBUG == true)
    {
        OutputCallingFunctionCommentToAsm(InFunction);
    }
    AppendNewlinesToOutputASM(1);
    OutputShiftUpFromFunction(GetCurrentScope()->Offset - StartOffset);
    AppendNewlinesToOutputASM(2);
    GetCurrentScope()->Offset = StartOffset;
    NextFunctionObjects.clear();
}

void Parser::PushArguments()
{
    unsigned int Index = 0;
    while(Index < NextFunctionObjects.size())
    {
        OutputAsm = OutputAsm + GlobalASM.CalcPushRefForFunctionCall(NextFunctionObjects[Index]->Offset, POINTER_SIZE);
        if(DEBUG == true)
        {
            OutputPushingReferenceToVariableToAsm(NextFunctionObjects[Index]->Name);
        }
        AppendNewlinesToOutputASM(2);
        GetCurrentScope()->Offset = GetCurrentScope()->Offset + POINTER_SIZE;
        Index = Index + 1;
    }
}

void Parser::OutputPushingReferenceToVariableToAsm(const string & VariableName)
{
    string Output = SPACE + SEMICOLON + SPACE;
    OutputAsm = OutputAsm + Output + string("Pushing reference to ") + VariableName;
}

void Parser::OutputCallAsm(const Function & InFunction)
{
    OutputAsm = OutputAsm + GlobalASM.CalcCallAsm(InFunction.Label);
}

void Parser::OutputShiftUpFromFunction(const unsigned int ShiftAmount)
{
    OutputAsm = OutputAsm + GlobalASM.CalcShiftUpAsm(ShiftAmount);
}

Scope * Parser::GetGlobalScope()
{
    return &GlobalScope;
}

void Parser::OutputCallingFunctionCommentToAsm(const Function & InFunction)
{
    string Output = SPACE + SEMICOLON + SPACE;
    OutputAsm = OutputAsm + Output + string("Calling ") + InFunction.Name;
}

bool Parser::IsRParenNext()
{
    bool Output = false;
    if(ReduceTokens.size() - ReducePosition > 1)
    {
        if(ReduceTokens[ReducePosition + 1].Contents == GlobalKeywords.ReservedWords["RPAREN"])
        {
            Output = true;
        }
    }
    return Output;
}

void Parser::AddReturnValue(const Function & InFunction)
{
    if(InFunction.HasReturnType == true)
    {
        Object NewObject;
        NewObject.Name = GetNextTemporaryVariable();
        NewObject.Type = InFunction.ReturnType;
        GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
        AddNewVariableToStack(GetCurrentScope()->Objects[NewObject.Name]);
        ReduceTokens[ReducePosition].Contents = NewObject.Name;
    }
}

void Parser::ParseExpectNewlineAfterVariableDeclaration()
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

bool Parser::IsGlobalScopeClosest()
{
    bool Output = false;
    if(GetClosestScopeOrigin() == SCOPE_ORIGIN::GLOBAL)
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsClassScopeClosest()
{
    bool Output = false;
    if(GetClosestScopeOrigin() == SCOPE_ORIGIN::CLASS)
    {
        Output = true;
    }
    return Output;
}

SCOPE_ORIGIN Parser::GetClosestScopeOrigin()
{
    return ScopeStack[ScopeStack.size() - 1]->Origin;
}

void Parser::MoveBackCurrentScopeOffset(Object & NewObject)
{
    GetCurrentScope()->Offset = GetCurrentScope()->Offset - NewObject.Type.Templates->Size;
    NewObject.Offset = GetCurrentScope()->Offset;
}

void Parser::AddNumericalValueToTempInteger(const string & NewValue)
{
    cout << "one" << endl;
    OutputAsm = OutputAsm + GlobalASM.CalcIntegerQuickAssignAsm(stoi(NewValue));
    AppendNewlinesToOutputASM(1);
}

void Parser::PositionObjectInClass(Object & NewObject)
{
    NewObject.Offset = CurrentClass.Templates->Size;
    CurrentClass.Templates->Size = CurrentClass.Templates->Size + NewObject.Type.Templates->Size;
}

unsigned int Parser::GetNextParamOffset()
{
    unsigned int NextParamOffset = STACK_FRAME_SIZE + CurrentFunction->Parameters.size() * POINTER_SIZE;
    return NextParamOffset;
}

void Parser::OutputTypeTable()
{
    string OutputString;

    OutputString = OutputString + OutputTypeTableToString();
    cout << OutputString << endl;
}

string Parser::OutputTypeTableToString()
{
    string OutputString;
    map<string, BaseType>::iterator Iterator;
    for (Iterator = TypeTable.begin(); Iterator != TypeTable.end(); Iterator++)
    {
        OutputString = OutputString + OutputTypeToString(Iterator->second, 1);
    }
    return OutputString;
}

string Parser::OutputTypeToString(const BaseType & InType, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Name: " + InType.Name + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "IsTemplated: " + to_string(InType.IsTemplated) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Templates: ";
    OutputString = OutputString + OutputSingleLineVectorToString(InType.PossibleTemplates) + '\n';
    unsigned int Index = 0;
    while(Index < InType.CompiledTemplates.size())
    {
        OutputString = OutputString + OutputCompiledTemplateToString(InType.CompiledTemplates[Index], Level + 1);
        Index = Index + 1;
    }
    return OutputString;
}

string Parser::OutputSingleLineVectorToString(const vector<string> & InVector)
{
    string OutputString;
    unsigned int Index = 0;
    while(Index < InVector.size())
    {
        OutputString = OutputString + InVector[Index] + GlobalKeywords.ReservedWords["SPACE"];
        Index = Index + 1;
    }
    return OutputString;
}

string Parser::OutputTabsToString(const unsigned int NumberTabs)
{
    string OutputString;
    unsigned int Index = 0;
    while(Index < NumberTabs)
    {
        OutputString = OutputString + '\t';
        Index = Index + 1;
    }
    return OutputString;
}

string Parser::OutputCompiledTemplateToString(const CompiledTemplate & OutputCT, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Size: " + to_string(OutputCT.Size) + '\n';
    OutputString = OutputString + OutputScopeToString((Scope &)OutputCT.MyScope, Level + 1);
    return OutputString;
}

string Parser::OutputScopeToString(Scope & OutputScope, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Offset: " + to_string(OutputScope.Offset) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Origin: " + to_string(OutputScope.Origin) + '\n';

    map<string, Object>::iterator Iterator;
    for (Iterator = OutputScope.Objects.begin(); Iterator != OutputScope.Objects.end(); Iterator++)
    {
        OutputString = OutputString + OutputObjectToString(Iterator->second, Level + 1);
    }

    map<string, Function>::iterator FuncIterator;
    for (FuncIterator = OutputScope.Functions.begin(); FuncIterator != OutputScope.Functions.end(); FuncIterator++)
    {
        OutputString = OutputString + OutputFunctionToString((Function &)FuncIterator->second, Level + 1);
    }
    return OutputString;
}

string Parser::OutputObjectToString(const Object & OutputObject, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Name: " + OutputObject.Name + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Offset: " + to_string(OutputObject.Offset) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Is Constant: " + to_string(OutputObject.IsConstant) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Is Reference: " + to_string(OutputObject.IsReference) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Type: \n";
    OutputString = OutputString + OutputTemplatedTypeToString(OutputObject.Type, Level + 1);
    return OutputString;
}

string Parser::OutputTemplatedTypeToString(const TemplatedType & OutputTT, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Type Name: " + OutputTT.Type->Name + '\n';
    return OutputString;
}

string Parser::OutputFunctionToString(Function & OutputFunction, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Name: " + OutputFunction.Name + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Is Asm: " + to_string(OutputFunction.IsAsm) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Label: " + OutputFunction.Label + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Has Return Type: " + to_string(OutputFunction.HasReturnType) + '\n';
    if(OutputFunction.HasReturnType == true)
    {
        OutputString = OutputString + OutputTabsToString(Level);
        OutputString = OutputString + "Return Type: \n";
        OutputString = OutputString + OutputTemplatedTypeToString(OutputFunction.ReturnType, Level + 1);
    }

    unsigned int Index = 0;
    while(Index < OutputFunction.Parameters.size())
    {
        OutputString = OutputString + OutputObjectToString(*(OutputFunction.Parameters[Index]), Level + 1);
        Index = Index + 1;
    }
    return OutputString;
}