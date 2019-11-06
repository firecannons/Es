
#ifndef FUNCTION_H
#define FUNCTION_H

#include "TemplatedType.h"
#include "Object.h"
#include "Scope.h"
#include <string>
using namespace std;

class Function
{
    
public:
    string Name;
    TemplatedType ReturnType;
    Scope MyScope;
    vector<Object*> Parameters;
    bool IsAsm;
    string Label;
};

#include "Function.hpp"
#endif
