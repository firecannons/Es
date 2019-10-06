
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

class Lexer
{
    
public:
    unsigned int Position;
    string SavedWord;
    vector<string> Tokens;
    unordered_set<string> CompleteOps;
    TEXT_TYPE LexMode;
    
    void Initialize();
    void InitializeMultiCharOps();
    vector<string> Lex(const string & InputCode);
    bool IsSavedWordCompleteOp();
    void AppendToSavedWord(const char NewChar);
    void AppendSavedWordToTokens();
    TEXT_TYPE GetTextTypeOfChar(const char InChar);
};

#include "Lexer.hpp"
#endif
