#include "Parser.h"

string Parser::Parse(const vector<Token> & Tokens)
{
    Initialize(Tokens);
    
    RunAllPasses();
    
    OutputTypeTable();

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
    //if(CurrentClass.Type != NULL && CurrentClass.Type->Name == "Array" && PassMode == PASS_MODE::FUNCTION_SKIM)
    cout << "'" << CurrentToken.Contents << "' " << State << " " << PassMode << " " << ScopeStack.size() << " " << Position << endl;// << " " << DoesMapContain("IfTest1", ScopeStack[ScopeStack.size() - 1]->Objects) << endl;
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
        if(IsPassModeHigherOrEqual(PASS_MODE::FUNCTION_SKIM) == true)
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
    OutputTokens(TemplateTokens);
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
                
                
                cout << "entering parsing template " << OutputFullTemplatesToString(CurrentParsingType) << " from " << OutputFullTemplatesToString(CurrentClass) << endl;
                CompileTemplatedCode();
                
                cout << "leaving parsing template " << OutputFullTemplatesToString(CurrentParsingType) << "to return to " << OutputFullTemplatesToString(CurrentClass) << endl;
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
    cout << OutputMapToString(GetCurrentScope()->Objects) << endl;
    cout << OutputMapToString(ScopeStack[ScopeStack.size() - 2]->Objects) << endl;
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
    cout << "after pop " << GetCurrentScope()->Origin << endl;
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
                        cout << CurrentClass.Templates->Size << endl;
                    }
                    
                    cout << "wth " << CurrentClass.Type->Name << " getting " << CurrentToken.Contents << " " << TypeTable["Integer"].GetFirstCompiledTemplate()->MyScope.Objects.size() << endl;
                    string i;
                    //cin >> i;
                    
                    GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                    GetCurrentScope()->OrderedObjects.push_back(&GetCurrentScope()->Objects[NewParamObject.Name]);
                }
                else if(IsOriginCloserOrEqual(GetCurrentScope()->Origin, SCOPE_ORIGIN::FUNCTION) == true && PassMode == PASS_MODE::FULL_PASS)
                {
                    cout << "adding object to function scope " << NewParamObject.Name << endl;
                    GetCurrentScope()->Objects.emplace(NewParamObject.Name, NewParamObject);
                    AddNewVariableToStack(GetCurrentScope()->Objects[NewParamObject.Name]);
                }
            }
            CurrentParsingObject = &GetCurrentScope()->Objects[NewParamObject.Name];
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
        CurrentParsingType.Templates = NULL;
        State = PARSER_STATE::START_OF_LINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        CallEmptyConstructor();
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
    cout << TypeTable["Integer"].GetFirstCompiledTemplate()->MyScope.Objects.size() << endl;
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
        cout << ReduceTokens[ReducePosition + 1].Contents << " " << Output << " " << OutputSetToString((const unordered_set<string> &) OperatorOrdering[OrderingIndex]) << endl;
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
    cout << "yo " << TypeTable["Integer"].GetFirstCompiledTemplate()->MyScope.Objects.size() << " " << ReducePosition << endl;
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
    cout << "adding objects to colon reduce " << NewObject.Name << " " << GetCurrentScope()->Origin << " " << TypeTable["Integer"].GetFirstCompiledTemplate()->MyScope.Objects.size() << endl;
    GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
    cout << "adding objects to colon reduce " << NewObject.Name << " " << GetCurrentScope()->Origin << " " << TypeTable["Integer"].GetFirstCompiledTemplate()->MyScope.Objects.size() << endl;
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
        NumberObject.Name = GetNextTemporaryVariable();
        ReduceTokens[InPosition].Contents = NumberObject.Name;
        NumberObject.Type.Type = &TypeTable["Integer"];
        NumberObject.Type.Templates = TypeTable["Integer"].GetFirstCompiledTemplate();
        cout << "adding number to objects " << endl;
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
    
    
    
    
    cout << "before " << InType.Name << endl;
    OutputString = OutputString + "Recursive Template: " + OutputFullTemplatesToString(NewTT); /*to_string(NewTT.Templates->Templates.size()) + " " + to_string(TypeTable[string("Box")].CompiledTemplates.size()) + " "
        + to_string(TypeTable[string("Box")].CompiledTemplates[2].Templates[0].Templates->Templates.size()) + " " + OutputFullTemplatesToString(NewTT) + '\n';*/
    cout << "after" << endl;
    
    OutputString = OutputString + NewTT.Type->Name;
    
    
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Scope:\n";
    cout << "entering printing scope" << endl;
    OutputString = OutputString + OutputScopeToString((Scope &)OutputCT.MyScope, Level + 1);
    cout << "exiting printing scope" << endl;
    return OutputString;
}

