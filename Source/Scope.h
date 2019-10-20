
#ifndef SCOPE_H
#define SCOPE_H

#include "TemplatedType.h"
#include "Object.h"
#include <string>
#include <map>
using namespace std;

class Scope
{
    
public:
    int Offset;
    map<string, Function> MemberFunctions;
    map<string, Object> MemberObjects;
};

#include "Function.hpp"
#endif
