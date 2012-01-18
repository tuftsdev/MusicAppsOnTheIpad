//
//  paddle.m
//  blocks
//
//  Created by Benjamin Horn on 8/16/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import "paddle.h"
#define PI 3.14159265


@implementation paddle
@synthesize x;
@synthesize y;

-(id)initWithX:(float)firstX withY:(float)firstY{
	self = [super init];
	x = firstX;
	y = firstY;
	return self;

}
	
-(void)doCollision:(Ball*)collider{
	//unless the ball's below 50 and on its way down, don't bother
	if (collider.y<50 && collider.dy<0 && collider.y>10) {
		if (collider.x-x<60 && collider.x-x>-60) {
			float originalSpeed=collider.speed;
			collider.dy=-collider.dy;
			[collider accommodateDxDy];
			//now apply our distortion effect
			float padPoint=(float)collider.x-(float)x;
			if (padPoint>=0) {
				collider.angle=collider.angle-collider.angle*(padPoint*padPoint)/(61*61);
			}
			else {
				collider.angle=collider.angle-(collider.angle-PI)*(padPoint*padPoint)/(61*61);
			}
			if (collider.dy<=0) {
				collider.dy=1;
				[collider accommodateDxDy];
			}
			collider.speed=originalSpeed;
			[collider accommodateSpeedAngle];

			
		}
	}

}	
@end
