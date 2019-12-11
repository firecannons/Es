#include "Parser.h"

string Parser::Parse(const vector<Token> & Tokens)
{
    Initialize(Tokens);
    
    RunAllPasses();

    OutputTemplateAsm();

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
    InitializeForPass();
    OutputAsm = string("");
    GlobalScope.Origin = SCOPE_ORIGIN::GLOBAL;
    ScopeStack.clear();
    ScopeStack.push_back(& GlobalScope);
    TemplateVariableCounter = 0;
    TemporaryVariableCounter = 0;
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
    if(CurrentClass.Type != NULL && CurrentClass.Type->Name == "Array" && PassMode == PASS_MODE::FUNCTION_SKIM)
    {
    cout << "'" << CurrentToken.Contents << "' " << State << " " << PassMode << " " << ScopeStack.size() << " " << Position << endl;
    }
/*
                BaseType BT1;
                BT1.Name = "toy";
                BT1.IsTemplated = false;
                TypeTable.insert(pair<string,BaseType>(string("toy"), BT1));
                TypeTable[string("toy")].InitializeBlankCompiledTemplate();


                BaseType BT;
                BT.Name = "test";
                BT.IsTemplated = true;
                TypeTable.insert(pair<string,BaseType>(string("test"), BT));
                TypeTable[string("test")].InitializeBlankCompiledTemplate();
                
                
                CompiledTemplate * CT = TypeTable[string("test")].GetFirstCompiledTemplate();

                TemplatedType TT1;
                TT1.Type = &TypeTable[string("toy")];
                TT1.Templates = TypeTable[string("toy")].GetFirstCompiledTemplate();
                CT->Templates.push_back(TT1);
                
                TypeTable[string("test")].InitializeBlankCompiledTemplate();
                CompiledTemplate * CT2 = TypeTable[string("test")].GetLastCompiledTemplate();
                
                TemplatedType TestTT2;
                TestTT2.Type = &TypeTable[string("test")];
                TestTT2.Templates = TypeTable[string("test")].GetFirstCompiledTemplate();
                
                CT2->Templates.push_back(TestTT2);
                
                
                cout << "done setting values" << endl;
                OutputTypeTable();
                OutputTypeTable();
                exit(1);
                OutputTypeTable();*/

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
        if(PassMode == PASS_MODE::FULL_PASS)
        {
            if(IsLocalScopeInOneLevelLow() == true)
            {
                if(CurrentFunction != NULL)
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
        if(IsLocalScopeInOneLevelLow() == true || (PassMode == PASS_MODE::CLASS_SKIM && GetCurrentScope()->Origin == SCOPE_ORIGIN::FUNCTION))
        {
            EndCurrentScope();
        }
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
            NewFunction.HasReturnType = false;
            NewFunction.Name = CurrentToken.Contents;
            NewFunction.MyScope.Origin = SCOPE_ORIGIN::FUNCTION;
            NewFunction.LatestPassMode = PASS_MODE::CLASS_SKIM;
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
                Object NewObject;
                NewObject.Name = GlobalKeywords.ReservedWords["ME"];
                NewObject.Type = CurrentClass;
                NewObject.ReferenceOffset = GetNextParamOffset();
                NewObject.IsReference = true;
                GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
                CurrentFunction->Parameters.push_back(&GetCurrentScope()->Objects[NewObject.Name]);
            }
        }
        
        if(PassMode == PASS_MODE::FULL_PASS)
        {
            string NextLabel = GetNextLabel();
            CurrentFunction->Label = NextLabel;
            OutputAsm = OutputAsm + NextLabel + GlobalKeywords.ReservedWords["COLON"];
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
    if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM && CurrentToken.Contents == GlobalKeywords.ReservedWords["RPAREN"])
    {
        State = PARSER_STATE::EXPECT_RETURNS_OR_LPAREN_OR_NEWLINE;
    }
    else if(IsValidIdent(CurrentToken.Contents) == true)
    {
        if(IsPassModeLowerOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
        {
            cout << "fire" << CurrentToken.Contents << " " << IsAType(CurrentToken.Contents) << endl;
            if(IsAType(CurrentToken.Contents) == true)
            {
                CurrentParsingType = GetType(CurrentToken.Contents);
                cout << "fire" << CurrentParsingType.Type->Name << endl;
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
            State = PARSER_STATE::EXPECT_TEMPLATE_START_OR_NEWLINE;
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

void Parser::ParseExpectTemplateStartOrNewline()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        // At this point, parse the template
        if(IsPassModeHigherOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
        {
            InitializeTemplateTokens();
        }
        else
        {
            ParseTemplates();
        }
        CurrentFunction->ReturnType = CurrentParsingType;
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
    cout << "Position = " << Position << endl;
    InitializeTemplateTokens();
    cout << "Position = " << Position << endl;
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
    cout << Tokens[Index].Contents << " " << TemplateDeepness << endl;
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
    cout << "entering OperateTemplateTokens" << endl;
    OutputTokens(TemplateTokens);
    if(StoredParsedTemplates.size() > 0)
    {
        OutputFullTemplatesToString(StoredParsedTemplates[0]);
    }
    if(TemplateTokens[TemplateTokenIndex + 1].Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
    {
        if(IsTemplateVariable(TemplateTokens[TemplateTokenIndex].Contents) == true)
        {
            StoredParsedTemplates.push_back(GetTemplateFromVariable(TemplateTokens[TemplateTokenIndex].Contents));
            cout << TemplateTokens[TemplateTokenIndex].Contents << endl << OutputFullTemplatesToString(StoredParsedTemplates[StoredParsedTemplates.size() - 1]) << &StoredParsedTemplates[StoredParsedTemplates.size() - 1];
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
        cout << "testing" << endl;
        if(TypeTable[TemplateTokens[TemplateTokenIndex].Contents].PossibleTemplates.size() == 0)
        {
            OutputStandardErrorMessage(string("Type '") + TemplateTokens[TemplateTokenIndex].Contents + "' is not templated. ", TemplateTokens[TemplateTokenIndex]);
        }
        if(TemplateTokens[TemplateTokenIndex + 2].Contents == GlobalKeywords.ReservedWords["GREATER_THAN"])
        {
            if(DoesTypeHaveTemplates(TypeTable[TemplateTokens[TemplateTokenIndex].Contents], StoredParsedTemplates) == false)
            {
                cout << OutputFullTemplatesToString(StoredParsedTemplates[0]) << " " << TemplateTokens[TemplateTokenIndex].Contents << endl;
                

                for(unsigned int i = 0; i < TypeTable[TemplateTokens[TemplateTokenIndex].Contents].CompiledTemplates.size(); i++)
                {
                    TemplatedType TT;
                    TT.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
                    TT.Templates = &GetInList(TypeTable[TemplateTokens[TemplateTokenIndex].Contents].CompiledTemplates, i);
                    cout << OutputFullTemplatesToString(TT) << " " << i << " " << TT.Templates << endl;
                }

                for(unsigned int i = 0; i < TypeTable[TemplateTokens[TemplateTokenIndex].Contents].CompiledTemplates.size(); i++)
                {
                    TemplatedType TT;
                    TT.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
                    TT.Templates = &GetInList(TypeTable[TemplateTokens[TemplateTokenIndex].Contents].CompiledTemplates, i);
                    cout << OutputFullTemplatesToString(TT) << " " << i << " " << TT.Templates << endl;
                }
                    TypeTable[TemplateTokens[TemplateTokenIndex].Contents].InitializeBlankCompiledTemplate();
                
                for(unsigned int i = 0; i < TypeTable[TemplateTokens[TemplateTokenIndex].Contents].CompiledTemplates.size(); i++)
                {
                    TemplatedType TT;
                    TT.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
                    TT.Templates = &GetInList(TypeTable[TemplateTokens[TemplateTokenIndex].Contents].CompiledTemplates, i);
                    cout << OutputFullTemplatesToString(TT) << " " << i << " " << TT.Templates << endl;
                }
                cout << StoredParsedTemplates[StoredParsedTemplates.size() - 1].Templates << endl;
                
                cout << OutputFullTemplatesToString(StoredParsedTemplates[0]) << "esdd" << TypeTable["Box"].CompiledTemplates.size() << endl;
                CurrentParsingType.Type = &TypeTable[TemplateTokens[TemplateTokenIndex].Contents];
                cout << OutputFullTemplatesToString(StoredParsedTemplates[0]) << "esdf" << endl;
                CurrentParsingType.Templates = TypeTable[TemplateTokens[TemplateTokenIndex].Contents].GetLastCompiledTemplate();
                CurrentParsingType.Templates->MyScope.Origin = SCOPE_ORIGIN::CLASS;
                if(CurrentParsingType.Type->PossibleTemplates.size() != StoredParsedTemplates.size())
                {
                    OutputStandardErrorMessage(string("Type '") + TemplateTokens[TemplateTokenIndex].Contents + "' expects " +
                        to_string(CurrentParsingType.Type->PossibleTemplates.size()) + " templates not " + to_string(StoredParsedTemplates.size()) + ".", TemplateTokens[TemplateTokenIndex]);
                }
                cout << OutputFullTemplatesToString(StoredParsedTemplates[0]) << endl;
                CurrentParsingType.Templates->Templates = StoredParsedTemplates;
                cout << "fire" << endl << OutputFullTemplatesToString(StoredParsedTemplates[0]) << &StoredParsedTemplates[StoredParsedTemplates.size() - 1] << endl;

                CompileTemplatedCode();
                // At this point compile the tokens of the templated class (CurrentParsingType.Type) with (CurrentClsas = CurrentParsingType).
            }
            else
            {
                CurrentParsingType.Templates = GetCompiledTemplate(TypeTable[TemplateTokens[TemplateTokenIndex].Contents], StoredParsedTemplates);
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
        CurrentClass.Templates = NULL;
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
        CurrentFunction->HasReturnType = true;
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
    cout << "one " << CurrentToken.Contents << endl;
    if(IsValidIdent(CurrentToken.Contents) == true)
    {
        cout << "two " << CurrentToken.Contents << endl;
        if(IsPassModeLowerOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
        {
            cout << "three " << CurrentToken.Contents << endl;
            Object NewParamObject;
            NewParamObject.Name = CurrentToken.Contents;
            NewParamObject.Type = CurrentParsingType;
            if(TypeMode == TYPE_PARSE_MODE::PARSING_PARAM && PassMode == PASS_MODE::FUNCTION_SKIM)
            {
                NewParamObject.ReferenceOffset = GetNextParamOffset();
                NewParamObject.IsReference = true;
                GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                CurrentFunction->Parameters.push_back(&CurrentFunction->MyScope.Objects[NewParamObject.Name]);
                cout << OutputFullTemplatesToString(CurrentFunction->Parameters.back()->Type) << endl;
            }
            else if(TypeMode == TYPE_PARSE_MODE::PARSING_NEW_VARIABLE)
            {
                cout << "four " << CurrentToken.Contents << endl;
                if(IsClassScopeClosest() == true && PassMode == PASS_MODE::FUNCTION_SKIM)
                {
                    cout << "five " << CurrentToken.Contents << endl;
                    if(CurrentToken.Contents == "P")
                    {
                        cout << "adding P" << endl;
                        cout << OutputFullTemplatesToString(CurrentParsingType) << endl;
                    }
                    GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                    GetCurrentScope()->OrderedObjects.push_back(&GetCurrentScope()->Objects[NewParamObject.Name]);
                }
                else if(IsFunctionScopeClosest() == true && PassMode == PASS_MODE::FULL_PASS)
                {
                    GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                    AddNewVariableToStack(GetCurrentScope()->Objects[NewParamObject.Name]);
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
    while(ReduceTokens.size() > 1)
    {
        OperateReduceTokens();
    }
}

void Parser::OperateReduceTokens()
{
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
    Scope * CallingScope = NULL;
    bool IsCallingObject = false;
    cout << "one:" << ReduceTokens[ReducePosition].Contents << endl;
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
    cout << "two " << ReduceTokens[ReducePosition].Contents << endl;
    CallFunction(*WantedFunction);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition + 1);
}

void Parser::ReduceOperator()
{
    cout << "in ReduceOperator " << ReducePosition << endl;
    AddToArgList(ReducePosition + 2);
    AddToArgList(ReducePosition);
    cout << "fore " << endl;
    cout << "fure " << NextFunctionObjects.size() << " " << NextFunctionObjects[0]->Type.Type << " " << NextFunctionObjects[0]->Type.Type->Name << endl;
    cout << "fyre " << OutputFunctionParameters(Reverse(NextFunctionObjects)) << endl;
    cout << "fare " << NextFunctionObjects[1]->Type.Type << " " << NextFunctionObjects[1]->Type.Type->Name << endl;
    cout << "ok" << OutputFunctionParameters(Reverse(NextFunctionObjects)) << " " << NextFunctionObjects[0]->Type.Type->Name << " " << NextFunctionObjects[1]->Type.Type->Name << endl;
    //cout << Reverse(NextFunctionObjects)[0]->Type.Type->Name << " " << Reverse(NextFunctionObjects)[1]->Type.Type->Name;
    //exit(1);
    CallFunction(*GetFromFunctionList(GetInAnyScope(ReduceTokens[ReducePosition].Contents)->Type.Templates->MyScope.Functions[ReduceTokens[ReducePosition + 1].Contents],
        Reverse(NextFunctionObjects)));
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition);
    ReduceTokens.erase(ReduceTokens.begin() + ReducePosition);
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
    if(CurrentClass.Type != NULL)
    {
        //cout << "doing colon reduce " << CallingObject->Type.Type->Name << " " << ScopeObject->Type.Type->Name << endl;
        cout << ReduceTokens[ReducePosition + 2].Contents << " " << ReduceTokens[ReducePosition].Contents << endl;
    }
    unsigned int OffsetShift = ScopeObject->Offset;
    Object NewObject;
    NewObject.Name = GetNextTemporaryVariable();
    ReduceTokens[ReducePosition + 2].Contents = NewObject.Name;
    NewObject.Type = ScopeObject->Type;
    NewObject.Offset = CallingObject->Offset + OffsetShift;
    NewObject.IsReference = CallingObject->IsReference;
    NewObject.ReferenceOffset = CallingObject->ReferenceOffset;
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

void Parser::OutputDeclaringVariableToAsm(const string & VariableName)
{
    string Output = SPACE + SEMICOLON + SPACE;
    OutputAsm = OutputAsm + Output + string("Declaring ") + VariableName;
}

void Parser::AddToArgList(const unsigned int InPosition)
{
    string VariableName = ReduceTokens[InPosition].Contents;
    Object * NextArg = NULL;
    if(IsNumber(VariableName) == true)
    {
        Object NumberObject;
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
    cout << "adding " << NextArg->Name << " " << OutputFullTemplatesToString(NextArg->Type) << endl;
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
        if(NextFunctionObjects[Index]->IsReference == true)
        {
            OutputAsm = OutputAsm + GlobalASM.CalcDerefForFuncCall(NextFunctionObjects[Index]->ReferenceOffset);
            if(DEBUG == true)
            {
                OutputDerefReference(NextFunctionObjects[Index]->Name, NextFunctionObjects[Index]->ReferenceOffset);
            }
            AppendNewlinesToOutputASM(2);
            OutputAsm = OutputAsm + GlobalASM.CalcPushFromReference(NextFunctionObjects[Index]->Offset, POINTER_SIZE);
        }
        else
        {
            OutputAsm = OutputAsm + GlobalASM.CalcPushFromBasePointer(NextFunctionObjects[Index]->Offset, POINTER_SIZE);
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
    
    
    
    
    cout << "before" << endl;
    OutputString = OutputString + "Recursive Template: " + OutputFullTemplatesToString(NewTT); /*to_string(NewTT.Templates->Templates.size()) + " " + to_string(TypeTable[string("Box")].CompiledTemplates.size()) + " "
        + to_string(TypeTable[string("Box")].CompiledTemplates[2].Templates[0].Templates->Templates.size()) + " " + OutputFullTemplatesToString(NewTT) + '\n';*/
    cout << "after" << endl;
    
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
    OutputString = OutputString + "Has Return Type: " + to_string(OutputFunction.HasReturnType) + '\n';
    if(OutputFunction.HasReturnType == true)
    {
        OutputString = OutputString + OutputTabsToString(Level);
        OutputString = OutputString + "Return Type: \n";
        OutputString = OutputString + OutputTemplatedTypeToString(OutputFunction.ReturnType, Level + 1);
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
    OutputAsm = OutputAsm + Output + string("Dereferencing before push ") + VariableName + string(" from reference offset ") + to_string(ReferenceOffset);
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
    IsAsmFunction = false;
    WasVariableFound = false;
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
        if(GetInList(InBaseType.CompiledTemplates, Index).HasSizeBeenCalculated == false)
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
    while(Index < InCompiledTemplate.MyScope.OrderedObjects.size())
    {
        if(InCompiledTemplate.MyScope.OrderedObjects[Index]->Type.Templates->HasSizeBeenCalculated == false)
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
    //cout << "entering OutputFullTemplatesToString"<< endl;
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

void Parser::CompileTemplatedCode()
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

    State = PARSER_STATE::START_OF_LINE;
    InitializePosition();
    HasToken = false;
    Tokens = CurrentClass.Type->Tokens;
    CurrentFunction = NULL;

    RunAllTemplatedPasses();

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
                /*for(unsigned int i = 0; i < CurrentClass.Templates->Templates.size(); i++)
                {
                    cout << CurrentClass.Templates->Templates[i].Type->Name << endl;
                }*/
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

void Parser::RunAllTemplatedPasses()
{
    PassMode = PASS_MODE::CLASS_SKIM;
    RunParse();

    PassMode = PASS_MODE::FUNCTION_SKIM;
    InitializeForTemplatedPass();
    RunParse();
    SetSizesAndOffsets();

    PassMode = PASS_MODE::FULL_PASS;
    InitializeForTemplatedPass();
    RunParse();
}

string Parser::OutputFullCompiledTemplateVector(const vector<TemplatedType> & TTs)
{
    //cout << "entering OutputFullCompiledTemplateVector asfd" << endl;
    //cout << "size is";
    string Output;
    //cout << "size is";
    unsigned int Index = 0;
    //cout << "size is";
    //cout << "size: " << TTs.size() << endl;
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
        OutputStandardErrorMessage(string("No function matching ") + OutputFunctionNameWithObjects(((FunctionList &) InList).GetFirstFunction()->Name, InObjects) + string("."),
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
    cout << "Name" << Name << endl;
    if(CurrentParsingType.Type != NULL)
    {
        cout << "before" << endl;
        Prototype = Prototype + CurrentParsingType.Type->Name;
        cout << "after" << endl;
        Prototype = Prototype + GlobalKeywords.ReservedWords["COLON"];
    }
    Prototype = Prototype + Name;
    cout << "after two" << Name << endl;
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