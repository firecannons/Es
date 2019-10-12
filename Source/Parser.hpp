#include "Parser.h"

void Parser::InsertKeywords()
{
    Keywords.insert(pair<string,string>(string("CLASS"), string("class")));
    Keywords.insert(pair<string,string>(string("ACTION"), string("action")));
    Keywords.insert(pair<string,string>(string("USING"), string("using")));
    Keywords.insert(pair<string,string>(string("DOT"), string(".")));
    Keywords.insert(pair<string,string>(string("BACK_SLASH"), string("\\")));
    Keywords.insert(pair<string,string>(string("FORWARD_SLASH"), string("/")));
    Keywords.insert(pair<string,string>(string("NEW_LINE"), string("\n")));
}

string Parser::Parse(const vector<string> & Tokens)
{
    Initialize(Tokens);
    
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

void Parser::Initialize(const vector<string> & Tokens)
{
    InsertKeywords();
    this->Tokens = Tokens;
    State = PARSER_STATE::START_OF_LINE;
    Position = 0;
    OutputAsm = string("");
    HasToken = false;
    SavedUsingIdents.clear();
    LineNumber = 0;
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
        ParserExpectUsingIdent();
    }
    else if(State == PARSER_STATE::EXPECT_USING_DOT_OR_NEWLINE)
    {
        ParserExpectUsingDotOrNewline();
    }
    else if(State == PARSER_STATE::EXPECT_CLASS_NAME)
    {
        ParserExpectClassName();
    }
    IncreaseLineNumberIfNewline();
}

void Parser::IncreaseLineNumberIfNewline()
{
    if(Token == Keywords["NEW_LINE"])
    {
        LineNumber = LineNumber + 1;
    }
}

void Parser::ParseStartOfLine()
{
    if(Token == Keywords["USING"])
    {
        State = PARSER_STATE::EXPECT_USING_IDENT;
    }
    if(Token == Keywords["CLASS"])
    {
        State = PARSER_STATE::EXPECT_CLASS_NAME;
    }
}

void Parser::ParserExpectUsingIdent()
{
    SavedUsingIdents.push_back(Token);
    State = PARSER_STATE::EXPECT_USING_DOT_OR_NEWLINE;
}

void Parser::ParserExpectUsingDotOrNewline()
{
    if(Token == Keywords["DOT"])
    {
        State = PARSER_STATE::EXPECT_USING_IDENT;
    }
    else if(Token == Keywords["NEW_LINE"])
    {
        string Path = ConvertSavedUsingIdentsToPath();
        State = PARSER_STATE::START_OF_LINE;
        Compiler NextCompiler;
        OutputAsm = OutputAsm + NextCompiler.CompileToAsm(Path);
    }
    else
    {
        OutputStandardErrorMessage("Expected newline or period at end of 'using' statement" + InsteadErrorMessage(Token));
    }
}

void Parser::OutputStandardErrorMessage(const string & Message)
{
    PrintError(GetErrorLineNumberText() + Message);
}

string Parser::GetErrorLineNumberText()
{
    string LineNumberError = string("Error on line ") + to_string(LineNumber + 1) + string(": ");
    return LineNumberError;
}

string Parser::InsteadErrorMessage(const string & WrongString)
{
    string Message = string(" instead of '") + WrongString + string("'");
    return Message;
}

string Parser::ConvertSavedUsingIdentsToPath()
{
    string OutputPath = "";
    OutputPath = OutputPath + SavedUsingIdents[0];
    unsigned int Index = 1;
    while(Index < SavedUsingIdents.size())
    {
        OutputPath = OutputPath + Keywords["FORWARD_SLASH"] + SavedUsingIdents[Index];
        Index = Index + 1;
    }
    OutputPath = OutputPath + EXTENSION;
    return OutputPath;
}

void Parser::ParserExpectClassName()
{
    
}