
#ifndef FUNCTIONLIST_H
#define FUNCTIONLIST_H

#include "Function.h"
#include <list>

class FunctionList
{
    
public:
    list<Function> Functions;

    void InitializeBlankFunction();
    Function * GetLastFunction();
    Function * GetFirstFunction();
};

#include "FunctionList.hpp"
#endif
