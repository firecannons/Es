
#ifndef PARSER_H
#define PARSER_H

#include <string>
#include <vector>
#include <map>
using namespace std;

enum PARSER_STATE
{
    START_OF_LINE,
    EXPECT_USING_IDENT,
    EXPECT_USING_DOT_OR_NEWLINE,
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
    vector<string> Tokens;
    string Token;
    string OutputAsm;
    map<string, string> Keywords;
    bool HasToken;
    vector<string> SavedUsingIdents;
    unsigned int LineNumber;
    
    void InsertKeywords();
    string Parse(const vector<string> & Tokens);
    void RunParse();
    void Initialize(const vector<string> & Tokens);
    void GetFirstToken();
    void GetNextToken();
    bool IsNextToken();
    void Operate();
    void ParseStartOfLine();
    void ParserExpectUsingIdent();
    
};

#include "Parser.hpp"
#endif
