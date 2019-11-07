#include "AsmCode.h"

AsmCode::AsmCode()
{
    Codes.emplace(string("START_OF_FILE"), string("format ELF executable 3\nsegment readable executable\nentry Main"));
    Codes.emplace(string("RET"), string("ret"));
    Codes.emplace(string("RESERVE_SPACE"), string("add esp, "));
}

string AsmCode::CalcReserveSpaceAsm(const unsigned int ReserveAmount)
{
    string Output = Codes["RESERVE_SPACE"] + to_string(ReserveAmount);
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
