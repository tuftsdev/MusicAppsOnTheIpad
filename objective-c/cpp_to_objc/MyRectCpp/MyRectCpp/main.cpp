//
//  main.cpp
//  MyRectCpp
//
//  Created by Ming Chow on 1/23/13.
//  Copyright (c) 2013 Ming Chow. All rights reserved.
//

#include <iostream>
#include "MyRect.h"

int main(int argc, const char * argv[])
{
    MyRect r1 = MyRect();
    r1.setWidth(4);
    r1.setLength(7);
    MyRect compareRect = MyRect(7, 4);
    compareRect.setId("*** A comparison Rect of length = 7 and width = 4 ***");
    if (r1 == compareRect) {
        cout << "*** Rectangle 1 and compareRect are the same shape" << endl;
    }
    else {
        cout << "*** Rectangle 1 and compareRect are different" << endl;
    }
    r1.setId("*** rect 1 inside main ***");
    cout << "The area of the rectangle 1 is " << r1.getArea() << endl;
    cout << "The permimeter of the rectangle 1 is " << r1.getPerimeter() << endl;
    cout << "The diagonal of the rectangle 1 is " << r1.getDiagonal() << endl;
    cout << "Is rectangle 1 a square? " << r1.isSquare() << endl;
    cout << "The area of the rectangle 1 is " << r1.getArea() << endl;
    cout << "The permimeter of the rectangle 1 is " << r1.getPerimeter() << endl;
    cout << "The diagonal of the rectangle 1 is " << r1.getDiagonal() << endl;
    cout << "Is rectangle 1 a square? " << r1.isSquare() << endl;
    return 0;
}

