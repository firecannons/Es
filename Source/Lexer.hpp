#include "Lexer.h"

void Lexer::Initialize()
{
    Position = STRING_START_POS;
    PrevPosition = STRING_START_POS;
    Tokens.clear();
    
    InitializeMultiCharOps();
}

void Lexer::InitializeMultiCharOps()
{
    MultiCharOps.emplace(string("<="));
    MultiCharOps.emplace(string(">="));
    MultiCharOps.emplace(string("//"));
}

vector<string> Lexer::Lex(const string & InputCode)
{
    Initialize();
    
    Position = Position + 1;
    while(Position <= InputCode.size())
    {
        
        if(isalpha(InputCode.c_str()[Position - 1]) == false)
        {
            AppendPrevWord(InputCode);
            if(isblank(InputCode.c_str()[Position - 1]) == false)
            {
                /*if(DoMultiCharGroupings(InputCode) == true)
                {
                }
                else*/
                {
                    AppendCurrentLetter(InputCode);
                }
            }
            else
            {
                PrevPosition = PrevPosition + 1;
            }
        }
        Position = Position + 1;
    }
    return Tokens;
}

void Lexer::AppendPrevWord(const string & InputCode)
{
    if(Position - PrevPosition > 1)
    {
        Tokens.push_back(InputCode.substr(PrevPosition, Position - PrevPosition));
    }
    PrevPosition = Position;
}

void Lexer::AppendCurrentLetter(const string & InputCode)
{
    Tokens.push_back(InputCode.substr(PrevPosition, CHARACTER_LENGTH));
}

bool Lexer::IsPossibleFirstChar(const char & OpChar) const
{
    bool Output = false;
    unordered_set<char>::const_iterator Pos = FirstChars.find(OpChar);
    if(Pos != FirstChars.end())
    {
        Output = true;
    }
    return Output;
}

bool Lexer::DoMultiCharGroupings(const string & InputCode)
{
    bool IsValid = false;
    for (std::unordered_set<string>::iterator itr = MultiCharOps.begin(); itr != MultiCharOps.end(); ++itr)
    {
        string MultiCharOp = *itr;
        if(DoMultiCharGrouping(MultiCharOp, InputCode) == true)
        {
            IsValid = true;
        }
    }
    return IsValid;
}

bool Lexer::DoMultiCharGrouping(const string & Op, const string & InputCode)
{
    bool IsValidGrouping = true;
    if(Op.size() + Position > InputCode.size())
    {
        IsValidGrouping = false;
    }
    else
    {
        unsigned int Index = 0;
        while(Index < Op.size())
        {
            if(InputCode[Index + Position - 1] != Op[Index])
            {
                IsValidGrouping = false;
            }
            Index = Index + 1;
        }
        Tokens.push_back(InputCode.substr(Position - 1, Op.size()));
        Position = Position + Op.size();
        PrevPosition = Position;
    }
    return IsValidGrouping;
}
