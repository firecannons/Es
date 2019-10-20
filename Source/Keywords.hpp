#include "Keywords.h"

Keywords::Keywords()
{

    ReservedWords.insert(pair<string,string>(string("CLASS"), string("class")));
    ReservedWords.insert(pair<string,string>(string("ACTION"), string("action")));
    ReservedWords.insert(pair<string,string>(string("USING"), string("using")));
    ReservedWords.insert(pair<string,string>(string("DOT"), string(".")));
    ReservedWords.insert(pair<string,string>(string("BACK_SLASH"), string("\\")));
    ReservedWords.insert(pair<string,string>(string("FORWARD_SLASH"), string("/")));
    ReservedWords.insert(pair<string,string>(string("NEW_LINE"), string("\n")));
    ReservedWords.insert(pair<string,string>(string("LEFT_BRACKET"), string("<")));
    ReservedWords.insert(pair<string,string>(string("RIGHT_BRACKET"), string(">")));
    ReservedWords.insert(pair<string,string>(string("COMMA"), string(",")));
    ReservedWords.insert(pair<string,string>(string("SIZE"), string("size")));
    ReservedWords.insert(pair<string,string>(string("RETURNS"), string("returns")));
    ReservedWords.insert(pair<string,string>(string("RETURN"), string("return")));
    ReservedWords.insert(pair<string,string>(string("LPAREN"), string("(")));
    ReservedWords.insert(pair<string,string>(string("RPAREN"), string(")")));
    ReservedWords.insert(pair<string,string>(string("ASM"), string("asm")));

    OverloadableOperators.emplace(string("<="));
    OverloadableOperators.emplace(string(">="));
    OverloadableOperators.emplace(ReservedWords["LEFT_BRACKET"]);
    OverloadableOperators.emplace(ReservedWords["RIGHT_BRACKET"]);
    OverloadableOperators.emplace(string("="));

    AllOperators = OverloadableOperators;
    AllOperators.emplace(string("//"));
    AllOperators.emplace(ReservedWords["LPAREN"]);
    AllOperators.emplace(ReservedWords["RPAREN"]);
    AllOperators.emplace(string(":"));
}