#include "Compiler.h"


void Compiler::Compile(const string & SourceProgram, const string & OutputProgram)
{
    string InputText = ReadInputFile(SourceProgram);
    string OutputText = CompileToOutputText(InputText);
    WriteToOutputFile(OutputText, OutputProgram);
}

string Compiler::ReadInputFile(const string & SourceProgram)
{
    ifstream In;
    In.open(SourceProgram);

    stringstream StringStream;
    StringStream << In.rdbuf();
    string SourceCode = StringStream.str();
    In.close();
    return SourceCode;
}


string Compiler::CompileToOutputText(const string & InputCode)
{
    return InputCode;
}


void Compiler::WriteToOutputFile(const string & OutputCode, const string & OutputFile)
{
    cout << OutputCode << OutputFile;
}
