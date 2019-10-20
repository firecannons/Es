
#ifndef TOKEN_H
#define TOKEN_H

#include <string>
using namespace std;

class Token
{
    
public:
    string Contents;
    unsigned int LineNumber;

    Token();
    Token(const string & In, const unsigned int InLineNumber);
};

#include "Token.hpp"
#endif
