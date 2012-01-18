//
//  paddle.h
//  blocks
//
//  Created by Benjamin Horn on 8/16/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ball.h"

@interface paddle : NSObject {
	float x;
	float y;

}

@property float x;
@property float y;

-(id)initWithX:(float)firstX withY:(float)firstY;
-(void)doCollision:(Ball*)collider;

@end
