//
//  MyRect.h
//  MyRect
//
//  Created by Ming Chow
//

#import <Foundation/Foundation.h>

@interface MyRect : NSObject

@property int length, width, x, y;
@property (retain) NSString *rectId;

-(id) init;
-(id) initWith: (int) length and: (int) width;
-(id) initWith: (int) length and: (int) width and: (int) x and: (int) y;
-(int) area;
-(int) perimeter;
-(double) diagonal;
-(BOOL) isSquare;
// No, you cannot overload operator in Objective-C
// See http://stackoverflow.com/questions/3613980/can-i-overload-an-operator-in-objective-c
-(BOOL) isEqualTo: (MyRect *)r;
-(MyRect *) add: (MyRect *)r;
-(void) dealloc;

@end
