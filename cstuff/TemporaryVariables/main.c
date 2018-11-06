#include <stdio.h>

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
	
	return 0;
}
