#include "Token.h"

Token::Token()
{
    
}

Token::Token(const string & In, const unsigned int InLineNumber, const string & InFileName)
{
    Contents = In;
    LineNumber = InLineNumber;
    SourceFileName = InFileName;
}