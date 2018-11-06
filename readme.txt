This is my compiler

1 is an initial unfinished version

2 is a version designed just for functionality

3 is a lexer

4 lexer is broken into its own class

5 is the same as 4 except extra code is broken out into library files

6 has a bad parser and is built off of 5

7 has a parser and is built off of 5.  Actually all the parsing step does is check for a "using" statement to add more files.

8 is the same as 7 except coded differently.

9 adds can process a 'class x' line and is based off of 8

10 can read class declarations and function declarations and is based off 9

11 accept good input, including templates, and is based on 10

12 adds more features, and is based off 11
