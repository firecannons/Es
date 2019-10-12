
#ifndef COMPILER_H
#define COMPILER_H

#include "GlobalFunctions.h"
#include "Lexer.h"
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
using namespace std;

class Compiler
{
    
public:
    void Compile(const string & SourceFile, const string & OutputFile);

    string CompileToAsm(const string & SourceFile);
    
    string ReadInputFile(const string & SourceName);
    
    string CompileToOutputText(const string & InputCode);
    
    void WriteToOutputFile(const string & OutputCode, const string & OutputFile);
};

#include "Parser.h"

#include "Compiler.hpp"
#endif
