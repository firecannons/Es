
#ifndef PARSER_H
#define PARSER_H

#include <string>
#include <vector>
using namespace std;

enum PARSER_STATE
{
    START_OF_LINE,
    EXPECT_CLASS_NAME,
    END_CLASS_NAME,
    EXPECT_ACTION_NAME,
    EXPECT_RETURN_OR_LPAREN,
    EXPECT_PARAM_TYPE,
    EXPECT_PARAM_NAME,
    EXPECT_COMMA_OR_LPAREN,
    EXPECT_NEWLINE_OR_RETURNS,
    EXPECT_RETURN_TYPE
};

class Parser
{
    
public:
    PARSER_STATE State;
    unsigned int Position;
    
    string Parse(vector<string> & Tokens);
};

#include "Parser.hpp"
#endif
