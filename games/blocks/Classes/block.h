//
//  block.h
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <math.h>
#import "Ball.h"


@interface block : NSObject {
	float x;
	float y;
	short life;
	

}


@property float x;
@property float y;
@property short life;

- (id)initWithX:(float)firstX withY:(float)firstY withLife:(short)firstLife;
- (void)doCollision:(Ball*)collider;
- (void)printCoordinates;
- (void)drawMe:(CGContextRef)steve;



@end
