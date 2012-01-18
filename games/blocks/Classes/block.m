//
//  block.m
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import "block.h"


@implementation block
@synthesize x, y;
@synthesize life;

- (id)initWithX:(float)firstX withY:(float)firstY withLife:(short)firstLife{
	self = [super init];
	x=firstX;
	y=firstY;
	life=firstLife;
	return self;
}

- (id) init{
	self = [super init];
	x = 0;
	y = 0;
	life = 0;
	return self;
}

- (void) doCollision:(Ball*)collider{
	//don't check if we're below all the blocks or if the ball has already collided with something this tic
	if ([collider y]>120&&![collider collided]) {
		//if we're in line with the block up/down-wise
		if ([collider x]-x<40 && [collider x]-x>-40) {
			//check for a vertical collision
			if ([collider y]-y<25&&[collider y]-y>-25) {
				[collider setDy:-[collider dy]];
				[collider accommodateDxDy];
				life = life-1;
				[collider setCollided:YES];
			}
		}
		//if we're in line with the block left/right-wise
		else if ([collider y]-y<15&&[collider y]-y>-15) {
			//check for a horizontal collision
			if ([collider x]-x<50&&[collider x]-x>-50) {
				[collider setDx:-collider.dx];
				[collider accommodateDxDy];
				life = life-1;
				[collider setCollided:YES];
			}
		}
		else if ([collider y]-y<25&&[collider y]-y>-25&&[collider x]-x<50&&[collider x]-x>-50) {
			[collider setDx:-collider.dx];
			[collider setDy:-collider.dy];
			[collider accommodateDxDy];
			life=life-1;
			[collider setCollided:YES];
		}	
	}
		
}

-(void) printCoordinates{
	NSLog(@"Hi I'm at %d, %d", x, y);
}
-(void) drawMe:(CGContextRef)steve{
	CGContextBeginPath(steve);
	CGContextSetRGBFillColor(steve, 0, 1, 0, (CGFloat)life/3);
	CGContextAddRect(steve, CGRectMake((CGFloat)x-40, (CGFloat)y-15, 80, 30));
	CGContextClosePath(steve);
	CGContextDrawPath(steve, kCGPathFill);
	
}
@end
