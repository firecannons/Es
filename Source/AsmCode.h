
#ifndef ASMCODE_H
#define ASMCODE_H

#include <string>
#include <map>
using namespace std;

class AsmCode
{
    
public:
    map<string, string> Codes;

    AsmCode();
};

AsmCode GlobalASM;

#include "AsmCode.hpp"
#endif
