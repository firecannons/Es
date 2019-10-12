#include "Lexer.h"

void Lexer::Initialize()
{
    Position = STRING_START_POS;
    SavedWord = string("");
    Tokens.clear();
    SavedWordType = TEXT_TYPE::ALNUM;
    Mode = LEXER_MODE::NORMAL;
    
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
}

vector<string> Lexer::Lex(const string & InputCode)
{
    Initialize();
    
    while(Position <= InputCode.size())
    {
        if(Mode == LEXER_MODE::NORMAL || Mode == LEXER_MODE::NORMAL_WAITING_FOR_ASM_BLOCK)
        {
            DoNormalLexMode(InputCode[Position]);
        }
        else if(Mode == LEXER_MODE::SINGLE_LINE_COMMENT)
        {
            DoSingleLineCommentMode(InputCode[Position]);
        }
        else if(Mode == LEXER_MODE::MULTI_LINE_COMMENT)
        {
            DoMultiLineCommentMode(InputCode[Position]);
        }
        else if(Mode == LEXER_MODE::ASM_BLOCK)
        {
            DoAsmBlockMode(InputCode[Position]);
        }
        Position = Position + 1;
    }
    return Tokens;
}

void Lexer::DoAsmBlockMode(const char InChar)
{
    AppendToSavedWord(InChar);
    if(IsEndOfString(SavedWord, "end") == true)
    {
        Mode = LEXER_MODE::NORMAL;
        AppendSavedWordToTokens();
    }
}

bool Lexer::IsEndOfString(const string & Haystack, const string & Needle)
{
    bool Output = false;
    if(Haystack.size() > 0 && Haystack.size() > Needle.size())
    {
        if(Haystack.substr(Haystack.size() - Needle.size(), Needle.size()) == Needle)
        {
            Output = true;
        }
    }
    return Output;
}

void Lexer::DoSingleLineCommentMode(const char InChar)
{
    AppendToSavedWord(InChar);
    if(IsEndOfString(SavedWord, "\n") == true)
    {
        Mode = LEXER_MODE::NORMAL;
        SavedWord.clear();
    }
}

void Lexer::DoMultiLineCommentMode(const char InChar)
{
    AppendToSavedWord(InChar);
    if(IsEndOfString(SavedWord, "*/") == true)
    {
        Mode = LEXER_MODE::NORMAL;
        SavedWord.clear();
    }
}

void Lexer::DoNormalLexMode(const char InChar)
{
    TEXT_TYPE CharType = GetTextTypeOfChar(InChar);
    if(CharType != SavedWordType)
    {
        AppendSavedWordToTokens();
    }
    SavedWordType = CharType;
    if(IsSavedWordCompleteOp() == true)
    {
        AppendSavedWordToTokens();
    }
    if(CharType != TEXT_TYPE::WHITE_SPACE)
    {
        AppendToSavedWord(InChar);
    }
    if(InChar == '\n')
    {
        AppendToSavedWord(InChar);
        AppendSavedWordToTokens();
    }
    if(SavedWord == "//")
    {
        Mode = LEXER_MODE::SINGLE_LINE_COMMENT;
    }
    if(SavedWord == "/*")
    {
        Mode = LEXER_MODE::MULTI_LINE_COMMENT;
    }
    if(SavedWord == "asm")
    {
        Mode = LEXER_MODE::NORMAL_WAITING_FOR_ASM_BLOCK;
    }
    if(SavedWord == "\n" && Mode == LEXER_MODE::NORMAL_WAITING_FOR_ASM_BLOCK)
    {
        Mode = LEXER_MODE::ASM_BLOCK;
    }
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
    else if(isalnum(InChar) == false && InChar != '_')
    {
        CharType = TEXT_TYPE::SYMBOL;
    }
    return CharType;
}
