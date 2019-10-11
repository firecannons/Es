#include "Parser.h"

void Parser::InsertKeywords()
{
    Keywords.insert(pair<string,string>(string("CLASS"), string("class")));
    Keywords.insert(pair<string,string>(string("ACTION"), string("action")));
    Keywords.insert(pair<string,string>(string("USING"), string("using")));
    Keywords.insert(pair<string,string>(string("DOT"), string(".")));
    Keywords.insert(pair<string,string>(string("BACKSLASH"), string("\\")));
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

void ParserExpectUsingDotOrNewline()
{
    if(Token == Keywords["DOT"])
    {
        State = PARSER_STATE::EXPECT_USING_IDENT;
    }
    else if(Token == Keywords["NEW_LINE"])
    {
        cout << "Made it" << endl;
        exit(1);
    }
    else
    {
        OutputStandardErrorMessage("Expected newline or period at end of 'using' statement.");
    }
}