
#ifndef PARSER_H
#define PARSER_H

#include "GlobalFunctions.h"
#include "BaseType.h"
#include "Token.h"
#include <string>
#include <vector>
#include <map>
#include <locale>
#include <unordered_set>
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
    EXPECT_ACTION_NAME_OR_ACTION_TYPE,
    EXPECT_ACTION_NAME,
    EXPECT_RETURNS_OR_LPAREN_OR_NEWLINE,
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
    string CurrentCodeFileName;
    PARSER_STATE State;
    unsigned int Position;
    vector<Token> Tokens;
    Token CurrentToken;
    string OutputAsm;
    bool HasToken;
    vector<string> SavedUsingIdents;
    map<string, BaseType> TypeTable;
    TemplatedType CurrentClass;
    Scope GlobalScope;
    vector<Scope *> ScopeStack;
    Function * CurrentFunction;
    
    string Parse(const vector<Token> & Tokens, const string & CodeFileName);
    void RunParse();
    void Initialize(const vector<Token> & Tokens, const string & CodeFileName);
    void GetFirstToken();
    void GetNextToken();
    bool IsNextToken();
    void Operate();
    void ParseStartOfLine();
    void ParseExpectUsingIdent();
    void ParseExpectUsingDotOrNewline();
    void OutputStandardErrorMessage(const string & Message, const Token & OutToken);
    string GetErrorLineNumberText(const Token & OutToken);
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
    void ParseExpectReturnsOrLParenOrNewline();
    void ParseExpectReturnType();
    void ParseExpectParamType();
    string GetFileNameErrorMessage();
    void ParseExpectActionNameOrActionType();
};

#include "Compiler.h"

#include "Parser.hpp"
#endif
