
#ifndef COMPILEDTEMPLATE_H
#define COMPILEDTEMPLATE_H

#include "TemplatedType.h"
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
    bool HasUserDefinedEmptyConstructor;
    bool HasUserDefinedCopyConstructor;
    bool HasUserDefinedAssignmentOperator;
    bool HasUserDefinedDestructor;
    bool IsNewCompiledTemplate;
    PASS_MODE MostRecentPass;

    CompiledTemplate();
    
};

#include "CompiledTemplate.hpp"
#endif
