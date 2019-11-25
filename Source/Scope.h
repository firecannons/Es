
#ifndef SCOPE_H
#define SCOPE_H

#include "TemplatedType.h"
#include "Object.h"
#include <string>
#include <map>
using namespace std;

enum SCOPE_ORIGIN
{
    GLOBAL,
    CLASS,
    FUNCTION,
    IF,
    REPEAT
};

class Scope
{
    
public:
    int Offset;
    map<string, Function> Functions;
    map<string, Object> Objects;
    vector<Object *> OrderedObjects;
    SCOPE_ORIGIN Origin;

    Scope();
};

#include "Scope.hpp"
#endif