string Parser::OutputScopeToString(Scope & OutputScope, const unsigned int Level)
{
    cout << "one" << endl;
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Offset: " + to_string(OutputScope.Offset) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Origin: " + to_string(OutputScope.Origin) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Ordered Objects Size: " + to_string(OutputScope.OrderedObjects.size()) + '\n';
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Objects:\n";
    cout << "two" << endl;

    map<string, Object>::iterator Iterator;
    for (Iterator = OutputScope.Objects.begin(); Iterator != OutputScope.Objects.end(); Iterator++)
    {
        cout << Iterator->second.Name << endl;
        OutputString = OutputString + OutputObjectToString(Iterator->second, Level + 1);
    }
    cout << "three" << endl;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Functions:\n";
    
    cout << &OutputScope << " outputting scope " << OutputScope.Functions.size() << endl;
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
    cout << "four" << endl;
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
    
    cout << OutputTT.Type->Name << "testing" << endl;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Type: " + OutputFullTemplatesToString(OutputTT) + '\n';

    return OutputString;
}

string Parser::OutputFunctionToString(Function & OutputFunction, const unsigned int Level)
{
    string OutputString;
    OutputString = OutputString + OutputTabsToString(Level);
    OutputString = OutputString + "Name: " + OutputFunction.Name + '\n';
    cout << &OutputFunction << " " << OutputFunction.Name << endl;
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
    cout << "entering IsLocalScopeToBeParsedNow " << GetCurrentScope() << endl;
    cout << "getting " << GetCurrentScope()->Origin << endl;
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
        if(InCompiledTemplate.MyScope.OrderedObjects[Index]->Name == "P" ||
        InCompiledTemplate.MyScope.OrderedObjects[Index]->Name == "Size")
        {
            cout << "sizing " << InCompiledTemplate.MyScope.OrderedObjects[Index]->Name << endl;
            cout << InCompiledTemplate.MyScope.OrderedObjects[Index]->Offset << " " << InCompiledTemplate.MyScope.Offset << " "
            << InCompiledTemplate.Size << " " << InCompiledTemplate.MyScope.OrderedObjects[Index]->Type.Templates->Size << endl;
            //exit(1);
        }
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
    list<Scope> OldControlStructureScopes = ControlStructureScopes;

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
    DoPossiblyAddBigThree();
    cout << CurrentClass.Type->Name << endl;
    if(CurrentClass.Type->Name == "DynamicMemory")
    {
        //exit(1);
    }

    PassMode = PASS_MODE::FULL_PASS;
    InitializeForTemplatedPass();
    RunParse();
    DoPossiblyOutputBigThreeCode();
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
    cout << "ok... " << InList.Functions.size() << endl;
    while(Index < InList.Functions.size() && Found == false)
    {
        if(InList.Functions.size() > 0)
        {
            cout << "first parameter type name = " << InObjects[0]->Type.Type->Name << endl;
        }
        if(DoesFunctionMatch(GetInList(InList.Functions, Index), InObjects) == true)
        {
            Found = true;
            FoundPos = Index;
        }
        cout << OutputFunctionNameWithObjects(GetInList(InList.Functions, Index).Name, InObjects) << endl;
        cout << "Index: " << Index << " FOund: " << Found << " " << GetInList(InList.Functions, FoundPos).Label << endl;
        Index = Index + 1;
    }
    if(Found == false)
    {
        cout << "hello " << InObjects.size() << endl;
        OutputStandardErrorMessage(string("No function matching ") + OutputFunctionNameWithObjects(((FunctionList &) InList).GetFirstFunction()->Name, InObjects) + string(" in list."),
            CurrentToken);
    }
    return &GetInList(InList.Functions, FoundPos);
}

bool Parser::DoesFunctionMatch(const Function & InFunction, const vector<Object *> InObjects)
{
    cout << "getting size " << InFunction.Parameters.size() << " " << InObjects.size() << endl;
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
            cout << InFunction.Parameters[Index]->Type.Type->Name << " " << InObjects[Index]->Type.Type->Name << endl;
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
        cout << "we got one " << LinkString << endl;
        Found = OutAsmCode.find(LinkString);
        OutAsmCode.erase(Found, LinkString.size());
        OutAsmCode.erase(Found, 1);
        string ParenOperand = OutAsmCode.substr(Found, OutAsmCode.find(GlobalKeywords.ReservedWords["RPAREN"], Found) - Found);
        OutAsmCode.erase(Found, ParenOperand.size());
        OutAsmCode.erase(Found, 1);
        OutAsmCode = PerformLinkStringAction(LinkString, OutAsmCode, Found, ParenOperand);
        Found = OutAsmCode.find(LinkString);
        cout << OutAsmCode << endl;
    }
    return OutAsmCode;
}

