#include "Parser.h"

string Parser::Parse(const vector<Token> & Tokens)
{
    Initialize(Tokens);
    
    RunAllPasses();

    OutputTemplateAsm();
    
    AppendExecutableSectionAsmToOutputAsm();
    
    AppendGlobalVariableAsmToOutputAsm();

    AppendInitialASM();
    
    return OutputAsm;
}

void Parser::RunParse()
{
    do
    {
        GetNextToken();
        Operate();
    }while(IsNextToken() == true);
}    

void Parser::Initialize(const vector<Token> & Tokens)
{
    this->Tokens = Tokens;
    InitializeGlobalPasses();
    InitializeForPass();
    OutputAsm = string("");
    GlobalScope.Origin = SCOPE_ORIGIN::GLOBAL;
    ScopeStack.clear();
    ScopeStack.push_back(& GlobalScope);
    TemplateVariableCounter = 0;
    TemporaryVariableCounter = 0;
    GlobalVariableCounter = 0;
    LabelCounter = 0;
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
    cout << CurrentToken.Contents << " " << State << " " << PassMode << endl;
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
    else if(State == PARSER_STATE::EXPECT_TEMPLATE_START_OR_NEWLINE_OR_REFERENCE)
    {
        ParseExpectTemplateStartOrNewlineOrReference();
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
    else if(State == PARSER_STATE::EXPECT_WAIT_FOR_END)
    {
        ParseExpectWaitForEnd();
    }
    else if(State == PARSER_STATE::EXPECT_UNTIL_OR_WHILE)
    {
        ParseExpectUntilOrWhile();
    }
    else if(State == PARSER_STATE::EXPECT_RETURNS_NEWLINE_OR_REFERENCE)
    {
        ParseExpectReturnsNewlineOrReference();
    }
}

void Parser::ParseStartOfLine()
{
    if(CurrentFunction != NULL)
    {
        if(JustParsedActionLine == true)
        {
            if(CurrentFunction->Name == MAIN_FUNCTION_NAME && PassMode == PASS_MODE::FULL_PASS)
            {
                Tokens.insert(Tokens.begin() + Position, GlobalVariableInitializeTokens.begin(), GlobalVariableInitializeTokens.end());
                CurrentToken = Tokens[Position];
                IsParsingGlobalVariables = true;
                EndPositionOfGlobalVarInitialization = Position + GlobalVariableInitializeTokens.size();
            }
            JustParsedActionLine = false;
        }
    }
    if(IsParsingGlobalVariables == true)
    {
        if(Position >= EndPositionOfGlobalVarInitialization)
        {
            IsParsingGlobalVariables = false;
        }
        else if(CurrentToken.Contents != GlobalKeywords.ReservedWords["NEW_LINE"])
        {
            JustDeclaredObject = true;
            TypeMode = TYPE_PARSE_MODE::PARSING_NEW_VARIABLE;
            ParseExpectVariableName();
        }
    }
    if(IsParsingGlobalVariables == false)
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
                JustParsedActionLine = true;
                State = PARSER_STATE::EXPECT_ACTION_NAME_OR_ACTION_TYPE;
            }
        }
        else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["END"])
        {
            ParseEndToken();
        }
        else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["RETURN"])
        {
            Position = Position + 1;
            CopyUntilNextNewline();
            if(IsLocalScopeToBeParsedNow() == true)
            {
                ReduceLine();
                ReturnAfterReduce();
            }
            State = PARSER_STATE::EXPECT_WAIT_FOR_END;
        }
        else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["REPEAT"])
        {
            State = PARSER_STATE::EXPECT_UNTIL_OR_WHILE;
        }
        else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["IF"])
        {
            ParseIfStatement();
        }
        else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["ELSE_IF"])
        {
            ParseElseIfStatement();
        }
        else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["ELSE"])
        {
            ParseElseStatement();
        }
        else
        {
            if(IsLocalScopeToBeParsedNow() == true)
            {
                bool IsAsmFunction = false;
                if(CurrentFunction != NULL)
                {
                    if(CurrentFunction->IsAsm == true)
                    {
                        IsAsmFunction = true;
                        string LinkedAsm = LinkAsm(CurrentToken.Contents);
                        OutputAsm = OutputAsm + LinkedAsm + GlobalKeywords.ReservedWords["NEW_LINE"];
                    }
                }
                if(IsAsmFunction == false)
                {
                    if(IsAType(CurrentToken.Contents) == true)
                    {
                        TypeMode = TYPE_PARSE_MODE::PARSING_NEW_VARIABLE;
                        ParseExpectType();
                    }
                    else if(IsParsingType() == true)
                    {
                        OutputStandardErrorMessage(string("Unknown type: ") + CurrentToken.Contents, CurrentToken);
                    }
                    else
                    {
                        CopyUntilNextNewline();
                        ReduceLine();
                        State = PARSER_STATE::START_OF_LINE;
                    }
                }
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
        if(DoesSetContain(Path, IncludedFiles) == false)
        {
            if(DoesFileExist(Path) == false)
            {
                OutputStandardErrorMessage(string("Code file does not exist:  ") + Path, CurrentToken);
            }
            IncludedFiles.emplace(Path);
            Compiler NextCompiler;
            vector<Token> NewTokens = NextCompiler.GetTokens(Path);
            Tokens.insert(Tokens.begin() + Position + 1, NewTokens.begin(), NewTokens.end());
        }
        State = PARSER_STATE::START_OF_LINE;
        SavedUsingIdents.clear();
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
    else
    {
        if(PassMode == PASS_MODE::CLASS_SKIM)
        {
            BaseType NewClassBase;
            NewClassBase.Name = CurrentToken.Contents;
            if(PassMode == PASS_MODE::CLASS_SKIM)
            {
                if(TypeTableContains(CurrentToken.Contents) != false)
                {
                    OutputStandardErrorMessage(string("A class named ") + CurrentToken.Contents + string(" has already been declared."), CurrentToken);
                }
                else
                {
                    TypeTable.insert(pair<string,BaseType>(CurrentToken.Contents, NewClassBase));
                }
            }
        }
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
        if(PassMode == PASS_MODE::CLASS_SKIM)
        {
            CurrentClass.Type->InitializeBlankCompiledTemplate();
            CurrentClass.Type->IsTemplated = false;
        }
        CurrentClass.Templates = &CurrentClass.Type->CompiledTemplates.front();
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
        if(PassMode == PASS_MODE::CLASS_SKIM)
        {
            CurrentClass.Type->InitializeBlankCompiledTemplate();
            CurrentClass.Type->IsTemplated = false;
        }
        CurrentClass.Templates = &CurrentClass.Type->CompiledTemplates.front();
        CurrentClass.Templates->MyScope.Origin = SCOPE_ORIGIN::CLASS;
        CurrentClass.Templates->HasSizeBeenCalculated = true;
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
        if(PassMode == PASS_MODE::CLASS_SKIM)
        {
            if(DoesVectorContain(CurrentToken.Contents, CurrentClass.Type->PossibleTemplates) == false)
            {
                CurrentClass.Type->PossibleTemplates.push_back(CurrentToken.Contents);
            }
            else
            {
                OutputStandardErrorMessage(string("Class ") + CurrentClass.Type->Name + string(" already has template named ") + CurrentToken.Contents + string("."), CurrentToken);
            }
        }
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
        CurrentClass.Type->CompiledTemplates.front().Size = stoi(CurrentToken.Contents);
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
        if(PassMode == PASS_MODE::CLASS_SKIM)
        {
            Function NewFunction;
            NewFunction.IsAsm = IsAsmFunction;
            NewFunction.HasReturnObject = false;
            NewFunction.Name = CurrentToken.Contents;
            NewFunction.MyScope.Origin = SCOPE_ORIGIN::FUNCTION;
            NewFunction.LatestPassMode = PASS_MODE::CLASS_SKIM;
            string NextLabel = GetNextLabel();
            NewFunction.Label = NextLabel;
            GetCurrentScope()->Functions[CurrentToken.Contents].Functions.push_back(NewFunction);
            CurrentFunction = GetCurrentScope()->Functions[CurrentToken.Contents].GetLastFunction();
        }
        else
        {
            CurrentFunction = GetCurrentScope()->Functions[CurrentToken.Contents].GetFirstFunctionNotOfPassMode(PassMode);
        }
        ScopeStack.push_back(&CurrentFunction->MyScope);
        CurrentFunction->LatestPassMode = PassMode;

        if(PassMode == PASS_MODE::CLASS_SKIM)
        {
            if(CurrentClass.Type != NULL)
            {
                AddMeParameterToFunction();
            }
        }
        
        if(PassMode == PASS_MODE::FULL_PASS)
        {
            OutputAsm = OutputAsm + CurrentFunction->Label + GlobalKeywords.ReservedWords["COLON"];
            if(DEBUG == true)
            {
                OutputCurrentFunctionToAsm();
            }
            AppendNewlinesToOutputASM(2);
            if(CurrentFunction->IsAsm == false)
            {
                OutputAsm = OutputAsm + GlobalASM.CalcCreateStackFrameAsm();
                AppendNewlinesToOutputASM(2);
            }
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
        CurrentFunction->HasReturnObject = true;
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
    if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM && CurrentToken.Contents == GlobalKeywords.ReservedWords["RPAREN"])
    {
        State = PARSER_STATE::EXPECT_RETURNS_OR_LPAREN_OR_NEWLINE;
    }
    else if(IsValidIdent(CurrentToken.Contents) == true)
    {
        if(IsPassModeLowerOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
        {
            if(IsAType(CurrentToken.Contents) == true)
            {
                CurrentParsingType = GetType(CurrentToken.Contents);
            }
            else
            {
                OutputStandardErrorMessage(string("No type '") + CurrentToken.Contents + string("'."), CurrentToken);
            }
        }
        if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM || TypeMode == TYPE_PARSE_MODE::PARSING_NEW_VARIABLE)
        {
            State = PARSER_STATE::EXPECT_TEMPLATE_START_OR_IDENT;
        }
        else if(TypeMode == TYPE_PARSE_MODE::PARSING_RETURNS)
        {
            State = PARSER_STATE::EXPECT_TEMPLATE_START_OR_NEWLINE_OR_REFERENCE;
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
        if(IsPassModeHigherOrEqual(PASS_MODE::CLASS_SKIM) == true)
        {
            InitializeTemplateTokens();
        }
        else
        {
            ParseTemplates();
        }
        State = PARSER_STATE::EXPECT_VARIABLE_NAME;
    }
    else if(IsValidIdent(CurrentToken.Contents) == true)
    {
        // Go to the next part
        if(IsPassModeLowerOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
        {
            if(CurrentParsingType.Type->IsTemplated == true && CurrentParsingType.Templates->Templates.size() == 0)
            {
                OutputStandardErrorMessage(string("Type '") + CurrentParsingType.Type->Name + "' expects templates.", CurrentToken);
            }
        }
        ParseExpectVariableName();
    }
    else
    {
        OutputStandardErrorMessage(string("Expected '<' or valid variable name ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectTemplateStartOrNewlineOrReference()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        // At this point, parse the template
        if(IsPassModeHigherOrEqual(PASS_MODE::CLASS_SKIM) == true)
        {
            InitializeTemplateTokens();
        }
        else
        {
            ParseTemplates();
        }
        State = PARSER_STATE::EXPECT_RETURNS_NEWLINE_OR_REFERENCE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        ParseNewlineAtActionDeclarationEnd();
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["REFERENCE"])
    {
        CurrentFunction->ReturnObject.IsReference = true;
        State = PARSER_STATE::EXPECT_RETURNS_NEWLINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected '<' or 'reference' or newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseExpectTokenUntilEnd()
{
    if(DoesSetContain(CurrentToken.Contents, GlobalKeywords.ScopeCreateKeywords) == true)
    {
        ScopeStack.push_back(NULL);
    }
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["END"])
    {
        ScopeStack.pop_back();
    }
    if(GetCurrentScope() != NULL)
    {
        CurrentClass.Type = NULL;
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        DoPossibleTemplatedClassTokenCopy();
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
        else if(Tokens[Index].Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
        {
            OutputStandardErrorMessage(string("Hit newline while parsing template."), Tokens[Index]);
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
    StoredParsedTemplates.clear();
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
    if(StoredParsedTemplates.size() > 0)
    {
        OutputFullTemplatesToString(StoredParsedTemplates[0]);
    }
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
            NewType = GetType(TemplateTokens[TemplateTokenIndex].Contents);
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
            if(DoesTypeHaveTemplates(TypeTable[TemplateTokens[TemplateTokenIndex].Contents], StoredParsedTemplates) == false)
            {
                TypeTable[TemplateTokens[TemplateTokenIndex].Contents].InitializeBlankCompiledTemplate();
                
                CurrentParsingType.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
                CurrentParsingType.Templates = TypeTable[TemplateTokens[TemplateTokenIndex].Contents].GetLastCompiledTemplate();
                CurrentParsingType.Templates->MyScope.Origin = SCOPE_ORIGIN::CLASS;
                if(CurrentParsingType.Type->PossibleTemplates.size() != StoredParsedTemplates.size())
                {
                    OutputStandardErrorMessage(string("Type '") + TemplateTokens[TemplateTokenIndex].Contents + "' expects " +
                        to_string(CurrentParsingType.Type->PossibleTemplates.size()) + " templates not " + to_string(StoredParsedTemplates.size()) + ".", TemplateTokens[TemplateTokenIndex]);
                }
                CurrentParsingType.Templates->Templates = StoredParsedTemplates;
                
                // At this point compile the tokens of the templated class (CurrentParsingType.Type) with (CurrentClsas = CurrentParsingType).
            }
            else
            {
                CurrentParsingType.Templates = GetCompiledTemplate(TypeTable[TemplateTokens[TemplateTokenIndex].Contents], StoredParsedTemplates);
            }
            
            if(IsInputPassModeLowerOrEqual(CurrentParsingType.Templates->MostRecentPass, PassMode) == false)
            {
                CompileTemplatedCode(PassMode);
            }

            //TemplateTokens.erase(TemplateTokens.begin() + (TemplateTokenIndex + 2));
            TemplateTokens.erase(TemplateTokens.begin() + (TemplateTokenIndex + 1), TemplateTokens.begin() + (TemplateTokenIndex + 3));

            string TemplateVariable = GetNextTemplateVariable();
            TemplateTokens[TemplateTokenIndex].Contents = TemplateVariable;
            TemplateVariableTable.emplace(TemplateVariable, CurrentParsingType);
            StoredParsedTemplates.clear();
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
    Object * Variable = NULL;
    if(DoesMapContain(VariableName, ScopeStack[ScopeStack.size() - 1]->Objects) == true)
    {
        Variable = &ScopeStack[ScopeStack.size() - 1]->Objects[VariableName];
    }
    else
    {
        OutputStandardErrorMessage(string("No variable '") + VariableName + string("' found in current scope."), CurrentToken);
    }
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
    bool IsATemplate = false;
    bool Output = false;
    if(CurrentClass.Type != NULL)
    {
        if(CurrentClass.Type->IsTemplated == true)
        {
            if(DoesVectorContain(TypeName, CurrentClass.Type->PossibleTemplates) == true)
            {
                Output = true;
                IsATemplate = true;
            }
        }
    }
    if(IsATemplate == false && DoesMapContain(TypeName, TypeTable) == true)
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
        ParseNewlineAtActionDeclarationEnd();
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::EndCurrentScope()
{
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
        CurrentFunction->HasReturnObject = true;
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
        if(IsPassModeLowerOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
        {
            Object NewParamObject;
            NewParamObject.Name = CurrentToken.Contents;
            NewParamObject.Type = CurrentParsingType;
            NewParamObject.OuterScopeOrigin = GetCurrentScope()->Origin;
            if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM && PassMode == PASS_MODE::FUNCTION_SKIM)
            {
                NewParamObject.ReferenceOffset = GetNextParamOffset();
                NewParamObject.IsReference = true;
                GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                CurrentFunction->Parameters.push_back(&CurrentFunction->MyScope.Objects[NewParamObject.Name]);
            }
            else if(TypeMode == TYPE_PARSE_MODE::PARSING_NEW_VARIABLE)
            {
                if(IsClassScopeClosest() == true && PassMode == PASS_MODE::FUNCTION_SKIM)
                {
                    GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                    GetCurrentScope()->OrderedObjects.push_back(&GetCurrentScope()->Objects[NewParamObject.Name]);
                    CurrentParsingObject = &GetCurrentScope()->Objects[NewParamObject.Name];
                }
                else if(PassMode == PASS_MODE::FULL_PASS)
                {
                    if(IsParsingGlobalVariables == false)
                    {
                        GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                        GetCurrentScope()->OrderedObjects.push_back(&GetCurrentScope()->Objects[NewParamObject.Name]);
                        if(IsOriginCloserOrEqual(GetCurrentScope()->Origin, SCOPE_ORIGIN::FUNCTION) == true)
                        {
                            AddNewVariableToStack(GetCurrentScope()->Objects[NewParamObject.Name]);
                        }
                        else if(GetCurrentScope()->Origin == SCOPE_ORIGIN::GLOBAL)
                        {
                            GetCurrentScope()->Objects[NewParamObject.Name].GlobalName = GetNextGlobalVariable();
                            AddNewGlobalVariableToAsm(GetCurrentScope()->Objects[NewParamObject.Name]);
                        }
                    }
                    CurrentParsingObject = GetInAnyScope(NewParamObject.Name);
                    CurrentParsingType = CurrentParsingObject->Type;
                }
            }
        }
        if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM)
        {
            State = PARSER_STATE::EXPECT_COMMA_OR_RPAREN;
        }
        else if(TypeMode == TYPE_PARSE_MODE::PARSING_NEW_VARIABLE)
        {
            if(IsClassScopeClosest() == true)
            {
                State = PARSER_STATE::EXPECT_NEWLINE_AFTER_VARIABLE_DECLARATION;
            }
            else
            {
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
    if(IsPassModeHigherOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
    {
        if(PassMode == PASS_MODE::FUNCTION_SKIM)
        {
            Position = Position - 1;
            CopyUntilNextNewline();
            if(GetCurrentScope()->Origin == SCOPE_ORIGIN::GLOBAL)
            {
                GlobalVariableInitializeTokens.insert(GlobalVariableInitializeTokens.end(), ReduceTokens.begin(), ReduceTokens.end());
                Token NewToken;
                NewToken.Contents = GlobalKeywords.ReservedWords["NEW_LINE"];
                NewToken.LineNumber = CurrentToken.LineNumber;
                NewToken.SourceFileName = CurrentToken.SourceFileName;
                GlobalVariableInitializeTokens.push_back(NewToken);
            }
        }
    }
    else
    {
        if(GetCurrentScope()->Origin == SCOPE_ORIGIN::GLOBAL)
        {
            CopyUntilNextNewline();
        }
        else if(DoesSetContain(CurrentToken.Contents, GlobalKeywords.AfterDeclarationOperators) == true
        || CurrentToken.Contents == GlobalKeywords.ReservedWords["LPAREN"] || CurrentToken.Contents == GlobalKeywords.ReservedWords["COLON"])
        {
            JustDeclaredObject = true;
            if(DoesSetContain(CurrentToken.Contents, GlobalKeywords.AfterDeclarationOperators) == true)
            {
                CallEmptyConstructor();
                JustDeclaredObject = false;
            }
            Position = Position - 1;
            CopyUntilNextNewline();
            ReduceLine();
            JustDeclaredObject = false;
            CurrentParsingObject = NULL;
            CurrentParsingType.Templates = NULL;
        }
        else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
        {
            CallEmptyConstructor();
            CurrentParsingObject = NULL;
            CurrentParsingType.Templates = NULL;
            JustDeclaredObject = false;
        }
        else
        {
            OutputStandardErrorMessage(string("Expected newline or '='or '(' ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
        }
    }
    State = PARSER_STATE::START_OF_LINE;
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
    while(ReduceTokens.size() > 1)
    {
        OperateReduceTokens();
    }
}

void Parser::OperateReduceTokens()
{
    if(IsCurrentlyLeftParen() == true)
    {
        ReducePosition = ReducePosition + 1;
    }
    else if(IsUnaryOperator() == true)
    {
        DoUnaryOperator();
    }
    else if(IsUnaryOperatorInFarPosition() == true)
    {
        ReducePosition = ReducePosition + 2;
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
    else if(ReduceTokens.size() - ReducePosition <= 1)
    {
        ReducePosition = ReducePosition - 2;
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
    Scope * CallingScope = NULL;
    bool IsCallingObject = false;
    if(JustDeclaredObject == true)
    {
        if(ReduceTokens[ReducePosition].Contents != GlobalKeywords.ReservedWords["CONSTRUCTOR"])
        {
            if(ReducePosition >= 2 && ReduceTokens[ReducePosition - 1].Contents != GlobalKeywords.ReservedWords["COLON"])
            {
                ReduceTokens.insert(ReduceTokens.begin() + ReducePosition + 1, Token());
                ReduceTokens.insert(ReduceTokens.begin() + ReducePosition + 2, Token());
                ReduceTokens[ReducePosition + 1] = ReduceTokens[ReducePosition];
                ReduceTokens[ReducePosition + 2] = ReduceTokens[ReducePosition];
                ReduceTokens[ReducePosition + 1].Contents = GlobalKeywords.ReservedWords["COLON"];
                ReduceTokens[ReducePosition + 2].Contents = GlobalKeywords.ReservedWords["CONSTRUCTOR"];
                ReducePosition = ReducePosition + 2;
                JustDeclaredObject = false;
            }
        }
    }
    if(ReducePosition >= 2)
    {
        if(ReduceTokens[ReducePosition - 1].Contents == GlobalKeywords.ReservedWords["COLON"])
        {
            IsCallingObject = true;
            AddToArgList(ReducePosition - 2);
            CallingScope = &GetInAnyScope(ReduceTokens[ReducePosition - 2].Contents)->Type.Templates->MyScope;
            ReduceTokens.erase(ReduceTokens.begin() + ReducePosition - 2);
            ReduceTokens.erase(ReduceTokens.begin() + ReducePosition - 2);
            ReducePosition = ReducePosition - 2;
        }
    }
    if(IsCallingObject == false)
    {
        CallingScope = GetGlobalScope();
    }
    if(DoesMapContain(ReduceTokens[ReducePosition].Contents, CallingScope->Functions) == false)
    {
        OutputStandardErrorMessage(string("No function matching ") + OutputFunctionNameWithObjects(ReduceTokens[ReducePosition].Contents, Reverse(NextFunctionObjects)) + string("."),
            CurrentToken);
    }
    WantedFunction = GetFromFunctionList(CallingScope->Functions[ReduceTokens[ReducePosition].Contents], Reverse(NextFunctionObjects));
    CallFunction(*WantedFunction);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
}

void Parser::ReduceOperator()
{
    AddToArgList(ReducePosition + 2);
    AddToArgList(ReducePosition);
    CallFunction(*GetFromFunctionList(GetInAnyScope(ReduceTokens[ReducePosition].Contents)->Type.Templates->MyScope.Functions[ReduceTokens[ReducePosition + 1].Contents],
        Reverse(NextFunctionObjects)));
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
}

bool Parser::IsSingleVarInParens()
{
    bool Output = false;
    if(ReduceTokens[ReducePosition + 1].Contents == GlobalKeywords.ReservedWords["LPAREN"])
    {
        if(ReduceTokens.size() - ReducePosition >= 4)
        {
            if(ReduceTokens[ReducePosition + 3].Contents == GlobalKeywords.ReservedWords["RPAREN"]
                && IsValidIdent(ReduceTokens[ReducePosition + 2].Contents) == true)
            {
                Output = true;
            }
        }
    }
    return Output;
}

bool Parser::IsALeftParenInOperatorPosition()
{
    bool Output = false;
    if(ReduceTokens[ReducePosition + 1].Contents == GlobalKeywords.ReservedWords["LPAREN"])
    {
        Output = true;
    }
    else if(ReduceTokens.size() - ReducePosition >= 4)
    {
        if(ReduceTokens[ReducePosition + 3].Contents == GlobalKeywords.ReservedWords["LPAREN"])
        {
            Output = true;
        }
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
    NewObject.OuterScopeOrigin = GetCurrentScope()->Origin;
    NewObject.Name = GetNextTemporaryVariable();
    ReduceTokens[ReducePosition + 2].Contents = NewObject.Name;
    NewObject.Type = ScopeObject->Type;
    NewObject.Offset = CallingObject->Offset + OffsetShift;
    NewObject.IsReference = CallingObject->IsReference;
    NewObject.ReferenceOffset = CallingObject->ReferenceOffset;
    if(CallingObject->OuterScopeOrigin == SCOPE_ORIGIN::GLOBAL)
    {
        NewObject.IsReference = true;
        NewObject.GlobalName = CallingObject->GlobalName;
        NewObject.OuterScopeOrigin = SCOPE_ORIGIN::GLOBAL;
    }
    GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 0);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 0);
}

void Parser::AppendInitialASM()
{
    string LabelString = GetGlobalScope()->Functions[MAIN_FUNCTION_NAME].GetFirstFunction()->Label;
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
        FunctionPath = FunctionPath + OutputFullTemplatesToString(CurrentClass);
    }
    
    if(CurrentFunction != NULL)
    {
        FunctionPath = FunctionPath + GlobalKeywords.ReservedWords["COLON"] + CurrentFunction->Name;
    }
    OutputAsm = OutputAsm + FunctionPath;
}

void Parser::OutputDeclaringVariableToAsm(const Object & Variable)
{
    string Output = SPACE + SEMICOLON + SPACE;
    OutputAsm = OutputAsm + Output + string("Declaring ") + Variable.Name + string(" at offset ") + to_string(Variable.Offset)
        + string(" with Reference Offset = ") + to_string(Variable.ReferenceOffset);
}

void Parser::AddToArgList(const unsigned int InPosition)
{
    string VariableName = ReduceTokens[InPosition].Contents;
    Object * NextArg = NULL;
    if(IsNumber(VariableName) == true)
    {
        Object NumberObject;
        NumberObject.OuterScopeOrigin = GetCurrentScope()->Origin;
        NumberObject.Name = GetNextTemporaryVariable();
        ReduceTokens[InPosition].Contents = NumberObject.Name;
        NumberObject.Type.Type = &TypeTable["Integer"];
        NumberObject.Type.Templates = TypeTable["Integer"].GetFirstCompiledTemplate();
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
    int SpaceSize = NewObject.Type.Templates->Size;
    if(NewObject.IsReference == true)
    {
        SpaceSize = POINTER_SIZE;
    }
    OutputAsm = OutputAsm + GlobalASM.CalcReserveSpaceAsm(SpaceSize);
    MoveBackCurrentScopeOffset(NewObject);
    if(DEBUG == true)
    {
        OutputDeclaringVariableToAsm(NewObject);
    }
    AppendNewlinesToOutputASM(1);
}

void Parser::CallFunction(const Function & InFunction)
{
    AddExternalReturnValue(InFunction);
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
        if(NextFunctionObjects[Index]->IsReference == true)
        {
            OutputDereferenceCode(NextFunctionObjects[Index]);
            if(DEBUG == true)
            {
                OutputDerefReference(NextFunctionObjects[Index]->Name, NextFunctionObjects[Index]->ReferenceOffset);
            }
            AppendNewlinesToOutputASM(2);
            OutputAsm = OutputAsm + GlobalASM.CalcPushFromReference(NextFunctionObjects[Index]->Offset, POINTER_SIZE);
        }
        else
        {
            OutputNormalPushAsm(NextFunctionObjects[Index], POINTER_SIZE);
        }
        if(DEBUG == true)
        {
            OutputPushingReferenceToVariableToAsm(NextFunctionObjects[Index]->Name, NextFunctionObjects[Index]->Offset);
        }
        AppendNewlinesToOutputASM(2);
        GetCurrentScope()->Offset = GetCurrentScope()->Offset + POINTER_SIZE;
        Index = Index + 1;
    }
}

void Parser::OutputPushingReferenceToVariableToAsm(const string & VariableName, const int Offset)
{
    string Output = SPACE + SEMICOLON + SPACE;
    OutputAsm = OutputAsm + Output + string("Pushing reference to ") + VariableName + string(" from offset ") + to_string(Offset);
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
    OutputAsm = OutputAsm + Output + string("Calling ") + OutputFunctionNameWithObjects(InFunction.Name, InFunction.Parameters) + " " + InFunction.Label;
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
    if(NewObject.IsReference == true)
    {
        GetCurrentScope()->Offset = GetCurrentScope()->Offset - POINTER_SIZE;
        NewObject.ReferenceOffset = GetCurrentScope()->Offset;
    }
    else
    {
        GetCurrentScope()->Offset = GetCurrentScope()->Offset - NewObject.Type.Templates->Size;
        NewObject.Offset = GetCurrentScope()->Offset;
    }
}

void Parser::AddNumericalValueToTempInteger(const string & NewValue)
{
    OutputAsm = OutputAsm + GlobalASM.CalcIntegerQuickAssignAsm(stoi(NewValue));
    AppendNewlinesToOutputASM(1);
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
    
    cout << OutputString;
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
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Compiled Templates: \n";
    unsigned int Index = 0;
    while(Index < InType.CompiledTemplates.size())
    {
        OutputString = OutputString + OutputCompiledTemplateToString(GetInList(InType.CompiledTemplates, Index), InType, Level + 1);
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

string Parser::OutputCompiledTemplateToString(const CompiledTemplate & OutputCT, const BaseType & InType, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Size: " + to_string(OutputCT.Size) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Has size been calculated: " + to_string(OutputCT.HasSizeBeenCalculated) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    TemplatedType NewTT;
    NewTT.Type = (BaseType *) &InType;
    NewTT.Templates = (CompiledTemplate *) &OutputCT;
    
    OutputString = OutputString + "Recursive Template: " + OutputFullTemplatesToString(NewTT);
    
    OutputString = OutputString + NewTT.Type->Name;
    
    
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Scope:\n";
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
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Ordered Objects Size: " + to_string(OutputScope.OrderedObjects.size()) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Objects:\n";

    map<string, Object>::iterator Iterator;
    for (Iterator = OutputScope.Objects.begin(); Iterator != OutputScope.Objects.end(); Iterator++)
    {
        OutputString = OutputString + OutputObjectToString(Iterator->second, Level + 1);
    }
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Functions:\n";
    
    map<string, FunctionList>::iterator FuncIterator;
    for (FuncIterator = OutputScope.Functions.begin(); FuncIterator != OutputScope.Functions.end(); FuncIterator++)
    {
        unsigned int Index = 0;
        while(Index < FuncIterator->second.Functions.size())
        {
            OutputString = OutputString + OutputFunctionToString((Function &)GetInList(FuncIterator->second.Functions, Index), Level + 1);
            Index = Index + 1;
        }
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
    OutputString = OutputString + "Reference Offset: " + to_string(OutputObject.ReferenceOffset) + '\n';

    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Type: \n";

    OutputString = OutputString + OutputTemplatedTypeToString(OutputObject.Type, Level + 1);

    return OutputString;
}

string Parser::OutputTemplatedTypeToString(const TemplatedType & OutputTT, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Type: " + OutputFullTemplatesToString(OutputTT) + '\n';

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
    OutputString = OutputString + "Has Return Object: " + to_string(OutputFunction.HasReturnObject) + '\n';
    if(OutputFunction.HasReturnObject == true)
    {
        OutputString = OutputString + OutputTabsToString(Level);
        OutputString = OutputString + "Return Type: \n";
        OutputString = OutputString + OutputObjectToString(OutputFunction.ReturnObject, Level + 1);
    }
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Parameters: \n";

    unsigned int Index = 0;
    while(Index < OutputFunction.Parameters.size())
    {
        OutputString = OutputString + OutputObjectToString(*(OutputFunction.Parameters[Index]), Level + 1);
        Index = Index + 1;
    }
    return OutputString;
}

void Parser::OutputDerefReference(const string & VariableName, const int ReferenceOffset)
{
    string Output = SPACE + SEMICOLON + SPACE;
    OutputAsm = OutputAsm + Output + string("Dereferencing before push ") + VariableName + string(" from reference offset ") + to_string(ReferenceOffset)
        + string(" with Offset = ") + to_string(ReferenceOffset);
}

bool Parser::IsParsingType()
{
    bool Output = false;
    if(Tokens.size() - Position >= 1 && IsValidIdent(CurrentToken.Contents) == true)
    {
        if(Tokens[Position + 1].Contents == GlobalKeywords.ReservedWords["LESS_THAN"] || IsValidIdent(Tokens[Position + 1].Contents) == true)
        {
            Output = true;
        }
    }
    return Output;
}

void Parser::InitializePosition()
{
    Position = 0;
}

bool Parser::IsPassModeLowerOrEqual(const PASS_MODE InPassMode)
{
    bool Output = false;
    if(PassMode >= InPassMode)
    {
        Output = true;
    }
    return Output;
}


bool Parser::IsPassModeHigherOrEqual(const PASS_MODE InPassMode)
{
    bool Output = false;
    if(PassMode <= InPassMode)
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsLocalScopeToBeParsedNow()
{
    bool Output = false;
    if(PassMode == PASS_MODE::CLASS_SKIM)
    {
        if(GetCurrentScope()->Origin == SCOPE_ORIGIN::GLOBAL)
        {
            Output = true;
        }
    }
    else if(PassMode == PASS_MODE::FUNCTION_SKIM)
    {
        if(GetCurrentScope()->Origin == SCOPE_ORIGIN::CLASS || GetCurrentScope()->Origin == SCOPE_ORIGIN::GLOBAL)
        {
            Output = true;
        }
    }
    else
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsLocalScopeInOneLevelLow()
{
    bool Output = false;
    if(PassMode == PASS_MODE::CLASS_SKIM)
    {
        if(GetCurrentScope()->Origin == SCOPE_ORIGIN::GLOBAL || GetCurrentScope()->Origin == SCOPE_ORIGIN::CLASS)
        {
            Output = true;
        }
    }
    else if(PassMode == PASS_MODE::FUNCTION_SKIM)
    {
        if(GetCurrentScope()->Origin == SCOPE_ORIGIN::FUNCTION || GetCurrentScope()->Origin == SCOPE_ORIGIN::CLASS || GetCurrentScope()->Origin == SCOPE_ORIGIN::GLOBAL)
        {
            Output = true;
        }
    }
    else
    {
        Output = true;
    }
    return Output;
}

void Parser::InitializeForPass()
{
    InitializeForTemplatedPass();
    SavedUsingIdents.clear();
    CurrentFunction = NULL;
    CurrentClass.Type = NULL;
    CurrentParsingType.Type = NULL;
    IsAsmFunction = false;
    WasVariableFound = false;
    JustDeclaredObject = false;
    JustParsedActionLine = false;
    IsParsingGlobalVariables = false;
    EndPositionOfGlobalVarInitialization = 0;
}

void Parser::SetSizesAndOffsets()
{
    map<string, BaseType>::iterator Iterator;
    for (Iterator = TypeTable.begin(); Iterator != TypeTable.end(); Iterator++)
    {
        SizeType(Iterator->second);
    }
}

void Parser::SizeType(BaseType & InBaseType)
{
    unsigned int Index = 0;
    while(Index < InBaseType.CompiledTemplates.size())
    {
        if(GetInList(InBaseType.CompiledTemplates, Index).HasSizeBeenCalculated == false || &GetInList(InBaseType.CompiledTemplates, Index) == CurrentClass.Templates)
        {
            SizeCompiledTemplate(GetInList(InBaseType.CompiledTemplates, Index));
        }
        Index = Index + 1;
    }
}

void Parser::SizeCompiledTemplate(CompiledTemplate & InCompiledTemplate)
{
    InCompiledTemplate.HasSizeBeenCalculated = true;
    unsigned int Index = 0;
    InCompiledTemplate.MyScope.Offset = 0;
    while(Index < InCompiledTemplate.MyScope.OrderedObjects.size())
    {
        if(InCompiledTemplate.MyScope.OrderedObjects[Index]->Type.Templates->HasSizeBeenCalculated == false || InCompiledTemplate.MyScope.OrderedObjects[Index]->Type.Templates == CurrentClass.Templates)
        {
            SizeCompiledTemplate(*(InCompiledTemplate.MyScope.OrderedObjects[Index]->Type.Templates));
        }
        InCompiledTemplate.MyScope.OrderedObjects[Index]->Offset = InCompiledTemplate.MyScope.Offset;
        InCompiledTemplate.MyScope.Offset = InCompiledTemplate.MyScope.Offset + InCompiledTemplate.MyScope.OrderedObjects[Index]->Type.Templates->Size;
        InCompiledTemplate.Size = InCompiledTemplate.MyScope.Offset;
        Index = Index + 1;
    }
}

bool Parser::IsCurrentClassTemplated()
{
    bool Output = false;
    if(CurrentClass.Type != NULL)
    {
        Output = CurrentClass.Type->IsTemplated;
    }
    return Output;
}

void Parser::DoPossibleTemplatedClassTokenCopy()
{
    if(IsCurrentClassTemplated() == true)
    {
        if(PassMode == PASS_MODE::CLASS_SKIM)
        {
            CurrentClass.Type->Tokens.push_back(CurrentToken);
        }
    }
}

string Parser::OutputFullTemplatesToString(const TemplatedType & InTT)
{
    string Output;
    if(InTT.Type != NULL)
    {
        Output = Output + InTT.Type->Name;
        if(InTT.Type->IsTemplated == true)
        {
            Output = Output + GlobalKeywords.ReservedWords["LESS_THAN"];
            Output = Output + OutputFullCompiledTemplateVector(InTT.Templates->Templates);
            Output = Output + GlobalKeywords.ReservedWords["GREATER_THAN"];
        }
    }
    return Output;
}

bool Parser::DoesTypeHaveTemplates(const BaseType & InType, const vector<TemplatedType> & InTypes)
{
    bool Output = false;
    unsigned int Index = 0;
    while(Index < InType.CompiledTemplates.size())
    {
        bool IsValid = AreTemplateListsEqual(GetInList(InType.CompiledTemplates, Index).Templates, InTypes);
        if(IsValid == true)
        {
            Output = true;
        }
        Index = Index + 1;
    }
    return Output;
}

bool Parser::AreTemplateListsEqual(const vector<TemplatedType> & InTypes, const vector<TemplatedType> & InTypes2)
{
    bool IsValid = true;
    if(InTypes.size() != InTypes2.size())
    {
        IsValid = false;
    }
    unsigned int Index = 0;
    while(Index < InTypes.size() && IsValid == true)
    {
        if(InTypes[Index].Type != InTypes2[Index].Type && InTypes[Index].Templates != InTypes2[Index].Templates)
        {
            IsValid = false;
        }
        Index = Index + 1;
    }
    return IsValid;
}

void Parser::CompileTemplatedCode(PASS_MODE RunPassMode)
{
    TemplatedType OldCurrentClass = CurrentClass;
    Function * OldCurrentFunction = CurrentFunction;
    CurrentClass = CurrentParsingType;
    vector<Scope *> OldScopeStack = ScopeStack;
    ScopeStack.clear();
    ScopeStack.push_back(&GlobalScope);
    ScopeStack.push_back(&CurrentClass.Templates->MyScope);
    vector<Token> OldTokens = Tokens;
    vector<Token> OldTemplateTokens = TemplateTokens;
    PARSER_STATE OldState = State;
    unsigned int OldPosition = Position;
    bool OldHasToken = HasToken;
    TYPE_PARSE_MODE OldTypeMode = TypeMode;
    TemplateCompileStack.push_back(CurrentClass);
    string OldOutputAsm = OutputAsm;
    OutputAsm = "";
    unsigned int OldTemplateTokenIndex = TemplateTokenIndex;
    vector<TemplatedType> OldStoredParsedTemplates = StoredParsedTemplates;
    TemplatedType OldCurrentParsingType = CurrentParsingType;
    PASS_MODE OldPassMode = PassMode;
    list<Scope> OldControlStructureScopes = ControlStructureScopes;

    State = PARSER_STATE::START_OF_LINE;
    InitializePosition();
    HasToken = false;
    Tokens = CurrentClass.Type->Tokens;
    CurrentFunction = NULL;

    RunTemplatedPass(RunPassMode);

    TemplateCompileStack.pop_back();

    CurrentClass = OldCurrentClass;
    CurrentFunction = OldCurrentFunction;
    ScopeStack = OldScopeStack;
    Tokens = OldTokens;
    TemplateTokens = OldTemplateTokens;
    State = OldState;
    Position = OldPosition;
    HasToken = OldHasToken;
    TypeMode = OldTypeMode;
    TemplateOutputAsm = TemplateOutputAsm + OutputAsm;
    OutputAsm = OldOutputAsm;
    TemplateTokenIndex = OldTemplateTokenIndex;
    StoredParsedTemplates = OldStoredParsedTemplates;
    CurrentParsingType = OldCurrentParsingType;
    PassMode = OldPassMode;
    ControlStructureScopes = OldControlStructureScopes;
}

void Parser::RunAllPasses()
{
    PassMode = PASS_MODE::CLASS_SKIM;
    RunParse();

    PassMode = PASS_MODE::FUNCTION_SKIM;
    InitializeForPass();
    RunParse();
    SetSizesAndOffsets();

    PassMode = PASS_MODE::FULL_PASS;
    InitializeForPass();
    RunParse();
}

string Parser::OutputSingleLineSetToString(unordered_set<string> & InSet)
{
    string OutputString;
    unordered_set<string>::iterator Iterator;
    for (Iterator = InSet.begin(); Iterator != InSet.end(); Iterator++)
    {
        OutputString = OutputString + *Iterator + GlobalKeywords.ReservedWords["SPACE"];
    }
    return OutputString;
}

TemplatedType Parser::GetType(const string & InName)
{
    bool IsATemplate = false;
    TemplatedType Output;
    if(CurrentClass.Type != NULL)
    {
        if(CurrentClass.Type->IsTemplated == true)
        {
            int Location = LocationInVector(InName, CurrentClass.Type->PossibleTemplates);
            if(Location != NOT_FOUND_POSITION)
            {
                Output = CurrentClass.Templates->Templates[Location];
                IsATemplate = true;
            }
        }
    }
    if(IsATemplate == false && DoesMapContain(InName, TypeTable) == true)
    {
        Output.Type = &TypeTable[InName];
        Output.Templates = Output.Type->GetFirstCompiledTemplate();
    }
    return Output;
}

void Parser::InitializeForTemplatedPass()
{
    State = PARSER_STATE::START_OF_LINE;
    InitializePosition();
    HasToken = false;
}

void Parser::RunTemplatedPass(PASS_MODE RunPassMode)
{
    TemplatedType TemplatingType = CurrentParsingType;
    if(TemplatingType.Templates->IsNewCompiledTemplate == true)
    {
        PassMode = PASS_MODE::CLASS_SKIM;
        InitializeForTemplatedPass();
        RunParse();
        TemplatingType.Templates->IsNewCompiledTemplate = false;
    }
    unsigned int PassModeIndex = GetGlobalPassModeIndex(TemplatingType.Templates->MostRecentPass);
    PASS_MODE CurrentPass;
    while(PassModeIndex < GetGlobalPassModeIndex(RunPassMode))
    {
        PassModeIndex = PassModeIndex + 1;
        CurrentPass = GlobalPasses[PassModeIndex];
        TemplatingType.Templates->MostRecentPass = CurrentPass;
        PassMode = CurrentPass;
        InitializeForTemplatedPass();
        RunParse();
        if(PassMode == PASS_MODE::FUNCTION_SKIM)
        {
            SetSizesAndOffsets();
            DoPossiblyAddBigThree();
        }
        else if(PassMode == PASS_MODE::FULL_PASS)
        {
            DoPossiblyOutputBigThreeCode();
        }
    }
}

string Parser::OutputFullCompiledTemplateVector(const vector<TemplatedType> & TTs)
{
    string Output;
    unsigned int Index = 0;
    while(Index < TTs.size())
    {
        Output = Output + OutputFullTemplatesToString(TTs[Index]);
        if(Index != TTs.size() - 1)
        {
            Output = Output + ", ";
        }
        Index = Index + 1;
    }
    return Output;
}

void Parser::OutputTemplateAsm()
{
    OutputAsm = OutputAsm + TemplateOutputAsm;
}

CompiledTemplate * Parser::GetCompiledTemplate(BaseType & InType, vector<TemplatedType> & InTypes)
{
    CompiledTemplate * Output;
    bool Found = false;
    unsigned int Index = 0;
    while(Index < InType.CompiledTemplates.size() && Found == false)
    {
        bool IsValid = AreTemplateListsEqual(GetInList(InType.CompiledTemplates, Index).Templates, InTypes);
        if(IsValid == true)
        {
            Found = true;
            Output = &GetInList(InType.CompiledTemplates, Index);
        }
        Index = Index + 1;
    }
    return Output;
}

Function * Parser::GetFromFunctionList(const FunctionList & InList, const vector<Object *> InObjects)
{
    bool Found = false;
    unsigned int FoundPos = 0;
    unsigned int Index = 0;
    while(Index < InList.Functions.size() && Found == false)
    {
        if(DoesFunctionMatch(GetInList(InList.Functions, Index), InObjects) == true)
        {
            Found = true;
            FoundPos = Index;
        }
        Index = Index + 1;
    }
    if(Found == false)
    {
        OutputStandardErrorMessage(string("No function matching ") + OutputFunctionNameWithObjects(((FunctionList &) InList).GetFirstFunction()->Name, InObjects) + string(" in list."),
            CurrentToken);
    }
    return &GetInList(InList.Functions, FoundPos);
}

bool Parser::DoesFunctionMatch(const Function & InFunction, const vector<Object *> InObjects)
{
    bool IsMatch = true;
    if(InFunction.Parameters.size() != InObjects.size())
    {
        IsMatch = false;
    }
    else
    {
        unsigned int Index = 0;
        while(Index < InObjects.size() && IsMatch == true)
        {
            if(InFunction.Parameters[Index]->Type.Type != InObjects[Index]->Type.Type || InFunction.Parameters[Index]->Type.Templates != InObjects[Index]->Type.Templates)
            {
                IsMatch = false;
            }
            Index = Index + 1;
        }
    }
    return IsMatch;
}

string Parser::OutputFunctionNameWithObjects(const string & Name, const vector<Object *> InObjects)
{
    string Prototype;
    if(CurrentParsingType.Type != NULL)
    {
        Prototype = Prototype + CurrentParsingType.Type->Name;
        Prototype = Prototype + GlobalKeywords.ReservedWords["COLON"];
    }
    Prototype = Prototype + Name;
    Prototype = Prototype + GlobalKeywords.ReservedWords["LPAREN"];
    Prototype = Prototype + OutputFunctionParameters(InObjects);
    Prototype = Prototype + GlobalKeywords.ReservedWords["RPAREN"];
    return Prototype;
}

string Parser::OutputFunctionParameters(const vector<Object *> InObjects)
{
    string Parameters;
    unsigned int Index = 0;
    if(CurrentParsingType.Type != NULL)
    {
        Index = 1;
    }
    while(Index < InObjects.size())
    {
        Parameters = Parameters + OutputFullTemplatesToString(InObjects[Index]->Type);
        if(Index < InObjects.size() - 1)
        {
            Parameters = Parameters + GlobalKeywords.ReservedWords["COMMA"];
        }
        Index = Index + 1;
    }
    return Parameters;
}

string Parser::LinkAsm(const string & LinkAsm)
{
    string AsmCode = LinkAsm;
    map<string, string>::iterator Iterator;
    for(Iterator = GlobalKeywords.AsmLinkWords.begin(); Iterator != GlobalKeywords.AsmLinkWords.end(); Iterator++)
    {
        AsmCode = ReplaceLinkString(Iterator->second, AsmCode);
    }
    return AsmCode;
}

string Parser::ReplaceLinkString(const string & LinkString, const string & InAsmCode)
{
    string OutAsmCode = InAsmCode;
    size_t Found = OutAsmCode.find(LinkString);
    while(Found != std::string::npos)
    {
        Found = OutAsmCode.find(LinkString);
        OutAsmCode.erase(Found, LinkString.size());
        OutAsmCode.erase(Found, 1);
        string ParenOperand = OutAsmCode.substr(Found, OutAsmCode.find(GlobalKeywords.ReservedWords["RPAREN"], Found) - Found);
        OutAsmCode.erase(Found, ParenOperand.size());
        OutAsmCode.erase(Found, 1);
        OutAsmCode = PerformLinkStringAction(LinkString, OutAsmCode, Found, ParenOperand);
        Found = OutAsmCode.find(LinkString);
    }
    return OutAsmCode;
}

string Parser::PerformLinkStringAction(const string & LinkString, const string & InAsmCode, const size_t Found, const string & ParenOperand)
{
    string OutAsmCode = InAsmCode;
    if(LinkString == GlobalKeywords.AsmLinkWords["GET_SIZE_OF"])
    {
        TemplatedType SizeTT = GetType(ParenOperand);
        string SizeString = to_string(SizeTT.Templates->Size);
        OutAsmCode.insert(Found, SizeString);
    }
    else if(LinkString == GlobalKeywords.AsmLinkWords["GET_ACTION"])
    {
        FunctionList * CalledFunctionList;
        Function * CalledFunction;
        size_t ColonPosition = ParenOperand.find(GlobalKeywords.ReservedWords["COLON"]);
        if(ColonPosition != std::string::npos)
        {
            string ClassName = ParenOperand.substr(0, ColonPosition);
            string ActionName = ParenOperand.substr(ColonPosition + 1, ParenOperand.size() - (ColonPosition + 1));
            TemplatedType ClassTT = GetType(ClassName);
            CalledFunctionList = &ClassTT.Templates->MyScope.Functions[ActionName];
        }
        else
        {
            CalledFunctionList = &GetGlobalScope()->Functions[ParenOperand];
        }
        size_t RightParenPosition = OutAsmCode.find(GlobalKeywords.ReservedWords["RPAREN"], Found);
        string FunctionNumberString = OutAsmCode.substr(Found + 1, RightParenPosition - (Found + 1));
        unsigned int FunctionNumber = stoi(FunctionNumberString);
        CalledFunction = &GetInList(CalledFunctionList->Functions, FunctionNumber);
        OutAsmCode.erase(Found, RightParenPosition - Found + 1);
        OutAsmCode.insert(Found, CalledFunction->Label);
    }
    return OutAsmCode;
}

void Parser::ReturnAfterReduce()
{
    string VariableName = ReduceTokens[ReducePosition].Contents;
    Object * NextArg = GetInAnyScope(VariableName);
    NextFunctionObjects.push_back(NextArg);
    AddInternalReturnObject();
    CallFunction(*GetFromFunctionList(NextArg->Type.Templates->MyScope.Functions[GlobalKeywords.ReservedWords["EQUALS"]],
        Reverse(NextFunctionObjects)));
}

int Parser::GetReturnVariableOffset()
{
    int Offset = STACK_FRAME_SIZE + CurrentFunction->Parameters.size() * POINTER_SIZE;
    OutputAsm = OutputAsm + ";" + to_string(STACK_FRAME_SIZE) + " " + to_string(NextFunctionObjects.size()) + " " + to_string(POINTER_SIZE) + "\n";
    return Offset;
}

void Parser::ParseExpectWaitForEnd()
{
    if(IsWhiteSpace(CurrentToken.Contents) == false)
    {
        if(CurrentToken.Contents == GlobalKeywords.ReservedWords["END"])
        {
            ParseEndToken();
        }
        else
        {
            OutputStandardErrorMessage(string("Expected 'return' statement ") + InsteadErrorMessage(CurrentToken.Contents), CurrentToken);
        }
    }
}

void Parser::ParseEndToken()
{
    DoPossiblyCallDestructors();
    State = PARSER_STATE::EXPECT_NEWLINE_AFTER_END;
    if(PassMode == PASS_MODE::FULL_PASS)
    {
        if(IsLocalScopeInOneLevelLow() == true)
        {
            if(GetCurrentScope()->Origin == SCOPE_ORIGIN::FUNCTION)
            {
                if(CurrentFunction->IsAsm == false)
                {
                    OutputAsm = OutputAsm + GlobalASM.CalcDestroyStackFrameAsm();
                    AppendNewlinesToOutputASM(2);
                }
                OutputAsm = OutputAsm + GlobalASM.CalcRetAsm();
                AppendNewlinesToOutputASM(2);
            }
        }
    }
    else if(PassMode == PASS_MODE::FUNCTION_SKIM)
    {
        if(GetCurrentScope()->Origin == SCOPE_ORIGIN::CLASS)
        {
            SizeCompiledTemplate(*CurrentClass.Templates);
        }
    }
    ProcessEndScope();
}

void Parser::AddExternalReturnValue(const Function & InFunction)
{
    if(InFunction.HasReturnObject == true)
    {
        Object NewObject;
        NewObject.OuterScopeOrigin = GetCurrentScope()->Origin;
        NewObject.Name = GetNextTemporaryVariable();
        NewObject.Type = InFunction.ReturnObject.Type;
        NewObject.IsReference = InFunction.ReturnObject.IsReference;
        GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
        AddNewVariableToStack(GetCurrentScope()->Objects[NewObject.Name]);
        ReduceTokens[ReducePosition].Contents = NewObject.Name;
    }
}

void Parser::AddInternalReturnObject()
{
    Object NewObject;
    NewObject.OuterScopeOrigin = GetCurrentScope()->Origin;
    NewObject.Name = GetNextTemporaryVariable();
    NewObject.Type = CurrentFunction->ReturnObject.Type;
    int ReturnOffset = GetReturnVariableOffset();
    NewObject.Offset = ReturnOffset;
    GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
    NextFunctionObjects.push_back(GetInAnyScope(NewObject.Name));
}

void Parser::ParseExpectUntilOrWhile()
{
    if(IsValidRepeatType(CurrentToken.Contents) == true)
    {
        Scope NewScope;
        NewScope.Offset = GetCurrentScope()->Offset;
        NewScope.Origin = SCOPE_ORIGIN::REPEAT;
        ControlStructureScopes.push_back(NewScope);
        ScopeStack.push_back(&GetInList(ControlStructureScopes, ControlStructureScopes.size() - 1));
        
        Position = Position + 1;
        CopyUntilNextNewline();
        if(IsLocalScopeToBeParsedNow() == true)
        {
            GetCurrentScope()->ControlStructureBeginLabel = GetNextLabel();
            GetCurrentScope()->ControlStructureEndLabel = GetNextLabel();
            OutputAsm = OutputAsm + GetCurrentScope()->ControlStructureBeginLabel + GlobalKeywords.ReservedWords["COLON"];
            AppendNewlinesToOutputASM(2);
            
            ReduceLine();
            
            GetCurrentScope()->AfterTestOffset = GetCurrentScope()->Offset;
            
            OutputAsm = OutputAsm + GlobalASM.Codes["TEST_BOOLEAN_P1"];
            AppendNewlinesToOutputASM(1);
            OutputAsm = OutputAsm + GlobalASM.Codes["TEST_BOOLEAN_P2"];
            AppendNewlinesToOutputASM(1);
            if(CurrentToken.Contents == GlobalKeywords.ReservedWords["UNTIL"])
            {
                OutputAsm = OutputAsm + GlobalASM.Codes["JUMP_TRUE"] + GetCurrentScope()->ControlStructureEndLabel;
            }
            else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["WHILE"])
            {
                OutputAsm = OutputAsm + GlobalASM.Codes["JUMP_FALSE"] + GetCurrentScope()->ControlStructureEndLabel;
            }
            AppendNewlinesToOutputASM(2);
        }
    }
    else
    {
        OutputStandardErrorMessage(string("Expected 'until' or 'while' in repeat statement ") + InsteadErrorMessage(CurrentToken.Contents), CurrentToken);
    }
    State = PARSER_STATE::START_OF_LINE;
}

void Parser::DoPossibleControlStructureErase()
{
    if(GetCurrentScope()->IsControlStructureScope() == true)
    {
        ControlStructureScopes.pop_back();
    }
}

bool Parser::IsValidRepeatType(const string & InToken)
{
    bool Output = false;
    if(InToken == GlobalKeywords.ReservedWords["UNTIL"] || InToken == GlobalKeywords.ReservedWords["WHILE"])
    {
        Output = true;
    }
    return Output;
}

void Parser::DoPossibleControlStructureOutput()
{
    if(IsLocalScopeInOneLevelLow() == true)
    {
        if(GetCurrentScope()->Origin == SCOPE_ORIGIN::REPEAT)
        {
            OutputAsm = OutputAsm + GlobalASM.Codes["SHIFT_UP_ASM"] + to_string(-(GetCurrentScope()->Offset - ScopeStack[ScopeStack.size() - 2]->Offset));
            AppendNewlinesToOutputASM(1);
            OutputAsm = OutputAsm + GlobalASM.Codes["UNCONDITIONAL_JUMP"] + GetCurrentScope()->ControlStructureBeginLabel;
            AppendNewlinesToOutputASM(1);
            OutputAsm = OutputAsm + GetCurrentScope()->ControlStructureEndLabel + GlobalKeywords.ReservedWords["COLON"];
            AppendNewlinesToOutputASM(1);
            OutputAsm = OutputAsm + GlobalASM.Codes["SHIFT_UP_ASM"] + to_string(-(GetCurrentScope()->AfterTestOffset - ScopeStack[ScopeStack.size() - 2]->Offset));
            AppendNewlinesToOutputASM(1);
        }
        else if(GetCurrentScope()->Origin == SCOPE_ORIGIN::IF)
        {
            OutputAsm = OutputAsm + GlobalASM.Codes["SHIFT_UP_ASM"] + to_string(-(GetCurrentScope()->Offset - ScopeStack[ScopeStack.size() - 2]->Offset));
            AppendNewlinesToOutputASM(1);
            OutputAsm = OutputAsm + GetCurrentScope()->ControlStructureBeginLabel + GlobalKeywords.ReservedWords["COLON"];
            AppendNewlinesToOutputASM(1);
            OutputAsm = OutputAsm + GetCurrentScope()->ControlStructureEndLabel + GlobalKeywords.ReservedWords["COLON"];
            AppendNewlinesToOutputASM(1);
        }
    }
}

void Parser::ProcessEndScope()
{
    DoPossibleDeleteFunctionScope();
    DoPossibleDeleteClassScope();
    DoPossibleControlStructureOutput();
    DoPossibleControlStructureErase();
    EndCurrentScope();
}

void Parser::DoPossibleDeleteFunctionScope()
{
    if(GetCurrentScope()->Origin == SCOPE_ORIGIN::FUNCTION)
    {
        CurrentFunction = NULL;
    }
}

void Parser::DoPossibleDeleteClassScope()
{
    if(GetCurrentScope()->Origin == SCOPE_ORIGIN::CLASS)
    {
        if(PassMode == PASS_MODE::FUNCTION_SKIM)
        {
            DoPossiblyAddBigThree();
        }
        else if(PassMode == PASS_MODE::FULL_PASS)
        {
            DoPossiblyOutputBigThreeCode();
        }
        CurrentClass.Type = NULL;
        CurrentClass.Templates = NULL;
    }
}

bool Parser::IsOriginCloserOrEqual(const SCOPE_ORIGIN InOrigin, const SCOPE_ORIGIN TopOrigin)
{
    bool Output = false;
    if(InOrigin >= TopOrigin)
    {
        Output = true;
    }
    return Output;
}

void Parser::ParseIfStatement()
{
    Scope NewScope;
    NewScope.Offset = GetCurrentScope()->Offset;
    NewScope.Origin = SCOPE_ORIGIN::IF;
    ControlStructureScopes.push_back(NewScope);
    ScopeStack.push_back(&GetInList(ControlStructureScopes, ControlStructureScopes.size() - 1));
    if(IsLocalScopeToBeParsedNow() == true)
    {
        GetCurrentScope()->ControlStructureEndLabel = GetNextLabel();
        ParseNewIfComponent();
    }
    State = PARSER_STATE::START_OF_LINE;
}

void Parser::ParseElseIfStatement()
{
    if(IsLocalScopeToBeParsedNow() == true)
    {
        OutputEndControlStructureAsm();
    }
    
    ParseNewIfComponent();
}

void Parser::ParseNewIfComponent()
{
    
    Position = Position + 1;
    CopyUntilNextNewline();
    if(IsLocalScopeToBeParsedNow() == true)
    {
        GetCurrentScope()->ControlStructureBeginLabel = GetNextLabel();
        ReduceLine();
        GetCurrentScope()->AfterTestOffset = GetCurrentScope()->Offset;
        
        OutputAsm = OutputAsm + GlobalASM.Codes["TEST_BOOLEAN_P1"];
        AppendNewlinesToOutputASM(1);
        OutputAsm = OutputAsm + GlobalASM.Codes["SHIFT_UP_ASM"] + to_string(-(GetCurrentScope()->AfterTestOffset - ScopeStack[ScopeStack.size() - 2]->Offset));
        AppendNewlinesToOutputASM(1);
        OutputAsm = OutputAsm + GlobalASM.Codes["TEST_BOOLEAN_P2"];
        AppendNewlinesToOutputASM(1);
        GetCurrentScope()->Offset = GetCurrentScope()->Offset + -(GetCurrentScope()->AfterTestOffset - ScopeStack[ScopeStack.size() - 2]->Offset);
        OutputAsm = OutputAsm + GlobalASM.Codes["JUMP_FALSE"] + GetCurrentScope()->ControlStructureBeginLabel;
        AppendNewlinesToOutputASM(2);
    }
}

void Parser::ParseElseStatement()
{
    if(IsLocalScopeToBeParsedNow() == true)
    {
        OutputEndControlStructureAsm();
    }
    
}

void Parser::OutputEndControlStructureAsm()
{
    OutputAsm = OutputAsm + GlobalASM.Codes["SHIFT_UP_ASM"] + to_string(-(GetCurrentScope()->Offset - ScopeStack[ScopeStack.size() - 2]->Offset));
    AppendNewlinesToOutputASM(1);
    GetCurrentScope()->Offset = ScopeStack[ScopeStack.size() - 2]->Offset;
    OutputAsm = OutputAsm + GlobalASM.Codes["UNCONDITIONAL_JUMP"] + GetCurrentScope()->ControlStructureEndLabel;
    AppendNewlinesToOutputASM(1);
    OutputAsm = OutputAsm + GetCurrentScope()->ControlStructureBeginLabel + GlobalKeywords.ReservedWords["COLON"];
    AppendNewlinesToOutputASM(1);
    GetCurrentScope()->AfterTestOffset = ScopeStack[ScopeStack.size() - 2]->Offset;
}

void Parser::ParseExpectReturnsNewlineOrReference()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["REFERENCE"])
    {
        CurrentFunction->ReturnObject.IsReference = true;
        State = PARSER_STATE::EXPECT_RETURNS_NEWLINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        ParseNewlineAtActionDeclarationEnd();
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline or 'reference' ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}

void Parser::ParseNewlineAtActionDeclarationEnd()
{
    CurrentFunction->ReturnObject.Type = CurrentParsingType;
    State = PARSER_STATE::START_OF_LINE;
}

void Parser::DoPossiblyAddBigThree()
{
    DoPossiblyAddEmptyConstructor();
    DoPossiblyAddCopyConstructor();
    DoPossiblyAddAssignmentOperator();
    DoPossiblyAddEmptyDestructor();
}

bool Parser::DoesFunctionListContain(const FunctionList & InList, const vector<Object *> & InObjects)
{
    bool Found = false;
    unsigned int Index = 0;
    while(Index < InList.Functions.size() && Found == false)
    {
        if(DoesFunctionMatch(GetInList(InList.Functions, Index), InObjects) == true)
        {
            Found = true;
        }
        Index = Index + 1;
    }
    return Found;
}

bool Parser::DoPossiblyAddAutoGenerateFunction()
{
    bool DidUserOverloadFunction = true;
    if(DoesMapContain(AutoGenerateFunctionName, CurrentClass.Templates->MyScope.Functions) == false)
    {
        DidUserOverloadFunction = false;
        DoAddAutoGenerateFunction();
    }
    else
    {
        if(DoesFunctionListContain(CurrentClass.Templates->MyScope.Functions[AutoGenerateFunctionName], AutoGenerateFunctionParameters) == false)
        {
            DidUserOverloadFunction = false;
            DoAddAutoGenerateFunction();
        }
    }
    return DidUserOverloadFunction;
}

void Parser::DoAddAutoGenerateFunction()
{
    Function NewFunction;
    NewFunction.IsAsm = false;
    NewFunction.HasReturnObject = false;
    NewFunction.Name = AutoGenerateFunctionName;
    NewFunction.MyScope.Origin = SCOPE_ORIGIN::FUNCTION;
    NewFunction.LatestPassMode = PASS_MODE::FUNCTION_SKIM;
    string NextLabel = GetNextLabel();
    NewFunction.Label = NextLabel;
    GetCurrentScope()->Functions[AutoGenerateFunctionName].Functions.push_back(NewFunction);
    CurrentFunction = GetCurrentScope()->Functions[AutoGenerateFunctionName].GetLastFunction();
    ScopeStack.push_back(&(CurrentFunction->MyScope));
    CopyAutoGenerateParametersToFunction();
    ScopeStack.pop_back();
    CurrentFunction = NULL;
}

void Parser::CallAllSubObjectsAutoGenerateFunctions()
{
    map<string, Object>::const_iterator Iterator;
    for(Iterator = CurrentClass.Templates->MyScope.Objects.begin(); Iterator != CurrentClass.Templates->MyScope.Objects.end(); Iterator++)
    {
        CallObjectAutoGenerateFunction(Iterator->second);
    }
}

void Parser::CallObjectAutoGenerateFunction(const Object & InObject)
{
    Object * CallingObject = GetInAnyScope(GlobalKeywords.ReservedWords["ME"]);
    unsigned int OffsetShift = InObject.Offset;
    Object NewObject;
    NewObject.OuterScopeOrigin = GetCurrentScope()->Origin;
    NewObject.Name = GetNextTemporaryVariable();
    NewObject.Type = InObject.Type;
    NewObject.Offset = CallingObject->Offset + OffsetShift;
    NewObject.IsReference = true;
    NewObject.ReferenceOffset = CallingObject->ReferenceOffset;
    GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
    
    NextFunctionObjects.push_back(GetInAnyScope(NewObject.Name));
    
    if(CurrentFunction->Parameters.size() >= 2)
    {
        Object * CallingObject = GetInAnyScope(GlobalKeywords.ReservedWords["SOURCE"]);
        unsigned int OffsetShift = InObject.Offset;
        Object NewObject;
        NewObject.OuterScopeOrigin = GetCurrentScope()->Origin;
        NewObject.Name = GetNextTemporaryVariable();
        NewObject.Type = InObject.Type;
        NewObject.Offset = CallingObject->Offset + OffsetShift;
        NewObject.IsReference = true;
        NewObject.ReferenceOffset = CallingObject->ReferenceOffset;
        GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
        
        NextFunctionObjects.push_back(GetInAnyScope(NewObject.Name));
    }
    
    Function * WantedFunction = GetFromFunctionList(InObject.Type.Templates->MyScope.Functions[CurrentFunction->Name], NextFunctionObjects);
    CallFunction(*WantedFunction);
}

void Parser::CopyAutoGenerateParametersToFunction()
{
    AutoGenerateFunctionParameters = Reverse(AutoGenerateFunctionParameters);
    unsigned int Index = 0;
    while(Index < AutoGenerateFunctionParameters.size())
    {
        AutoGenerateFunctionParameters[Index]->ReferenceOffset = GetNextParamOffset();
        GetCurrentScope()->Objects.emplace(AutoGenerateFunctionParameters[Index]->Name, *AutoGenerateFunctionParameters[Index]);
        CurrentFunction->Parameters.push_back(&GetCurrentScope()->Objects[AutoGenerateFunctionParameters[Index]->Name]);
        Index = Index + 1;
    }
}

void Parser::DoPossiblyOutputBigThreeCode()
{
    DoPossiblyOutputEmptyConstructorCode();
    DoPossiblyOutputCopyConstructorCode();
    DoPossiblyOutputAssignmentOperatorCode();
    DoPossiblyOutputEmptyDestructorCode();
}

void Parser::DoPossiblyOutputEmptyConstructorCode()
{
    if(CurrentClass.Templates->HasUserDefinedEmptyConstructor == false)
    {
        AutoGenerateFunctionName = GlobalKeywords.ReservedWords["CONSTRUCTOR"];
        OutputAutoGenerateFunctionCode();
    }
}

void Parser::OutputAutoGenerateFunctionCode()
{
    CurrentFunction = CurrentClass.Templates->MyScope.Functions[AutoGenerateFunctionName].GetFirstFunctionNotOfPassMode(PassMode);
    ScopeStack.push_back(&CurrentFunction->MyScope);
    
    OutputAsm = OutputAsm + CurrentFunction->Label + GlobalKeywords.ReservedWords["COLON"];
    if(DEBUG == true)
    {
        OutputCurrentFunctionToAsm();
    }
    AppendNewlinesToOutputASM(2);
    OutputAsm = OutputAsm + GlobalASM.CalcCreateStackFrameAsm();
    AppendNewlinesToOutputASM(2);
    
    CallAllSubObjectsAutoGenerateFunctions();
    
    OutputAsm = OutputAsm + GlobalASM.CalcDestroyStackFrameAsm();
    AppendNewlinesToOutputASM(2);
    
    OutputAsm = OutputAsm + GlobalASM.CalcRetAsm();
    AppendNewlinesToOutputASM(2);
    
    ScopeStack.pop_back();
    CurrentFunction->LatestPassMode = PassMode;
    CurrentFunction = NULL;
}

Object Parser::CreateReferenceObject(const string & VariableName, const TemplatedType & InTT)
{
    Object NewObject;
    NewObject.OuterScopeOrigin = GetCurrentScope()->Origin;
    NewObject.Name = VariableName;
    NewObject.Type = InTT;
    NewObject.IsReference = true;
    return NewObject;
}

void Parser::AddMeParameterToFunction()
{
    Object NewObject = CreateCurrentClassObject(GlobalKeywords.ReservedWords["ME"]);
    NewObject.ReferenceOffset = GetNextParamOffset();
    GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
    CurrentFunction->Parameters.push_back(&GetCurrentScope()->Objects[NewObject.Name]);
}

void Parser::DoPossiblyAddEmptyConstructor()
{
    AutoGenerateFunctionName = GlobalKeywords.ReservedWords["CONSTRUCTOR"];
    Object MeObject = CreateCurrentClassObject(GlobalKeywords.ReservedWords["ME"]);
    AutoGenerateFunctionParameters.push_back(&MeObject);
    CurrentClass.Templates->HasUserDefinedEmptyConstructor = DoPossiblyAddAutoGenerateFunction();
    AutoGenerateFunctionParameters.clear();
}

void Parser::DoPossiblyAddCopyConstructor()
{
    AutoGenerateFunctionName = GlobalKeywords.ReservedWords["CONSTRUCTOR"];
    Object MeObject = CreateCurrentClassObject(GlobalKeywords.ReservedWords["ME"]);
    AutoGenerateFunctionParameters.push_back(&MeObject);
    Object SourceObject = CreateCurrentClassObject(GlobalKeywords.ReservedWords["SOURCE"]);
    AutoGenerateFunctionParameters.push_back(&SourceObject);
    CurrentClass.Templates->HasUserDefinedCopyConstructor = DoPossiblyAddAutoGenerateFunction();
    AutoGenerateFunctionParameters.clear();
}

void Parser::DoPossiblyAddAssignmentOperator()
{
    AutoGenerateFunctionName = GlobalKeywords.ReservedWords["EQUALS"];
    Object MeObject = CreateCurrentClassObject(GlobalKeywords.ReservedWords["ME"]);
    AutoGenerateFunctionParameters.push_back(&MeObject);
    Object SourceObject = CreateCurrentClassObject(GlobalKeywords.ReservedWords["SOURCE"]);
    AutoGenerateFunctionParameters.push_back(&SourceObject);
    CurrentClass.Templates->HasUserDefinedAssignmentOperator = DoPossiblyAddAutoGenerateFunction();
    AutoGenerateFunctionParameters.clear();
}

void Parser::DoPossiblyAddEmptyDestructor()
{
    AutoGenerateFunctionName = GlobalKeywords.ReservedWords["DESTRUCTOR"];
    Object MeObject = CreateCurrentClassObject(GlobalKeywords.ReservedWords["ME"]);
    AutoGenerateFunctionParameters.push_back(&MeObject);
    CurrentClass.Templates->HasUserDefinedDestructor = DoPossiblyAddAutoGenerateFunction();
    AutoGenerateFunctionParameters.clear();
}

void Parser::DoPossiblyOutputCopyConstructorCode()
{
    if(CurrentClass.Templates->HasUserDefinedCopyConstructor == false)
    {
        AutoGenerateFunctionName = GlobalKeywords.ReservedWords["CONSTRUCTOR"];
        OutputAutoGenerateFunctionCode();
    }
}

void Parser::DoPossiblyOutputAssignmentOperatorCode()
{
    if(CurrentClass.Templates->HasUserDefinedAssignmentOperator == false)
    {
        AutoGenerateFunctionName = GlobalKeywords.ReservedWords["EQUALS"];
        OutputAutoGenerateFunctionCode();
    }
}

void Parser::DoPossiblyOutputEmptyDestructorCode()
{
    if(CurrentClass.Templates->HasUserDefinedDestructor == false)
    {
        AutoGenerateFunctionName = GlobalKeywords.ReservedWords["DESTRUCTOR"];
        OutputAutoGenerateFunctionCode();
    }
}

void Parser::CallEmptyConstructor()
{
    NextFunctionObjects.push_back(CurrentParsingObject);
    Function * WantedFunction = GetFromFunctionList(CurrentParsingType.Templates->MyScope.Functions[GlobalKeywords.ReservedWords["CONSTRUCTOR"]], Reverse(NextFunctionObjects));
    CallFunction(*WantedFunction);
    NextFunctionObjects.clear();
}

Object Parser::CreateCurrentClassObject(const string & VariableName)
{
    return CreateReferenceObject(VariableName, CurrentClass);
}

void Parser::CallEmptyDestructorsForCurrentScope()
{
    CallEmptyDestructors(Reverse(GetCurrentScope()->OrderedObjects));
}

void Parser::CallEmptyDestructors(vector<Object *> OrderedObjects)
{
    unsigned int Index = 0;
    while(Index < OrderedObjects.size())
    {
        CallEmptyDestructor(OrderedObjects[Index]);
        Index = Index + 1;
    }
}

void Parser::CallEmptyDestructor(Object * InObject)
{
    NextFunctionObjects.push_back(InObject);
    Function * WantedFunction = GetFromFunctionList(InObject->Type.Templates->MyScope.Functions[GlobalKeywords.ReservedWords["DESTRUCTOR"]], Reverse(NextFunctionObjects));
    CallFunction(*WantedFunction);
    NextFunctionObjects.clear();
}

void Parser::DoPossiblyCallDestructors()
{
    if(CurrentFunction != NULL)
    {
        if(CurrentFunction->IsAsm == false)
        {
            if(PassMode == PASS_MODE::FULL_PASS)
            {
                CallEmptyDestructorsForCurrentScope();
                if(CurrentFunction->Name == MAIN_FUNCTION_NAME)
                {
                    CallEmptyDestructorsForGlobalScope();
                }
            }
        }
    }
}

void Parser::AddNewGlobalVariableToAsm(const Object & InObject)
{
    GlobalVariableReserveAsm = GlobalVariableReserveAsm + InObject.GlobalName + GlobalASM.Codes["RESERVE_BYTES"] +
        to_string(InObject.Type.Templates->Size);
    GlobalVariableReserveAsm = GlobalVariableReserveAsm + GetNewlines(1);
}

void Parser::AppendGlobalVariableAsmToOutputAsm()
{
    GlobalVariableReserveAsm = GlobalASM.Codes["START_OF_GLOBAL_VARIABLES"] + GetNewlines(1) + GlobalVariableReserveAsm;
    OutputAsm = GlobalVariableReserveAsm + GetNewlines(2) + OutputAsm;
}

void Parser::AppendExecutableSectionAsmToOutputAsm()
{
    OutputAsm = GlobalASM.Codes["START_OF_CODE"] + GetNewlines(2) + OutputAsm;
}

string Parser::GetNextGlobalVariable()
{
    string NextGlobalVariable = GLOBAL_VARIABLE_PREFIX + to_string(GlobalVariableCounter);
    GlobalVariableCounter = GlobalVariableCounter + 1;
    return NextGlobalVariable;
}

void Parser::OutputDereferenceCode(const Object * InObject)
{
    if(InObject->OuterScopeOrigin == SCOPE_ORIGIN::GLOBAL)
    {
        OutputAsm = OutputAsm + GlobalASM.CalcGlobalDerefForFuncCall(InObject->GlobalName);
    }
    else
    {
        OutputAsm = OutputAsm + GlobalASM.CalcDerefForFuncCall(InObject->ReferenceOffset);
    }
}

void Parser::OutputNormalPushAsm(const Object * InObject, const int ObjectSize)
{
    if(InObject->OuterScopeOrigin == SCOPE_ORIGIN::GLOBAL)
    {
        OutputAsm = OutputAsm + GlobalASM.CalcPushFromGlobal(InObject->GlobalName, ObjectSize);
        AppendNewlinesToOutputASM(1);
    }
    else
    {
        OutputAsm = OutputAsm + GlobalASM.CalcPushFromBasePointer(InObject->Offset, ObjectSize);
    }
}

void Parser::CallEmptyDestructorsForGlobalScope()
{
    CallEmptyDestructors(Reverse(GetGlobalScope()->OrderedObjects));
}

bool Parser::IsUnaryOperator()
{
    bool Output = false;
    if(DoesSetContain(ReduceTokens[ReducePosition].Contents, GlobalKeywords.UnaryOperators) == true)
    {
        Output = true;
    }
    return Output;
}

bool Parser::IsUnaryOperatorInFarPosition()
{
    bool Output = false;
    if(ReduceTokens.size() - ReducePosition > 3)
    {
        if(DoesSetContain(ReduceTokens[ReducePosition + 2].Contents, GlobalKeywords.UnaryOperators) == true)
        {
            Output = true;
        }
    }
    return Output;
}

void Parser::DoUnaryOperator()
{
    AddToArgList(ReducePosition + 1);
    CallFunction(*GetFromFunctionList(GetInAnyScope(ReduceTokens[ReducePosition + 1].Contents)->Type.Templates->MyScope.Functions[ReduceTokens[ReducePosition].Contents],
        Reverse(NextFunctionObjects)));
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition);
}

bool Parser::IsInputPassModeLowerOrEqual(const PASS_MODE InPassMode, const PASS_MODE BasePassMode)
{
    bool Output = false;
    if(InPassMode >= BasePassMode)
    {
        Output = true;
    }
    return Output;
}

unsigned int Parser::GetGlobalPassModeIndex(const PASS_MODE InPassMode)
{
    unsigned int Index = 0;
    bool Found = false;
    while(Found == false)
    {
        if(InPassMode == GlobalPasses[Index])
        {
            Found = true;
        }
        else
        {
            Index = Index + 1;
        }
    }
    return Index;
}

bool Parser::IsInputPassModeHigherOrEqual(const PASS_MODE InPassMode, const PASS_MODE BasePassMode)
{
    bool Output = false;
    if(InPassMode <= BasePassMode)
    {
        Output = true;
    }
    return Output;
}

void Parser::InitializeGlobalPasses()
{
    GlobalPasses.push_back(PASS_MODE::CLASS_SKIM);
    GlobalPasses.push_back(PASS_MODE::FUNCTION_SKIM);
    GlobalPasses.push_back(PASS_MODE::FULL_PASS);
}
