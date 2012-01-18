//
//  main.m
//  MyRect
//
//  Created by Ming Chow
//

#import <Foundation/Foundation.h>
#import "MyRect.h"

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        MyRect *r1 = [MyRect alloc];
        r1.length = 8;
        r1.width = 7;
        NSLog(@"The area of the rectangle 1 is %i", [r1 area]);
        NSLog(@"The permimeter of the rectangle 1 is %i", [r1 perimeter]);
        NSLog(@"The diagonal of the rectangle 1 is %f", [r1 diagonal]);
        if ([r1 isSquare]) {
            NSLog(@"Rectangle 1 is a square.");
        }
        else {
            NSLog(@"Rectangle 1 is not a square.");
        }
        NSLog(@"*****");
        MyRect *r2 = [[MyRect alloc] initWith: 8 and: 8];
        [r2 setRectId: @"A LUCKY SQUARE"];
        NSLog(@"Length of rectangle 2 is %i", [r2 length]);
        NSLog(@"Width of rectangle 2 is %i", [r2 width]);
        NSLog(@"The area of the rectangle 2 is %i", [r2 area]);
        NSLog(@"The permimeter of the rectangle 2 is %i", [r2 perimeter]);
        NSLog(@"The diagonal of the rectangle 2 is %f", [r2 diagonal]);
        if ([r2 isSquare]) {
            NSLog(@"Rectangle 2 is a square.");
        }
        else {
            NSLog(@"Rectangle 2 is not a square.");
        }
        NSLog(@"*****");
        if ([r1 isEqualTo: r2]) {
            NSLog(@"Rectangle 1 and rectangle 2 are equal, same length and width");
        }
        else {
            NSLog(@"Rectangle 1 and rectangle 2 are different");
        }
        NSLog(@"*****");
        MyRect *r3 = [r1 add: r2];
        [r3 setRectId:@"SUM OF TWO SQUARES"];
        NSLog(@"Length of rectangle 3 is %i", [r3 length]);
        NSLog(@"Width of rectangle 3 is %i", [r3 width]);
        NSLog(@"The area of the rectangle 3 is %i", [r3 area]);
        NSLog(@"The permimeter of the rectangle 3 is %i", [r3 perimeter]);
        NSLog(@"The diagonal of the rectangle 3 is %f", [r3 diagonal]);
        if ([r3 isSquare]) {
            NSLog(@"Rectangle 3 is a square.");
        }
        else {
            NSLog(@"Rectangle 3 is not a square.");
        }
        NSLog(@"*****");
    }
    return 0;
}
