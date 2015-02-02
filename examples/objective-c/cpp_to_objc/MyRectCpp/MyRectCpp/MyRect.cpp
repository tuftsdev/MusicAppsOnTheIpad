//
//  MyRect.cpp (the implementation)
//
//  Edit (9/25/2011): Special thanks to A.J. Jenkins (student in COMP 15) for pointing out that I didn't accomodate invariant correctly in constructors
//  Created by Ming Chow on 9/21/2011; updated on 1/23/2013
//

#include <iostream>
#include <math.h> // required for sqrt() and pow() function
#include "MyRect.h"

using namespace std;

MyRect::MyRect()
{
    length = 0;
    width = 0;
    x = 0;
    y = 0;
    id = "";
    cout << "In constructor 1" << endl;
}

MyRect::MyRect (int length, int width)
{
    if (length >= 0) {
        this->length = length;
    }
    else {
        cout << "Length has to be >= 0" << endl;
        this->length = 0;
    }
    if (width >= 0) {
        this->width = width;
    }
    else {
        cout << "Width has to be >= 0" << endl;
        this->width = 0;
    }
    x = 0;
    y = 0;
    id = "";
    cout << "In constructor 2" << endl;
}

MyRect::MyRect (int length, int width, int x, int y)
{
    if (length >= 0) {
        this->length = length;
    }
    else {
        cout << "Length has to be >= 0" << endl;
        this->length = 0;
    }
    if (width >= 0) {
        this->width = width;
    }
    else {
        cout << "Width has to be >= 0" << endl;
        this->width = 0;
    }
    this->x = x;
    this->y = y;
    id = "";
    cout << "In constructor 3" << endl;
}

MyRect MyRect::operator+ (MyRect r2)
{
  MyRect newRect;
  newRect.length = length + r2.length;
  newRect.width = width + r2.width;
  newRect.x = x;
  newRect.y = y;
  return newRect;
}

bool MyRect::operator== (MyRect r2)
{
  return ((length == r2.length && width == r2.width) || (length == r2.width && width == r2.length));
}

int MyRect::getArea()
{
    return length * width;
}

int MyRect::getPerimeter()
{
    return 2 * (length + width);
}

double MyRect::getDiagonal()
{
    return sqrt(pow(length,2) + pow(width,2));
}

bool MyRect::isSquare()
{
    return length == width;
}

int MyRect::getX()
{
    return x;
}

int MyRect::getY()
{
    return y;
}

void MyRect::setX(int newX)
{
    x = newX;
}

void MyRect::setY(int newY)
{
    y = newY;
}

int MyRect::getLength()
{
    return length;
}

int MyRect::getWidth()
{
    return width;
}

void MyRect::setLength(int newLength)
{
    if (newLength >= 0) {
        length = newLength;
    }
    else {
        cout << "Length has to be >= 0" << endl;
    }
}

void MyRect::setWidth(int newWidth)
{
    if (newWidth >= 0) {
        width = newWidth;
    }
    else {
        cout << "Width has to be >= 0" << endl;
    }
}

string MyRect::getId()
{
    return id;
}

void MyRect::setId(string id)
{
    this->id = id;
}

MyRect::~MyRect()
{
    cout << "Good-bye " << id << "!!!" << endl;
}
