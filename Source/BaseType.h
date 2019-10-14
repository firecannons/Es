
#ifndef BASETYPE_H
#define BASETYPE_H

#include "CompiledTemplate.h"
#include <string>
#include <vector>
using namespace std;

class BaseType
{
    
public:
    string Name;
    vector<string> PossibleTemplates;
    vector<CompiledTemplate> CompiledTemplates;
    bool IsTemplated;
    
    void InitializeBlankCompiledTemplate();
};

#include "BaseType.hpp"
#endif
