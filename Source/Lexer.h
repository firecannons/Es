
#ifndef LEXER_H
#define LEXER_H

#include "Keywords.h"
#include "Token.h"
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
    NORMAL_WAITING_FOR_ASM_BLOCK,
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
    vector<Token> Tokens;
    TEXT_TYPE SavedWordType;
    LEXER_MODE Mode;
    unsigned int LineNumber;
    string SourceFileName;
    bool CountNextNewline;
    
    
    void Initialize(const string & SourceFileName);
    vector<Token> Lex(const string & InputCode, const string & SourceFileName);
    void DoAsmBlockMode(const char InChar);
    bool IsEndOfString(const string & Haystack, const string & Needle);
    bool IsEndOfStringAfterWhiteSpaceAndNewline(const string & Haystack, const string & Needle);
    void DoSingleLineCommentMode(const char InChar);
    void DoMultiLineCommentMode(const char InChar);
    void DoNormalLexMode(const char InChar);
    bool IsSavedWordCompleteOp();
    void AppendToSavedWord(const char NewChar);
    void AppendSavedWordToTokens();
    TEXT_TYPE GetTextTypeOfChar(const char InChar);
    bool IsInvalidGrouping();
    void AppendCharactersToTokens();
};

#include "Lexer.hpp"
#endif
