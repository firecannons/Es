#ifndef GLOBALFUNCTIONS_H
#define GLOBALFUNCTIONS_H

#include <iostream>
#include <stdlib.h>
#include <vector>
using namespace std;

const char FAIL_COLOR_TEXT[] = "\033[91m";
const char END_COLOR_TEXT[] = "\033[0m";
const char ERROR_START_TEXT[] = "ERROR: ";
const char ON_LINE_TEXT[] = " on line ";
const bool END_ON_ERROR = true;


void PrintError(const char ErrorMessage[])
{
    cout << FAIL_COLOR_TEXT << ErrorMessage << END_COLOR_TEXT << endl;
    if(END_ON_ERROR == true)
    {
        exit (EXIT_FAILURE);
    }
}

void OutputTokens(const vector<string> & Tokens)
{
    unsigned int Index = 0;
    while(Index < Tokens.size())
    {
        cout << Tokens[Index] << endl;
        Index = Index + 1;
    }
}

#endif
