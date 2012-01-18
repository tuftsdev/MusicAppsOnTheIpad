//
//  ball.m
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import "Ball.h"
#import <math.h>




@implementation Ball
@synthesize x, y, dx, dy;
@synthesize angle, mycos, mysin, speed;
@synthesize collided;
- (id)initwithX:(float)firstX withY:(float)firstY withSpeed:(float)firstSpeed withAngle:(float)firstAngle{
	x = firstX;
	y = firstY;
	speed = firstSpeed;
	angle = firstAngle;
	[self accommodateSpeedAngle];
	collided = NO;
	return self;
}
- (id)initwithX:(float)firstX withY:(float)firstY withDx:(float)firstDx withDy:(float)firstDy{
	
	x = firstX;
	y = firstY;
	dx = firstDx;
	dy = firstDy;
	[self accommodateDxDy];
	collided = NO;
	return self;

}
- (void)accommodateDxDy{
	speed = sqrt((float)dx*(float)dx+(float)dy*(float)dy);
	mycos = (float)dx/speed;
	mysin = (float)dy/speed;
	angle = acos(mycos);
}
- (void)accommodateSpeedAngle{
	mycos = cos(angle);
	mysin = sin(angle);
	dx = speed*mycos;
	dy = speed*mysin;
	
}
- (void)updatePlace{
	x=x+dx;
	y=y+dy;
}
- (void)deUpdatePlace{
	x=x-dx;
	y=y-dy;
}
@end
