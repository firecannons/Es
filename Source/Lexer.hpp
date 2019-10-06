#include "Lexer.h"

void Lexer::Initialize()
{
    Position = STRING_START_POS;
    SavedWord = string("");
    Tokens.clear();
    LexMode = TEXT_TYPE::ALNUM;
    
    InitializeMultiCharOps();
}

void Lexer::InitializeMultiCharOps()
{
    CompleteOps.emplace(string("<="));
    CompleteOps.emplace(string(">="));
    CompleteOps.emplace(string("//"));
    CompleteOps.emplace(string("("));
    CompleteOps.emplace(string(")"));
    CompleteOps.emplace(string("<"));
    CompleteOps.emplace(string(">"));
    CompleteOps.emplace(string(":"));
    CompleteOps.emplace(string("="));
    CompleteOps.emplace(string("//"));
}

vector<string> Lexer::Lex(const string & InputCode)
{
    Initialize();
    
    while(Position <= InputCode.size())
    {
        TEXT_TYPE CharType = GetTextTypeOfChar(InputCode[Position]);
        if(CharType != LexMode)
        {
            AppendSavedWordToTokens();
        }
        LexMode = CharType;
        if(IsSavedWordCompleteOp() == true)
        {
            AppendSavedWordToTokens();
        }
        if(CharType != TEXT_TYPE::WHITE_SPACE)
        {
            AppendToSavedWord(InputCode[Position]);
        }
        Position = Position + 1;
    }
    return Tokens;
}

bool Lexer::IsSavedWordCompleteOp()
{
    bool Found = true;
    unordered_set<string>::const_iterator End = CompleteOps.find(SavedWord);
    if (End == CompleteOps.end())
    {
        Found = false;
    }
    return Found;
}

void Lexer::AppendToSavedWord(const char NewChar)
{
    SavedWord.push_back(NewChar);
}

void Lexer::AppendSavedWordToTokens()
{
    if(SavedWord.size() > 0)
    {
        Tokens.push_back(SavedWord);
        SavedWord.clear();
    }
}

TEXT_TYPE Lexer::GetTextTypeOfChar(const char InChar)
{
    TEXT_TYPE CharType = TEXT_TYPE::ALNUM;
    // Do not use "true".  "true" == 1, but these old c functions return 0, or
    //   some nonzero number.
    if(isblank(InChar) != false || iscntrl(InChar) != false)
    {
        CharType = TEXT_TYPE::WHITE_SPACE;
    }
    else if(isalnum(InChar) == false)
    {
        CharType = TEXT_TYPE::SYMBOL;
    }
    return CharType;
}