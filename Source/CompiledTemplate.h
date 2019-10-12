
#ifndef COMPILEDTEMPLATE_H
#define COMPILEDTEMPLATE_H

#include "TemplatedType.h"
#include "Function.h"
#include "Object.h"
#include <string>
#include <vector>
using namespace std;

class CompiledTemplate
{
    
public:
    vector<TemplatedType> Templates;
    unsigned int Size;
    vector<CompiledTemplate> CompiledTemplates;
    bool IsTemplated;
    Scope TheScope;
};

#include "CompiledTemplate.hpp"
#endif
