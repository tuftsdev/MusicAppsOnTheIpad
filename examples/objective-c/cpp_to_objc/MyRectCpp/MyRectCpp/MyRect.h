//
//  MyRect.h (the interface)
//
//  Created by Ming Chow on 9/21/11.
//

#ifndef classes_MyRect_h
#define classes_MyRect_h

#include <iostream>

using namespace std;

/*
 * Class invariant: length >= 0, width >= 0
 */

class MyRect
{
private:
    // Identifying information
    string id;
    
    // Dimensions
    int length;
    int width;
    
    // Position
    int x;
    int y;
    
public:
    // Constructors: three varieties
    MyRect();
    MyRect(int length, int width);
    MyRect(int length, int width, int x, int y);

    // Description: A friend function to "double" a rectangle
    friend MyRect doubleRect(MyRect r2);

    // Description: Sum the length and width of two rectangles; x, y are the same as original rect
    // Precondition: r2 is legitimate
    // Postcondition: returns a new Rect that contains the sum of the lengths and widths of two rects
    MyRect operator+ (MyRect r2);

    // Description: Checks if both rectangles have same length and width (or r1.length = r2.width and r1.width = r2.length; i.e., r2 is inverted), ignoring x and y
    // Precondition: r2 is legitimate
    // Postcondition: returns true if both rectangles share the same dimensions (and area)
    bool operator== (MyRect r2);

    // Precondition: length and width are legitimate
    // Postcondition: result >= 0
    int getArea();

    // Precondition: length and width are legitimate
    // Postcondition: result >= 0
    int getPerimeter();
    
    // Precondition: length and width are legitimate
    // Postcondition: result >= 0
    double getDiagonal();
    
    // Precondition: length and width are legitimate
    // Postcondition: if length = width, return true, else fase
    bool isSquare();
    
    // Precondition: x is defined
    // Postcondition: returns x
    
    int getX();
    
    // Precondition: y is defined
    // Postcondition: returns y
    int getY();
    
    // Precondition: x is defined
    void setX(int newX);
    
    // Precondition: y is defined
    void setY(int newY);
    
    // Precondition: length is defined; length >= 0
    // Postcondition: returns length
    int getLength();
    
    // Precondition: width is defined; width >= 0
    // Postcondition: returns width
    int getWidth();
    
    // Precondition: length is defined
    // Postcondition: length >= 0
    void setLength (int newLength);
    
    // Precondition: width is defined
    // Postcondition: width >= 0
    void setWidth (int newWidth);
    
    // Precondition: id is defined
    // Postcondition: returns id
    string getId();
    
    // Precondition: id is defined
    void setId (string id);
    
    ~MyRect();
};

#endif
