
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
    EXPECT_FIRST_OPERATOR_OR_NEWLINE,
    EXPECT_NEWLINE_AFTER_VARIABLE_DECLARATION
};

enum TYPE_PARSE_MODE
{
    PARSING_NEW_VARIABLE,
    PARSING_PARAM,
    PARSING_RETURNS
};

enum PASS_MODE
{
    CLASS_SKIM,
    FUNCTION_SKIM,
    FULL_PASS
};

const string EXTENSION = string(".q");
const unsigned int DEFAULT_COMPILED_TEMPLATE_INDEX = 0;
const string TEMPLATE_VARIABLE_NAME_PREFIX = "T";
const string TEMPORARY_VARIABLE_PREFIX = "[T";
const string LABEL_PREFIX = "L";
const string SEMICOLON = ";";
const string SPACE = " ";
const unsigned int POINTER_SIZE = 4;
const string MAIN_FUNCTION_NAME = "Main";
const unsigned int INTEGER_SIZE = POINTER_SIZE;
const unsigned int STACK_FRAME_SIZE = 8;

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
    vector<Object *> NextFunctionObjects;
    bool WasVariableFound;
    unordered_set<string> IncludedFiles;
    PASS_MODE PassMode;
    
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
    void AddToArgList(const unsigned int Position);
    void AddNewVariableToStack(Object & NewObject);
    void CallFunction(const Function & InFunction);
    void PushArguments();
    void OutputPushingReferenceToVariableToAsm(const string & VariableName, const int Offset);
    void OutputCallAsm(const Function & InFunction);
    void OutputShiftUpFromFunction(const unsigned int ShiftAmount);
    Scope * GetGlobalScope();
    void OutputCallingFunctionCommentToAsm(const Function & InFunction);
    bool IsRParenNext();
    void AddReturnValue(const Function & InFunction);
    void ParseExpectNewlineAfterVariableDeclaration();
    bool IsGlobalScopeClosest();
    bool IsClassScopeClosest();
    SCOPE_ORIGIN GetClosestScopeOrigin();
    void MoveBackCurrentScopeOffset(Object & NewObject);
    void OutputCreateStackFrameAsm();
    void OutputDestroyStackFrameAsm();
    void AddNumericalValueToTempInteger(const string & NewValue);
    unsigned int GetNextParamOffset();
    void OutputTypeTable();
    string OutputTypeTableToString();
    string OutputTypeToString(const BaseType & InType, const unsigned int Level);
    string OutputSingleLineVectorToString(const vector<string> & InVector);
    string OutputTabsToString(const unsigned int NumberTabs);
    string OutputCompiledTemplateToString(const CompiledTemplate & OutputCT, const unsigned int Level);
    string OutputScopeToString(Scope & InScope, const unsigned int Level);
    string OutputObjectToString(const Object & OutputObject, const unsigned int Level);
    string OutputTemplatedTypeToString(const TemplatedType & OutputTT, const unsigned int Level);
    string OutputFunctionToString(Function & OutputFunction, const unsigned int Level);
    void OutputDerefReference(const string & VariableName, const int ReferenceOffset);
    bool IsParsingType();
    void InitializePosition();
    bool IsPassModeLowerOrEqual(const PASS_MODE InPassMode);
    bool IsPassModeHigherOrEqual(const PASS_MODE InPassMode);
    bool IsLocalScopeToBeParsedNow();
    bool IsLocalScopeInOneLevelLow();
    void InitializeForPass();
    void SetSizesAndOffsets();
    void SizeType(BaseType & InBaseType);
    void SizeCompiledTemplate(CompiledTemplate & InCompiledTemplate);
};

#include "Compiler.h"

#include "Parser.hpp"
#endif
