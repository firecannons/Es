#ifndef GLOBALFUNCTIONS_H
#define GLOBALFUNCTIONS_H

#include "Token.h"
#include <iostream>
#include <stdlib.h>
#include <vector>
#include <map>
#include <unordered_set>
#include <fstream>
#include <list>
using namespace std;

const char FAIL_COLOR_TEXT[] = "\033[91m";
const char END_COLOR_TEXT[] = "\033[0m";
const char ERROR_START_TEXT[] = "ERROR: ";
const char ON_LINE_TEXT[] = " on line ";
const bool END_ON_ERROR = true;
const int NOT_FOUND_POSITION = -1;


void PrintError(const string & ErrorMessage)
{
    cout << FAIL_COLOR_TEXT << ErrorMessage << END_COLOR_TEXT << endl;
    if(END_ON_ERROR == true)
    {
        exit(EXIT_FAILURE);
    }
}

string OutputTokensToString(const vector<Token> & Tokens)
{
    string OutputString;
    unsigned int Index = 0;
    while(Index < Tokens.size())
    {
        OutputString = OutputString + "'" + Tokens[Index].Contents + "'\n";
        Index = Index + 1;
    }
    return OutputString;
}

void OutputTokens(const vector<Token> & Tokens)
{
    cout << OutputTokensToString(Tokens);
}

bool DoesSetContain(const string & SearchWord, const unordered_set<string> & MySet)
{
    bool Found = true;
    if(MySet.count(SearchWord) == 0)
    {
        Found = false;
    }
    return Found;
}

template<class T>
bool DoesMapContain(const string & SearchWord, const map<string, T> & MyMap)
{
    bool Found = true;
    if(MyMap.count(SearchWord) == 0)
    {
        Found = false;
    }
    return Found;
}

bool DoesFileExist(const string & FileName)
{
    bool Output = false;
    ifstream InputFile(FileName);
    if(InputFile)
    {
        Output = true;
    }
    return Output;
}

int LocationInVector(const string & SearchWord, const vector<string> & InVector)
{
    int Position = NOT_FOUND_POSITION;
    unsigned int Index = 0;
    while(Index < InVector.size() && Position == NOT_FOUND_POSITION)
    {
        if(InVector[Index] == SearchWord)
        {
            Position = Index;
        }
        Index = Index + 1;
    }
    return Position;
}

bool DoesVectorContain(const string & SearchWord, const vector<string> & InVector)
{
    bool Found = false;
    if(LocationInVector(SearchWord, InVector) != NOT_FOUND_POSITION)
    {
        Found = true;
    }
    return Found;
}

template<class T>
T & GetInList(const list<T> & InList, const unsigned int Position)
{
    unsigned int Index = 0;
    typename list<T>::const_iterator it = InList.begin();
    while(Index < Position)
    {
        Index = Index + 1;
        it++;
    }
    return (T &)*it;
}

template<class T>
T Reverse(T & InVector)
{
    T NewVector;
    unsigned int Index = 0;
    while(Index < InVector.size())
    {
        NewVector.push_back(InVector[InVector.size() - Index - 1]);
        Index = Index + 1;
    }
    return NewVector;
}

#endif
