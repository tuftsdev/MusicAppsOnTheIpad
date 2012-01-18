//
//  ball.h
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ball : NSObject {
	float x;
	float y;
	float speed;
	float angle;
	float mycos;
	float mysin;
	float dx;
	float dy;
	BOOL collided;

}

@property float x, y, dx, dy;
@property float angle, mycos, mysin;
@property float speed;
@property BOOL collided;

- (id)initwithX:(float)firstX withY:(float)firstY withSpeed:(float)firstSpeed withAngle:(float)firstAngle;

- (id)initwithX:(float)firstX withY:(float)firstY withDx:(float)dx withDy:(float)dy;

- (void)accommodateDxDy;

- (void)accommodateSpeedAngle;

- (void)updatePlace;

- (void)deUpdatePlace;


@end
