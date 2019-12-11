
#ifndef FUNCTIONLIST_H
#define FUNCTIONLIST_H

#include "Function.h"
#include "Parser.h"
#include <list>

class FunctionList
{
    
public:
    list<Function> Functions;


    void InitializeBlankFunction();
    Function * GetLastFunction();
    Function * GetFirstFunction();
    Function * GetFirstFunctionNotOfPassMode(const PASS_MODE InPassMode);
};

#include "FunctionList.hpp"
#endif
