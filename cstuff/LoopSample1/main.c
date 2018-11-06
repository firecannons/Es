#include <stdio.h>

const char * MESSAGE = "Hello" ;
const unsigned int MAX = 10 ;

void LoopCount ( )
{
	unsigned int Counter = 0 ;
	while ( Counter < MAX )
	{
		printf ( "%s\n" , MESSAGE ) ;
		Counter = Counter + 1 ;
	}
}

int  main()
{
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	LoopCount ( ) ;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	
	return 0;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
}
