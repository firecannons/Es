
#ifndef PARSER_H
#define PARSER_H

#include "GlobalFunctions.h"
#include "BaseType.h"
#include "Token.h"
#include "Keywords.h"
#include "AsmCode.h"
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
    EXPECT_CLASS_DECL_NEWLINE,
    EXPECT_ACTION_NAME_OR_ACTION_TYPE,
    EXPECT_ACTION_NAME,
    EXPECT_RETURNS_OR_LPAREN_OR_NEWLINE,
    EXPECT_PARAM_NAME,
    EXPECT_NEWLINE_OR_RETURNS,
    EXPECT_TYPE,
    EXPECT_TEMPLATE_START_OR_IDENT,
    EXPECT_TEMPLATE_START_OR_NEWLINE,
    EXPECT_TOKEN_UNTIL_END,
    EXPECT_RETURNS_NEWLINE,
    EXPECT_NEWLINE_AFTER_END,
    EXPECT_COMMA_OR_RPAREN,
    EXPECT_VARIABLE_NAME,
    EXPECT_FIRST_OPERATOR_OR_NEWLINE
};

enum TYPE_PARSE_MODE
{
    PARSING_NEW_VARIABLE,
    PARSING_PARAM,
    PARSING_RETURNS
};

const string EXTENSION = string(".q");
const unsigned int DEFAULT_COMPILED_TEMPLATE_INDEX = 0;
const string TEMPLATE_VARIABLE_NAME_PREFIX = "T";
const string TEMPORARY_VARIABLE_PREFIX = "[T";
const string LABEL_PREFIX = "L";
const string SEMICOLON = ";";
const string SPACE = " ";

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
    TYPE_PARSE_MODE TypeMode;
    bool IsAsmFunction;
    vector<Token> TemplateTokens;
    unsigned int TemplateTokenIndex;
    TemplatedType CurrentParsingType;
    vector<TemplatedType> StoredParsedTemplates;
    map<string, TemplatedType> TemplateVariableTable;
    unsigned int TemplateVariableCounter;
    vector<Token> ReduceTokens;
    unsigned int ReducePosition;
    vector<unordered_set<string>> OperatorOrdering;
    string FileStartASM;
    unsigned int TemporaryVariableCounter;
    unsigned int LabelCounter;
    
    string Parse(const vector<Token> & Tokens);
    void RunParse();
    void Initialize(const vector<Token> & Tokens);
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
    void ParseExpectClassDeclNewline();
    void ParseExpectClassSizeNumber();
    bool IsNumber(const string & Input);
    void ParseExpectActionName();
    bool IsValidActionName(const string & Input);
    void ParseExpectReturnsOrLParenOrNewline();
    void ParseExpectType();
    string GetFileNameErrorMessage(const Token & OutToken);
    void ParseExpectActionNameOrActionType();
    void ParseExpectTemplateStartOrIdent();
    void ParseExpectTemplateStartOrNewline();
    void ParseExpectTokenUntilEnd();
    Scope * GetCurrentScope();
    void ParseTemplates();
    void InitializeTemplateTokens(); 
    void ParseTemplateTokens();
    void InitializeTemplateParse();
    void RemoveTypeInTemplates();
    void OperateTemplateTokens();
    bool IsInCurrentScope(const string & VariableName);
    bool IsInAnyScope(const string & VariableName);
    Object * GetInCurrentScope(const string & VariableName);
    Object * GetInAnyScope(const string & VariableName);
    bool IsAType(const string & TypeName);
    bool IsTemplateVariable(const string & VariableName);
    TemplatedType GetTemplateFromVariable(const string & VariableName);
    string GetNextTemplateVariable();
    void ParseExpectReturnsNewline();
    void EndCurrentScope();
    void ParseExpectNewlineAfterEnd();
    void ParseExpectCommaOrRParen();
    void ParseExpectNewlineOrReturns();
    void ParseExpectVariableName();
    void ParseExpectFirstOperatorOrNewline();
    void CopyUntilNextNewline();
    void ReduceLine();
    void OperateReduceTokens();
    void InitializeOperatorOrdering();
    bool IsCurrentlyLeftParen();
    bool IsFirstOperatorHigherPrecedence();
    void DoReduce();
    void ReduceRParen();
    bool IsFunctionCallCurrently();
    void DoReduceFunctionCall();
    void ReduceOperator();
    bool IsSingleVarInParens();
    bool IsALeftParenInOperatorPosition();
    void DoSingleVarInParens();
    bool IsAColonInNextOperatorPosition();
    bool IsAColonInFarOperatorPosition();
    void DoColonReduce();
    void AppendInitialASM();
    string GetNextTemporaryVariable();
    string GetNextLabel();
    bool IsFunctionScopeClosest();
    void AppendNewlinesToOutputASM(const unsigned int Number);
    string GetNewlines(const unsigned int Number);
    void OutputCurrentFunctionToAsm();
    void OutputDeclaringVariableToAsm(const string & VariableName);
};

#include "Compiler.h"

#include "Parser.hpp"
#endif
