#include "AsmCode.h"

AsmCode::AsmCode()
{
    Codes.emplace(string("START_OF_FILE"), string("format ELF executable 3\nsegment readable executable\nentry "));
    Codes.emplace(string("RET"), string("ret"));
    Codes.emplace(string("RESERVE_SPACE"), string("add esp, "));
    Codes.emplace(string("PUSH_REFERENCE_P1"), string("add esp, "));
    Codes.emplace(string("PUSH_REFERENCE_P2"), string("\nmov ebx, ebp\nadd ebx, "));
    Codes.emplace(string("PUSH_REFERENCE_P3"), string("\nmov [esp], ebx"));
    Codes.emplace(string("CALL"), string("call "));
    Codes.emplace(string("SHIFT_UP_ASM"), string("add esp, "));
    Codes.emplace(string("CREATE_STACK_FRAME"), string("push ebp\nmov ebp, esp"));
    Codes.emplace(string("DESTROY_STACK_FRAME"), string("mov esp, ebp\npop ebp"));
}

string AsmCode::CalcReserveSpaceAsm(const unsigned int ReserveAmount)
{
    string Output = Codes["RESERVE_SPACE"] + to_string(-((int)ReserveAmount));
    return Output;
}

string AsmCode::CalcStartOfFileAsm()
{
    string Output = Codes["START_OF_FILE"];
    return Output;
}

string AsmCode::CalcRetAsm()
{
    string Output = Codes["RET"];
    return Output;
}

string AsmCode::CalcReferenceToPositionAsm(const int ObjectOffset, const int ObjectSize)
{
    string Output = Codes["PUSH_REFERENCE_P1"] + to_string(-((int)ObjectSize)) + Codes["PUSH_REFERENCE_P2"] + to_string(ObjectOffset) +
        Codes["PUSH_REFERENCE_P3"];
    return Output;
}

string AsmCode::CalcCallAsm(const string & LabelName)
{
    string Output = Codes["CALL"] + LabelName;
    return Output;
}

string AsmCode::CalcShiftUpAsm(const unsigned int ShiftAmount)
{
    string Output = Codes["SHIFT_UP_ASM"] + to_string(ShiftAmount);
    return Output;
}

string AsmCode::CalcCreateStackFrameAsm()
{
    string Output = Codes["CREATE_STACK_FRAME"];
    return Output;
}

string AsmCode::CalcDestroyStackFrameAsm()
{
    string Output = Codes["DESTROY_STACK_FRAME"];
    return Output;
}