#include "AsmCode.h"

AsmCode::AsmCode()
{
    Codes.emplace(string("START_OF_FILE"), string("format ELF executable 3\nsegment readable executable\nentry "));
    Codes.emplace(string("RET"), string("ret"));
    Codes.emplace(string("RESERVE_SPACE"), string("add esp, "));
    Codes.emplace(string("MOV_EBX_EBP"), string("mov ebx, ebp"));
    Codes.emplace(string("ADD_NUM_TO_EBX"), string("add ebx, "));
    Codes.emplace(string("EBX_TO_STACK_TOP"), string(string("mov [esp], ebx")));
    Codes.emplace(string("DEREF_EBX"), string(string("mov ebx, [ebx]")));
    Codes.emplace(string("PUSH_REFERENCE_P1"), Codes["RESERVE_SPACE"]);
    Codes.emplace(string("PUSH_REFERENCE_P2"), string("\n") + Codes["MOV_EBX_EBP"] + string("\n") + Codes["ADD_NUM_TO_EBX"]);
    Codes.emplace(string("PUSH_REFERENCE_P3"), string("\n") + Codes["EBX_TO_STACK_TOP"]);
    Codes.emplace(string("CALL"), string("call "));
    Codes.emplace(string("SHIFT_UP_ASM"), string("add esp, "));
    Codes.emplace(string("CREATE_STACK_FRAME"), string("push ebp\nmov ebp, esp"));
    Codes.emplace(string("DESTROY_STACK_FRAME"), string("mov esp, ebp\npop ebp"));
    Codes.emplace(string("INTEGER_QUICK_ASSIGN"), string("mov dword [esp], "));
    Codes.emplace(string("DEREF_P1"), Codes["PUSH_REFERENCE_P2"]);
    Codes.emplace(string("DEREF_P2"), string("\n") + Codes["DEREF_EBX"]);
    Codes.emplace(string("PUSH_FROM_REFERENCE_P1"), Codes["RESERVE_SPACE"]);
    Codes.emplace(string("PUSH_FROM_REFERENCE_P2"), string("\n") + Codes["ADD_NUM_TO_EBX"]);
    Codes.emplace(string("PUSH_FROM_REFERENCE_P3"), string("\n") + Codes["EBX_TO_STACK_TOP"]);
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

string AsmCode::CalcPushFromBasePointer(const int ObjectOffset, const int ObjectSize)
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

string AsmCode::CalcIntegerQuickAssignAsm(const int Integer)
{
    string Output = Codes["INTEGER_QUICK_ASSIGN"] + to_string(Integer);
    return Output;
}

string AsmCode::CalcDerefForFuncCall(const int ReferenceOffset)
{
    string Output = Codes["DEREF_P1"] + to_string(ReferenceOffset) + Codes["DEREF_P2"];
    return Output;
}


string AsmCode::CalcPushFromReference(const int ObjectOffset, const int ObjectSize)
{
    string Output = Codes["PUSH_FROM_REFERENCE_P1"] + to_string(-((int)ObjectSize)) + Codes["PUSH_FROM_REFERENCE_P2"] + to_string(ObjectOffset) +
        Codes["PUSH_FROM_REFERENCE_P3"];
    return Output;
}
