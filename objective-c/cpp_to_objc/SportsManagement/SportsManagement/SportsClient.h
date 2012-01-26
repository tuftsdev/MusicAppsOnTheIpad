//
//  SportsClient.h
//

#ifndef SportsManagement_Client_h
#define SportsManagement_Client_h

#include <iostream>

using namespace std;

class SportsClient
{
private:
    string firstName;
    string lastName;
    string email;
    unsigned int age;
    string comments;
public:
    SportsClient();
    SportsClient(string firstName, string lastName);
    SportsClient(string firstName, string lastName, string email, unsigned int age);
    string getFirstName();
    string getLastName();
    void setEmail (string email);
    string getEmail();
    void setAge (unsigned int age);
    unsigned int getAge();
    void setComments (string comments);
    string getComments();
    void sendEmail (string subject, string message);
    void print();    
    ~SportsClient();
};

#endif
