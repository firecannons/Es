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
    else if(State == PARSER_STATE::EXPECT_TYPE)
    {
        ParseExpectType();
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
        State = PARSER_STATE::EXPECT_CLASS_NAME;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["ACTION"])
    {
        State = PARSER_STATE::EXPECT_ACTION_NAME_OR_ACTION_TYPE;
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
        OutputAsm = OutputAsm + NextCompiler.CompileToAsm(Path);
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
        State = PARSER_STATE::START_OF_LINE;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        State = PARSER_STATE::EXPECT_CLASS_TEMPLATE_NAME;
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["SIZE"])
    {
        CurrentClass.Type->InitializeBlankCompiledTemplate();
        CurrentClass.Type->IsTemplated = false;
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
        State = PARSER_STATE::EXPECT_NEWLINE;
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

void Parser::ParseExpectNewline()
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

void Parser::ParseExpectClassSizeNumber()
{
    if(IsNumber(CurrentToken.Contents) == true)
    {
        CurrentClass.Type->CompiledTemplates[0].Size = stoi(CurrentToken.Contents);
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
    }
    else if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LPAREN"])
    {
        State = PARSER_STATE::EXPECT_TYPE;
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
        State = PARSER_STATE::EXPECT_TEMPLATE_START_OR_IDENT;
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
        State = PARSER_STATE::EXPECT_ACTION_NAME;
    }
    else
    {
        ParseExpectActionName();
    }
}

void Parser::ParseExpectTemplateStartOrIdent()
{
    if(CurrentToken.Contents == GlobalKeywords.ReservedWords["LESS_THAN"])
    {
        // At this point, parse the template
    }
    else if(IsValidIdent(CurrentToken.Contents) == true)
    {
        // Go to the next part
    }
    else
    {
        OutputStandardErrorMessage(string("Expected '<' or valid variable name ") + InsteadErrorMessage(CurrentToken.Contents) + string("."), CurrentToken);
    }
}