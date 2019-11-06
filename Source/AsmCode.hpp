#include "AsmCode.h"

AsmCode::AsmCode()
{
    Codes.emplace(string("START_OF_FILE"), string("format ELF executable 3\nsegment readable executable\nentry Main"));
    Codes.emplace(string("RET"), string("ret"));
}