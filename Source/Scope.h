
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
    map<string, FunctionList> Functions;
    map<string, Object> Objects;
    vector<Object *> OrderedObjects;
    SCOPE_ORIGIN Origin;
    string ControlStructureBeginLabel;
    string ControlStructureEndLabel;

    Scope();
    bool IsControlStructureScope();
};

#include "FunctionList.h"

#include "Scope.hpp"
#endif
