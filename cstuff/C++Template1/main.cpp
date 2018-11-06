#include <stdio.h>
#include <iostream>

template < class T >
class Person
{

public:
T myT;
	Person ( )
	{
	}	

	Person operator + ( const Person & Source )
	{
		return * this ;
	}
	
	Person operator = ( const Person & Source )
	{
		return * this ;
	}
	
	void hello ( const Person & Source )
	{
		
	}
	
	void Output ( )
	{
		std::cout << myT << std::endl;
	}
} ;

void func ( int i )
{
}

int  main()
{
	asm (";\n;\n;\n;1\n;\n;\n;");
	Person < char * > StrPerson ;
	asm (";\n;\n;\n;2\n;\n;\n;");
	Person < int > IntPerson ;
	asm (";\n;\n;\n;3\n;\n;\n;");
	StrPerson . myT = "hello" ;
	asm (";\n;\n;\n;4\n;\n;\n;");
	IntPerson . myT = 15 ;
	asm (";\n;\n;\n;5\n;\n;\n;");
	StrPerson . Output ( ) ;
	asm (";\n;\n;\n;6\n;\n;\n;");
	IntPerson . Output ( ) ;
	
	return 0;
}
