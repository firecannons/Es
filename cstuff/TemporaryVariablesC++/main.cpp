#include <stdio.h>

class Person
{
public:
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
} ;

void func ( int i )
{
}

int  main()
{
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	int i = 1 + 2 ;
	func ( i + 1 ) ;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	printf ( "%d" , i ) ;
asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	Person P1 ;
asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	Person P2 ;
asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	Person P3 ;
asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	P3 = P3 + P2 ;
asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	P1 . hello ( P2 ) ;
	
	return 0;
}
