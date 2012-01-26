//
//  main.cpp
//

#include <iostream>
#include "Fighter.h"

using namespace std;

int main (int argc, const char * argv[])
{
    // Questions:
    // 1: What is the output of the code below?
    // 2: List everything that you know about the code provided to you (including the attached .h and .cpp files).  Examples: pointer variable used, functions are being called, etc.
    
    Fighter *f = new Fighter("Jon", "Jones", "UNKNOWN", 24);
    f->setAffiliation("UFC");
    f->setNickname("Bones");
    f->setWeight(205);
    f->print();
    delete f;
    return 0;
}
