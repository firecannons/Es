
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
    SYMBOL
};

class Lexer
{
    
public:
    unsigned int Position;
    unsigned int PrevPosition;
    vector<string> Tokens;
    const unordered_set<char> FirstChars = {'<','>','/'};
    unordered_set<string> MultiCharOps;
    
    void Initialize();
    void InitializeMultiCharOps();
    vector<string> Lex(const string & InputCode);
    void AppendPrevWord(const string & InputCode);
    void AppendCurrentLetter(const string & InputCode);
    bool IsPossibleFirstChar(const char & OpChar) const;
    bool DoMultiCharGroupings(const string & InputCode);
    bool DoMultiCharGrouping(const string & Op, const string & InputCode);
};

#include "Lexer.hpp"
#endif
