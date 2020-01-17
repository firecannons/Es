#include "Lexer.h"

void Lexer::Initialize(const string & InFileName)
{
    Position = STRING_START_POS;
    SavedWord = string("");
    Tokens.clear();
    SavedWordType = TEXT_TYPE::ALNUM;
    Mode = LEXER_MODE::NORMAL;
    LineNumber = 1;
    SourceFileName = InFileName;
    CountNextNewline = true;
}

vector<Token> Lexer::Lex(const string & InputCode, const string & SourceFileName)
{
    Initialize(SourceFileName);
    
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
        else if(Mode == LEXER_MODE::STRING_CONSTANT)
        {
            DoStringConstantMode(InputCode[Position]);
        }
        if(string(1, InputCode[Position]) == GlobalKeywords.ReservedWords["NEW_LINE"] && CountNextNewline == true)
        {
            LineNumber = LineNumber + 1;
        }
        else
        {
            CountNextNewline = true;
        }
        Position = Position + 1;
    }
    return Tokens;
}

void Lexer::DoAsmBlockMode(const char InChar)
{
    AppendToSavedWord(InChar);
    if(IsEndOfStringAfterWhiteSpaceAndNewline(SavedWord, "end") == true)
    {
        SavedWord.erase(SavedWord.end() - 3, SavedWord.end());
        Position = Position - 3;
        AppendSavedWordToTokens();
        Mode = LEXER_MODE::NORMAL;
        CountNextNewline = false;
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
        SavedWord = "\n";
        AppendSavedWordToTokens();
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
    if(CharType != TEXT_TYPE::WHITE_SPACE || InChar == '\n')
    {
        AppendToSavedWord(InChar);
    }
    if(IsInvalidGrouping() == true)
    {
        AppendCharactersToTokens();
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
    if(SavedWord == "'")
    {
        Mode = LEXER_MODE::STRING_CONSTANT;
    }
    if(InChar == '\n')
    {
        AppendSavedWordToTokens();
    }
}

bool Lexer::IsSavedWordCompleteOp()
{
    bool Found = false;
    if(DoesSetContain(SavedWord, GlobalKeywords.AllOperators) == true && DoesSetContain(SavedWord, GlobalKeywords.ShortOperators) == false)
    {
        Found = true;
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
        Tokens.push_back(Token());
        Tokens[Tokens.size() - 1].Contents = SavedWord;
        Tokens[Tokens.size() - 1].LineNumber = LineNumber;
        Tokens[Tokens.size() - 1].SourceFileName = SourceFileName;
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

bool Lexer::IsInvalidGrouping()
{
    bool Found = false;
    if(SavedWord.size() > 1 && SavedWordType == TEXT_TYPE::SYMBOL && DoesSetContain(SavedWord, GlobalKeywords.AllOperators) == false)
    {
        Found = true;
    }
    return Found;
}

void Lexer::AppendCharactersToTokens()
{
    string OldSavedWord = SavedWord;
    unsigned int Index = 0;
    while(Index < OldSavedWord.size())
    {
        SavedWord = OldSavedWord[Index];
        AppendSavedWordToTokens();
        Index = Index + 1;
    }
}

bool Lexer::IsEndOfStringAfterWhiteSpaceAndNewline(const string & Haystack, const string & Needle)
{
    bool Output = false;
    if(Haystack.size() > 0 && Haystack.size() > Needle.size())
    {
        if(Haystack.substr(Haystack.size() - Needle.size(), Needle.size()) == Needle)
        {
            bool HitNewline = false;
            bool HitNonWhitespace = false;
            unsigned int Index = Haystack.size() - Needle.size() - 1;
            while(Index > 0 && HitNewline == false && HitNonWhitespace == false)
            {
                if(GetTextTypeOfChar(Haystack[Index]) == TEXT_TYPE::WHITE_SPACE)
                {
                    if(Haystack[Index] == GlobalKeywords.ReservedWords["NEW_LINE"][0])
                    {
                        HitNewline = true;
                    }
                }
                else
                {
                    HitNonWhitespace = true;
                }
                Index = Index - 1;
            }
            if(HitNewline == true)
            {
                Output = true;
            }
        }
    }
    return Output;
}

void Lexer::DoStringConstantMode(const char InChar)
{
    AppendToSavedWord(InChar);
    if(IsEndOfString(SavedWord, "'") == true)
    {
        Mode = LEXER_MODE::NORMAL;
        AppendSavedWordToTokens();
        SavedWord.clear();
    }
}
