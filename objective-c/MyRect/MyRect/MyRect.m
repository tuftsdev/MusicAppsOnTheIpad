//
//  MyRect.m
//  MyRect
//
//  Created by Ming Chow
//

#import "MyRect.h"
#include "math.h"

@implementation MyRect

@synthesize length, width, x, y;
@synthesize rectId;

-(id) init
{
    NSLog(@"In constructor 1...");
    // self is pointer to the current object (similar to "this" in C++)
    self = [super init]; // Sends the superclass instance an init message and assigns the result to self
    if (self) { // Checks if the returned object pointer is valid before performing any initialization
        [self setLength:0];
        [self setWidth:0];
        [self setX:0];
        [self setY:0];
    }
    return self; // Returns the value of self to the caller
}

-(id) initWith: (int) l and: (int) w
{
    NSLog(@"In constructor 2...");
    self = [super init];
    if (self) {
        // BAH! http://stackoverflow.com/questions/2541716/objective-c-convention-to-prevent-local-declaration-hides-instance-variable-wa
        //[self setLength:length];
        if (l > 0 && w > 0) {
            [self setLength:l];
            [self setWidth:w];
        }
        else {
            NSLog(@"Length and width both have to be > 0");
            [self setLength:0];
            [self setWidth:0];
        }
        [self setX:0];
        [self setY:0];        
    }
    return self;
}

-(id) initWith: (int) l and: (int) w and: (int) someX and: (int) someY
{
    NSLog(@"In constructor 3...");
    self = [super init];
    if (self) {
        if (l > 0 && w > 0) {
            [self setLength:l];
            [self setWidth:w];
        }
        else {
            NSLog(@"Length and width both have to be > 0");
            [self setLength:0];
            [self setWidth:0];
        }
        if (x >=0 && y >= 0) {
            [self setX:someX];
            [self setY:someY];
        }
        else {
            [self setX:0];
            [self setY:0];
        }
    }
    return self;
}

-(int) area
{
    return length * width;
}

-(int) perimeter
{
    return 2 * (length + width);
}

-(double) diagonal
{
    return sqrt(pow(length,2) + pow(width, 2));
}

-(BOOL) isSquare
{
    return length == width;
}

-(BOOL) isEqualTo: (MyRect *)r
{
    return ((self.length == r.length && self.width == r.width) || (self.length == r.width && self.width == r.length));
}

-(MyRect *) add: (MyRect *)r
{
    MyRect *newRect = [MyRect alloc];
    newRect.length = self.length + r.length;
    newRect.width = self.width + r.width;
    newRect.x = self.x;
    newRect.y = self.y;
    return newRect;
}

-(void) dealloc
{
    if (rectId) {
        NSLog(@"Good bye %@!", rectId);        
    }
    else {
        NSLog(@"Good bye unknown rectangle!");
    }
    //[super dealloc];
}

@end
