//
//  Fighter.h
//

#ifndef SportsManagement_Fighter_h
#define SportsManagement_Fighter_h

#include <iostream>
#include "SportsClient.h"

using namespace std;

class Fighter: public SportsClient
{
private:
    unsigned int weight;
    string nickname;
    string affiliation;
    
public:
    Fighter (string firstName, string lastName, string email, unsigned int age);
    void setWeight(unsigned int weight);
    unsigned int getWeight();
    void setNickname(string nickname);
    string getNickname();
    void setAffiliation(string affiliation);
    string getAffiliation();
    void print();
    ~Fighter();
};

#endif
