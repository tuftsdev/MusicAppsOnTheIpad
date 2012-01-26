//
//  SportsClient.cpp
//

#include <iostream>
#include "SportsClient.h"

using namespace std;

SportsClient::SportsClient()
{
    cout << "Starting record for client, 1..." << endl;
    this->firstName = "Anonymous";
    this->lastName = "Coward";
    this->email = "";
    this->age = 0;
}

SportsClient::SportsClient(string firstName, string lastName)
{
    cout << "Starting record for client, 2..." << endl;
    this->firstName = firstName;
    this->lastName = lastName;
    this->email = "";
    this->age = 0;    
}

SportsClient::SportsClient(string firstName, string lastName, string email, unsigned int age)
{
    cout << "Starting record for client, 3..." << endl;
    this->firstName = firstName;
    this->lastName = lastName;
    this->email = email;
    this->age = age;
}

string SportsClient::getFirstName()
{
    return firstName;
}

string SportsClient::getLastName()
{
    return lastName;
}

void SportsClient::setEmail (string email)
{
    this->email = email;
}

string SportsClient::getEmail()
{
    return email;
}

void SportsClient::setAge (unsigned int age)
{
    this->age = age;
}

unsigned int SportsClient::getAge()
{
    return age;
}

void SportsClient::setComments (string comments)
{
    this->comments = comments;
}

string SportsClient::getComments()
{
    return comments;
}

void SportsClient::sendEmail (string subject, string message)
{
    cout << "Sending email..." << endl;
}

void SportsClient::print()
{
    cout << firstName << " " << lastName << endl;
}

SportsClient::~SportsClient()
{
    cout << "Bye!" << endl;
}
