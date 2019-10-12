
#ifndef FUNCTION_H
#define FUNCTION_H

#include "TemplatedType.h"
#include "Object.h"
#include <string>
using namespace std;

class Function
{
    
public:
    string Name;
    TemplatedType ReturnType;
    vector<Object> Parameters;
};

#include "Function.hpp"
#endif
