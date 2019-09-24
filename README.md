# Compiler for "Es"

This is a compiler for a pet programming language, currently called [Es](https://blazblue.wiki/wiki/Es).  It is an unfinished work at this time, and the latest commit might not be operational.  It currently can do very basic programs and only on Ubuntu.  It is a compiled language, compiled into assembly language for the [Flat Assembler (FASM)](https://flatassembler.net/) which can be assembled into an executable.  The compiler has been written in Python3.
 
## Inspiration - Evidence Based Programming
Inspiration for "Es" comes from a programming language named [Quorum](https://quorumlanguage.com/) designed by Dr. Andreas Stefik and a team at the University of Nevada, Las Vegas.  Quorum's syntax is "evidence based" which means that it's syntax was tested scientifically against programmer productivity in randomized controlled trials.  It's syntax was updated over time to yield the best performance for developers.  Quorum is the first of it's kind of evidence based programming languages.  "Es's" syntax is very similar to Quorum.  "Es" is different than Quorum in that "Es" is converted to FASM code and then compiled to an executable, while Quorum runs on top of the Java JVM.

Go [here](https://web.cs.unlv.edu/stefika/) for Dr. Stefik's website or [here](https://web.cs.unlv.edu/stefika/research.html) to see his publications.

To see a video presentation about Quorum and evidence based programming by Dr. Stefik go [here](https://www.youtube.com/watch?v=uEFrE6cgVNY) or [here](https://www.youtube.com/watch?v=VLBSvWZ5VuQ).

## Running "Es"
- You must be running a Linux distrobution like Ubuntu.  The compiler will only output FASM assembly for the Linux version of FASM.
- Install Python3 `sudo apt install python3`
- Install the Flat Assembler with apt or `sudo apt install fasm`<br>alternatively install FASM from it's [download page](https://flatassembler.net/download.php)
- Clone the [repository](https://gitlab.com/firecannons/compiler.git)
- Checkout commit 85bd5457f136e0f769c13c216c1fa1ea7b63306d since it is a relatively recent commit that is working.
- Run the compiler
- Run FASM on the assembly output
- Run the executable

In summary, run these
```
sudo apt install python3
sudo apt install fasm
git clone https://gitlab.com/firecannons/compiler.git
cd compiler
# This is one of the latest working commits.
git checkout 85bd5457f136e0f769c13c216c1fa1ea7b63306d
# Program2.q and Program3.q are currently compilable at this time.
python3 Compiler.py Programs/Program3.q Output
# Now there is a file named Output.asm which contains FASM assembly code.
fasm Output.asm Output
# Now there is an executable named "Output"
./Output
```
There will be a segmentation fault but that is simply because the programs don't explitly exit at their end.  They work correctly while running.