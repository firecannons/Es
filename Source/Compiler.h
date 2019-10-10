
#ifndef COMPILER_H
#define COMPILER_H

#include "GlobalFunctions.h"
#include "Lexer.h"
#include "Parser.h"
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
using namespace std;

class Compiler
{
    
public:
    void static Compile(const string & SourceProgram, const string & OutputProgram);
    
    string static ReadInputFile(const string & SourceName);
    
    string static CompileToOutputText(const string & InputCode);
    
    void static WriteToOutputFile(const string & OutputCode, const string & OutputFile);
};

#include "Compiler.hpp"
#endif
