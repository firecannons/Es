
#ifndef OBJECT_H
#define OBJECT_H

#include "TemplatedType.h"
#include <string>
using namespace std;

class Object
{
    
public:
    string Name;
    TemplatedType Type;
    int Offset;
    bool IsConstant;
    bool IsReference;
    int ReferenceOffset;
    SCOPE_ORIGIN OuterScopeOrigin;
    string GlobalName;

    Object();
};

#include "Object.hpp"
#endif
