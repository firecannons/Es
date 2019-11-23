
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
    string CalcReserveSpaceAsm(const unsigned int ReserveAmount);
    string CalcStartOfFileAsm();
    string CalcRetAsm();
    string CalcPushFromBasePointer(const int ObjectOffset, const int ObjectSize);
    string CalcCallAsm(const string & LabelName);
    string CalcShiftUpAsm(const unsigned int ShiftAmount);
    string CalcCreateStackFrameAsm();
    string CalcDestroyStackFrameAsm();
    string CalcIntegerQuickAssignAsm(const int Integer);
    string CalcDerefForFuncCall(const int ReferenceOffset);
    string CalcPushFromReference(const int ObjectOffset, const int ObjectSize);
};

AsmCode GlobalASM;

#include "AsmCode.hpp"
#endif
