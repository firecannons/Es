# Compiler for "Es"

This is a compiler for a pet programming language, currently called [Es](https://blazblue.wiki/wiki/Es).  It is an unfinished work at this time, and the latest commit might not be operational.  It currently can do very basic programs, only on Linux distrobutions, and has only been tested on Linux Mint and Ubuntu.  However, by adding more features to the compiler, and especially by adding more library code, much more functionality could be added.  It is a compiled language, compiled into assembly language for the [Flat Assembler (FASM)](https://flatassembler.net/) which can be assembled into an executable.  The old compiler for Es was written in Python3 but a new more advanced one has been written in C++.
 
## Inspiration - Evidence Based Programming
Inspiration for "Es" comes from a programming language named [Quorum](https://quorumlanguage.com/) designed by Dr. Andreas Stefik and a team at the University of Nevada, Las Vegas.  Quorum's syntax is "evidence based" which means that it's syntax was tested scientifically for programmer productivity in randomized controlled trials.  It's syntax was updated over time to yield the best performance for developers.  Quorum is the first of it's kind of evidence based programming languages.  "Es's" syntax is very similar to Quorum.  "Es" is different than Quorum in that "Es" is converted to FASM code and then compiled to an executable, while Quorum runs on top of the Java JVM.

Go [here](https://web.cs.unlv.edu/stefika/) for Dr. Stefik's website or [here](https://web.cs.unlv.edu/stefika/research.html) to see his publications.

To see a video presentation about Quorum and evidence based programming by Dr. Stefik go [here](https://www.youtube.com/watch?v=uEFrE6cgVNY) or [here](https://www.youtube.com/watch?v=VLBSvWZ5VuQ).

## Running "Es"
- You must be running a Linux distribution like Ubuntu.  Es does not yet work on Windows or Mac.  The compiler will only output FASM assembly for the Linux version of FASM.
- Install the Flat Assembler with apt or `sudo apt install fasm`<br>alternatively install FASM from it's [download page](https://flatassembler.net/download.php)
- Clone the [repository](https://github.com/firecannons/Es.git)
- Switch the C++ShiftReduce branch, not the master branch.
- Build the C++ compiler
- Run the compiler
- Run FASM on the assembly output to create a compiler executable
- Run the executable

In summary, run these
```
# Install fasm
sudo apt install fasm
# Clone the repository
git clone https://github.com/firecannons/Es.git
# Move the current working directory into the repository
cd compiler
# Switch to the C++ShiftReduce branch
git checkout C++ShiftReduce
# This is one of the latest working commits.
git checkout ff93f887ae91dc6b43f665251fa15625f9e9a3af
# The basic functionality of Program19.q is mostly working at this commit.
# Let's compile and run it.
make
# Now there is an executable named ./driver
./driver Programs/Program19.q Output
# Now there is a file named Output.asm which contains FASM assembly code.
fasm Output.asm Output
# Now there is an executable named "Output".  Let's make sure it has permission as an executable.
chmod +x Output
# Now lets run it.  Program19.q will prompt the user for a number and print out its square.
./Output
```
There will be a segmentation fault but that is simply because the programs don't explicitly exit at their end.  They work correctly while running.
