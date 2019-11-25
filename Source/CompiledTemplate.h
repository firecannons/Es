
#ifndef COMPILEDTEMPLATE_H
#define COMPILEDTEMPLATE_H

#include "TemplatedType.h"
#include "Function.h"
#include "Object.h"
#include "Scope.h"
#include <string>
#include <vector>
using namespace std;

class CompiledTemplate
{
    
public:
    vector<TemplatedType> Templates;
    unsigned int Size;
    Scope MyScope;
    bool HasSizeBeenCalculated;

    CompiledTemplate();
    
};

#include "CompiledTemplate.hpp"
#endif
