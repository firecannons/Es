
#ifndef SCOPE_H
#define SCOPE_H

#include "TemplatedType.h"
#include "Object.h"
#include <string>
using namespace std;

class Scope
{
    
public:
    int Offset;
    vector<Function> MemberFunctions;
    vector<Object> MemberObjects;
};

#include "Function.hpp"
#endif
