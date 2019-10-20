
#ifndef KEYWORDS_H
#define KEYWORDS_H

#include <string>
#include <map>
#include <unordered_set>
#include <iostream>

class Keywords
{
    
public:
    map<string, string> ReservedWords;
    unordered_set<string> AllOperators;
    unordered_set<string> OverloadableOperators;

    Keywords();
};

Keywords GlobalKeywords;

#include "Keywords.hpp"
#endif
