
#ifndef LEXER_H
#define LEXER_H

#include <string>
#include <vector>
#include <cctype>
#include <unordered_set>
using namespace std;

const unsigned int STRING_START_POS = 0;
const unsigned int CHARACTER_LENGTH = 1;

enum TEXT_TYPE
{
    ALNUM,
    SYMBOL,
    WHITE_SPACE
};

enum LEXER_MODE
{
    NORMAL,
    SINGLE_LINE_COMMENT,
    MULTI_LINE_COMMENT,
    ASM_BLOCK,
    STRING_CONSTANT
};

class Lexer
{
    
public:
    unsigned int Position;
    string SavedWord;
    vector<string> Tokens;
    unordered_set<string> CompleteOps;
    TEXT_TYPE SavedWordType;
    LEXER_MODE Mode;
    
    void Initialize();
    void InitializeMultiCharOps();
    vector<string> Lex(const string & InputCode);
    bool IsEndOfString(const string & Haystack, const string & Needle);
    void DoSingleLineCommentMode(const char InChar);
    void DoMultiLineCommentMode(const char InChar);
    void DoNormalLexMode(const char InChar);
    bool IsSavedWordCompleteOp();
    void AppendToSavedWord(const char NewChar);
    void AppendSavedWordToTokens();
    TEXT_TYPE GetTextTypeOfChar(const char InChar);
};

#include "Lexer.hpp"
#endif