string Parser::PerformLinkStringAction(const string & LinkString, const string & InAsmCode, const size_t Found, const string & ParenOperand)
{
    string OutAsmCode = InAsmCode;
    if(LinkString == GlobalKeywords.AsmLinkWords["GET_SIZE_OF"])
    {
        cout << "in" << ParenOperand << endl;
        TemplatedType SizeTT = GetType(ParenOperand);
        string SizeString = to_string(SizeTT.Templates->Size);
        cout << "going..." << SizeString << endl;
        OutAsmCode.insert(Found, SizeString);
        cout << "out" << endl;
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
            cout << "Class Name: " << ClassName << " ActionName: " << ActionName << endl;
            TemplatedType ClassTT = GetType(ClassName);
            CalledFunctionList = &ClassTT.Templates->MyScope.Functions[ActionName];
        }
        else
        {
            CalledFunctionList = &GetGlobalScope()->Functions[ParenOperand];
        }
        size_t RightParenPosition = OutAsmCode.find(GlobalKeywords.ReservedWords["RPAREN"], Found);
        //cout << "ok... " << ParenOperand << " " << RightParenPosition << " " << Found << " " << RightParenPosition - (Found + 1) << " " << OutAsmCode.substr(Found - 5, 10) << endl;
        string FunctionNumberString = OutAsmCode.substr(Found + 1, RightParenPosition - (Found + 1));
        unsigned int FunctionNumber = stoi(FunctionNumberString);
        cout << "aha we got one sdf " << LinkString << " " << FunctionNumberString << " " << FunctionNumber << " " << CalledFunctionList->Functions.size() << endl;
        CalledFunction = &GetInList(CalledFunctionList->Functions, FunctionNumber);
        OutAsmCode.erase(Found, RightParenPosition - Found + 1);
        OutAsmCode.insert(Found, CalledFunction->Label);
        cout << "aha we got one " << LinkString << " " << ParenOperand << endl;
    }
    return OutAsmCode;
}

void Parser::ReturnAfterReduce()
{
    cout << "reduce return! " << ReduceTokens[ReducePosition].Contents << endl;
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
    State = PARSER_STATE::EXPECT_NEWLINE_AFTER_END;
    if(PassMode == PASS_MODE::FULL_PASS)
    {
        if(IsLocalScopeInOneLevelLow() == true)
        {
            if(GetCurrentScope()->Origin == SCOPE_ORIGIN::FUNCTION)
            {
                cout << "Current function ending scope: " << CurrentFunction << endl;
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
        NewObject.Name = GetNextTemporaryVariable();
        NewObject.Type = InFunction.ReturnObject.Type;
        NewObject.IsReference = InFunction.ReturnObject.IsReference;
        cout << "adding return value " << NewObject.Name << " " << ReduceTokens[ReducePosition].Contents << " " << ReducePosition << endl;
        GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
        AddNewVariableToStack(GetCurrentScope()->Objects[NewObject.Name]);
        ReduceTokens[ReducePosition].Contents = NewObject.Name;
        OutputTokens(ReduceTokens);
    }
}

void Parser::AddInternalReturnObject()
{
    Object NewObject;
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
        cout << "Added " << GetCurrentScope() << endl;
        
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
            cout << "exiting repeat scope" << endl;
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
            cout << "exiting repeat scope" << endl;
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
    cout << "adding new function" << endl;
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
        NewObject.Name = GetNextTemporaryVariable();
        NewObject.Type = InObject.Type;
        NewObject.Offset = CallingObject->Offset + OffsetShift;
        NewObject.IsReference = true;
        NewObject.ReferenceOffset = CallingObject->ReferenceOffset;
        GetCurrentScope()->Objects.emplace(NewObject.Name, NewObject);
        
        NextFunctionObjects.push_back(GetInAnyScope(NewObject.Name));
    }
    
    Function * WantedFunction = GetFromFunctionList(InObject.Type.Templates->MyScope.Functions[CurrentFunction->Name], Reverse(NextFunctionObjects));
    CallFunction(*WantedFunction);
}

void Parser::CopyAutoGenerateParametersToFunction()
{
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
    cout << CurrentClass.Type->Name << " does " << CurrentClass.Templates->HasUserDefinedCopyConstructor << " have a copy constructor" << endl;
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
    cout << OutputCompiledTemplateToString(*(CurrentParsingType.Templates), *(CurrentParsingType.Type), 1) << endl;
    NextFunctionObjects.push_back(CurrentParsingObject);
    Function * WantedFunction = GetFromFunctionList(CurrentParsingType.Templates->MyScope.Functions[GlobalKeywords.ReservedWords["CONSTRUCTOR"]], Reverse(NextFunctionObjects));
    CallFunction(*WantedFunction);
    NextFunctionObjects.clear();
}

Object Parser::CreateCurrentClassObject(const string & VariableName)
{
    return CreateReferenceObject(VariableName, CurrentClass);
}
