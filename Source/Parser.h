
#ifndef PARSER_H
#define PARSER_H

#include "GlobalFunctions.h"
#include "BaseType.h"
#include <string>
#include <vector>
#include <map>
#include <locale>
using namespace std;

enum PARSER_STATE
{
    START_OF_LINE,
    EXPECT_USING_IDENT,
    EXPECT_USING_DOT_OR_NEWLINE,
    EXPECT_CLASS_NAME,
    EXPECT_TEMPLATE_START_OR_NEWLINE_OR_SIZE,
    EXPECT_CLASS_SIZE_NUMBER,
    EXPECT_CLASS_TEMPLATE_NAME,
    EXPECT_CLASS_TEMPLATE_END_OR_COMMA,
    EXPECT_NEWLINE,
    EXPECT_ACTION_NAME,
    EXPECT_RETURNS_OR_LPAREN,
    EXPECT_PARAM_TYPE,
    EXPECT_PARAM_NAME,
    EXPECT_COMMA_OR_LPAREN,
    EXPECT_NEWLINE_OR_RETURNS,
    EXPECT_RETURN_TYPE
};

const string EXTENSION = string(".q");

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
    map<string, BaseType> TypeTable;
    TemplatedType CurrentClass;
    Scope GlobalScope;
    vector<Scope *> ScopeStack;
    Function * CurrentFunction;
    
    void InsertKeywords();
    string Parse(const vector<string> & Tokens);
    void RunParse();
    void Initialize(const vector<string> & Tokens);
    void GetFirstToken();
    void GetNextToken();
    bool IsNextToken();
    void Operate();
    void IncreaseLineNumberIfNewline();
    void ParseStartOfLine();
    void ParseExpectUsingIdent();
    void ParseExpectUsingDotOrNewline();
    void OutputStandardErrorMessage(const string & Message);
    string GetErrorLineNumberText();
    string InsteadErrorMessage(const string & WrongString);
    string ConvertSavedUsingIdentsToPath();
    void ParseExpectClassName();
    string GetNameErrorText(const string & Input);
    bool IsValidClassName(const string & Input);
    bool TypeTableContains(const string & Input);
    void ParseExpectTemplateStartOrNewlineOrSize();
    void ParseExpectClassTemplateName();
    bool IsValidIdent(const string & Input);
    bool IsValidClassTemplateName(const string & Input);
    void ParseExpectClassTemplateEndOrComma();
    void ParseExpectNewline();
    void ParseExpectClassSizeNumber();
    bool IsNumber(const string & Input);
    void ParseExpectActionName();
    bool IsValidActionName(const string & Input);
    void ParseExpectReturnsOrLParen();
    void ParseExpectReturnType();
    void ParseExpectParamType();
};

#include "Compiler.h"

#include "Parser.hpp"
#endif
