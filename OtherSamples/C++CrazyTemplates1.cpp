// This program does compile.
#include <iostream>
using namespace std;

template <typename T>
class Box
{
    T me;
};

template <typename T>
class Array
{
    T me;
    Box<T> me2;
};

template <typename T, typename R>
class AB
{
};

template <typename T>
class AC
{
    AB<Array<T>, T> me;
};

int main()
{
    
    Array<int> Me;
    
    AB<Array<int>, int> Me2;
    
    AC<int> Me3;

    return 0;
}
