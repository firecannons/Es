
#ifndef TEMPLATEPARSER_H
#define TEMPLATEPARSER_H

#include "Token.h"
#include "Keywords.h"

class TemplateParser
{

    vector<Token> Tokens;
    unsigned int Position;
    
public:
    void Parse(const vector<Token> Tokens, unsigned int Position);
    void InitializeTemplateTokens(const vector<Token> Tokens, unsigned int Position);
    
};

#include "TemplateParser.hpp"
#endif
