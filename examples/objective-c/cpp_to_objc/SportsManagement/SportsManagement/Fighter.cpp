//
//  Fighter.cpp
//

#include <iostream>
#include "Fighter.h"

using namespace std;

Fighter::Fighter (string firstName, string lastName, string email, unsigned int age):SportsClient(firstName, lastName, email, age)
{
    cout << "Starting record for fighter..." << endl;
    weight = 0;
    nickname = "";
    affiliation = "";
}

void Fighter::setWeight(unsigned int weight)
{
    this->weight = weight;
}

unsigned int Fighter::getWeight()
{
    return weight;
}

void Fighter::setNickname(string nickname)
{
    this->nickname = nickname;
}

string Fighter::getNickname()
{
    return nickname;
}

void Fighter::setAffiliation(string affiliation)
{
    this->affiliation = affiliation;
}

string Fighter::getAffiliation()
{
    return affiliation;
}

void Fighter::print()
{
    cout << "First Name => " << getFirstName() << endl;
    cout << "Last Name => " << getLastName() << endl;
    cout << "E-Mail Address => " << getEmail() << endl;
    cout << "Age => " << getAge() << endl;
    cout << "Weight => " << weight << endl;
    cout << "Nickname => " << nickname << endl;
    cout << "Affiliation => " << affiliation << endl;
}

Fighter::~Fighter()
{
    cout << "...boo..." << endl;
}
