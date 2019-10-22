#include "TemplateParser.h"

void TemplateParser::Parse(const vector<Token> & Tokens, unsigned int Position)
{
    InitializeTemplateTokens(Tokens, Position);
}

void TemplateParser::InitializeTemplateTokens(const vector<Token> Tokens, unsigned int Position)
{
    unsigned int Index = 0;
    bool TemplateFinished = false;
    while(TemplateFinished == false)
    {
        if(Token)
    }
}