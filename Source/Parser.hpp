#include "Parser.h"

string Parser::Parse(const vector<string> & Tokens, const string & CodeFileName)
{
    Initialize(Tokens, CodeFileName);
    
    RunParse();
    
    return string("asm here ") + Tokens[0] + string(" ") + OutputAsm;
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

void Parser::Initialize(const vector<string> & Tokens, const string & CodeFileName)
{
    this->Tokens = Tokens;
    State = PARSER_STATE::START_OF_LINE;
    Position = 0;
    OutputAsm = string("");
    HasToken = false;
    SavedUsingIdents.clear();
    LineNumber = 0;
    ScopeStack.push_back(& GlobalScope);
    CurrentCodeFileName = CodeFileName;
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
    Token = Tokens[Position];
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
    else if(State == PARSER_STATE::EXPECT_NEWLINE)
    {
        ParseExpectNewline();
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
    else if(State == PARSER_STATE::EXPECT_RETURN_TYPE)
    {
        ParseExpectReturnType();
    }
    else if(State == PARSER_STATE::EXPECT_PARAM_TYPE)
    {
        ParseExpectParamType();
    }
    IncreaseLineNumberIfNewline();
}

void Parser::IncreaseLineNumberIfNewline()
{
    if(Token == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        LineNumber = LineNumber + 1;
    }
}

void Parser::ParseStartOfLine()
{
    if(Token == GlobalKeywords.ReservedWords["USING"])
    {
        State = PARSER_STATE::EXPECT_USING_IDENT;
    }
    else if(Token == GlobalKeywords.ReservedWords["CLASS"])
    {
        State = PARSER_STATE::EXPECT_CLASS_NAME;
    }
    else if(Token == GlobalKeywords.ReservedWords["ACTION"])
    {
        State = PARSER_STATE::EXPECT_ACTION_NAME_OR_ACTION_TYPE;
    }
}

void Parser::ParseExpectUsingIdent()
{
    SavedUsingIdents.push_back(Token);
    State = PARSER_STATE::EXPECT_USING_DOT_OR_NEWLINE;
}

void Parser::ParseExpectUsingDotOrNewline()
{
    if(Token == GlobalKeywords.ReservedWords["DOT"])
    {
        State = PARSER_STATE::EXPECT_USING_IDENT;
    }
    else if(Token == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        string Path = ConvertSavedUsingIdentsToPath();
        State = PARSER_STATE::START_OF_LINE;
        Compiler NextCompiler;
        OutputAsm = OutputAsm + NextCompiler.CompileToAsm(Path);
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline or period at end of 'using' statement ") + InsteadErrorMessage(Token));
    }
}

void Parser::OutputStandardErrorMessage(const string & Message)
{
    PrintError(GetFileNameErrorMessage() + GetErrorLineNumberText() + Message);
}

string Parser::GetFileNameErrorMessage()
{
    string FileNameErrorMessage = string("In ") + CurrentCodeFileName + string(": ");
    return FileNameErrorMessage;
}

string Parser::GetErrorLineNumberText()
{
    string LineNumberError = string("Error on line ") + to_string(LineNumber + 1) + string(": ");
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
    if(IsValidClassName(Token) == false)
    {
        OutputStandardErrorMessage(GetNameErrorText(Token) + string(" is not a valid class name."));
    }
    else if(TypeTableContains(Token) != false)
    {
        OutputStandardErrorMessage(string("A class named ") + Token + string(" has already been declared."));
    }
    else
    {
        BaseType NewClassBase;
        NewClassBase.Name = Token;
        NewClassBase.InitializeBlankCompiledTemplate();
        TypeTable.insert(pair<string,BaseType>(Token, NewClassBase));
        CurrentClass.Type = &TypeTable[Token];
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
    if(Token == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        CurrentClass.Type->InitializeBlankCompiledTemplate();
        CurrentClass.Type->IsTemplated = false;
        State = PARSER_STATE::START_OF_LINE;
    }
    else if(Token == GlobalKeywords.ReservedWords["LEFT_BRACKET"])
    {
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_NAME;
    }
    else if(Token == GlobalKeywords.ReservedWords["SIZE"])
    {
        CurrentClass.Type->InitializeBlankCompiledTemplate();
        CurrentClass.Type->IsTemplated = false;
        State = PARSER_STATE::EXPECT_CLASS_SIZE_NUMBER;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected left bracket or newline ") + InsteadErrorMessage(Token) + string("."));
    }
}

void Parser::ParseExpectClassTemplateName()
{
    if(IsValidClassTemplateName(Token) == true)
    {
        CurrentClass.Type->PossibleTemplates.push_back(Token);
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_END_OR_COMMA;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected valid template name for class ") + InsteadErrorMessage(Token) + string("."));
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
    if(Token == GlobalKeywords.ReservedWords["RIGHT_BRACKET"])
    {
        State = PARSER_STATE::EXPECT_NEWLINE;
    }
    else if(Token == GlobalKeywords.ReservedWords["COMMA"])
    {
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_NAME;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected right bracket or newline ") + InsteadErrorMessage(Token) + string("."));
    }
}

void Parser::ParseExpectNewline()
{
    if(Token == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected newline ") + InsteadErrorMessage(Token) + string("."));
    }
}

void Parser::ParseExpectClassSizeNumber()
{
    if(IsNumber(Token) == true)
    {
        CurrentClass.Type->CompiledTemplates[0].Size = stoi(Token);
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected a number ") + InsteadErrorMessage(Token) + string("."));
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
    cout << Token << endl;
    if(DoesSetContain(Token, GlobalKeywords.OverloadableOperators) == true || IsValidActionName(Token) == true)
    {
        State = PARSER_STATE::EXPECT_RETURNS_OR_LPAREN_OR_NEWLINE;
    }
    else
    {
        OutputStandardErrorMessage(GetNameErrorText(Token) + string(" is not a valid action name."));
    }
}

bool Parser::IsValidActionName(const string & Input)
{
    bool Output = IsValidIdent(Input);
    return Output;
}

void Parser::ParseExpectReturnsOrLParenOrNewline()
{
    if(Token == GlobalKeywords.ReservedWords["RETURNS"])
    {
        State = PARSER_STATE::EXPECT_RETURN_TYPE;
    }
    else if(Token == GlobalKeywords.ReservedWords["LPAREN"])
    {
        State = PARSER_STATE::EXPECT_PARAM_TYPE;
    }
    else if(Token == GlobalKeywords.ReservedWords["NEW_LINE"])
    {
        State = PARSER_STATE::START_OF_LINE;
    }
    else
    {
        OutputStandardErrorMessage(string("Expected 'returns' or '(' ") + InsteadErrorMessage(Token) + string("."));
    }
}

void Parser::ParseExpectReturnType()
{
}

void Parser::ParseExpectParamType()
{
}

void Parser::ParseExpectActionNameOrActionType()
{
    if(Token == GlobalKeywords.ReservedWords["ASM"])
    {
        State = PARSER_STATE::EXPECT_ACTION_NAME;
    }
    else
    {
        ParseExpectActionName();
    }
    
}