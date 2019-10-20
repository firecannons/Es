#include "Token.h"

Token::Token()
{
    
}

Token::Token(const string & In, const unsigned int InLineNumber)
{
    Contents = In;
    LineNumber = InLineNumber;
}