
#ifndef KEYWORDS_H
#define KEYWORDS_H

#include <string>
#include <map>
#include <unordered_set>
#include <iostream>
using namespace std;

class Keywords
{
    
public:
    map<string, string> ReservedWords;
    unordered_set<string> AllOperators;
    unordered_set<string> OverloadableOperators;
    unordered_set<string> ShortOperators;
    unordered_set<string> AfterDeclarationOperators;
    unordered_set<string> ReducibleOperators;
    unordered_set<string> ScopeCreateKeywords;
    map<string, string> AsmLinkWords;

    Keywords();
};

Keywords GlobalKeywords;

#include "Keywords.hpp"
#endif
