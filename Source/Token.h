
#ifndef TOKEN_H
#define TOKEN_H

#include <string>
using namespace std;

class Token
{
    
public:
    string Contents;
    unsigned int LineNumber;
    string SourceFileName;
};

#include "Token.hpp"
#endif
