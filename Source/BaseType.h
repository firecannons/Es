
#ifndef BASETYPE_H
#define BASETYPE_H

#include "CompiledTemplate.h"
#include "GlobalFunctions.h"
#include <string>
#include <vector>
#include <list>
using namespace std;

class BaseType
{
    
public:
    string Name;
    vector<string> PossibleTemplates;
    list<CompiledTemplate> CompiledTemplates;
    bool IsTemplated;
    vector<Token> Tokens;
    
    void InitializeBlankCompiledTemplate();
    CompiledTemplate * GetLastCompiledTemplate();
    CompiledTemplate * GetFirstCompiledTemplate();
};

#include "BaseType.hpp"
#endif
