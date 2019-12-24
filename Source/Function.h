
#ifndef FUNCTION_H
#define FUNCTION_H

#include "TemplatedType.h"
#include "Object.h"
#include "Scope.h"
#include "Parser.h"
#include <string>
using namespace std;

class Function
{
    
public:
    string Name;
    Object ReturnObject;
    Scope MyScope;
    vector<Object*> Parameters;
    bool IsAsm;
    string Label;
    bool HasReturnObject;
    PASS_MODE LatestPassMode;
};

#include "Function.hpp"
#endif
