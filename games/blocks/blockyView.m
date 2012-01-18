//
//  blockyView.m
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import "blockyView.h"
#define PI 3.14159265


@implementation blockyView
@synthesize theball;
@synthesize ourblocks;
@synthesize thepaddle;
@synthesize balltethered;
@synthesize paused;
@synthesize lives;
@synthesize won;
@synthesize lost;
@synthesize frameTickMode;


-(id)initWithCoder:(NSCoder *) coder {
	if (self = [super initWithCoder:coder]) {
		theball = [[Ball alloc] initwithX:50 withY: 50 withDx:0 withDy:0];
		thepaddle = [[paddle alloc] initWithX:100 withY:30];
		ourblocks = [[NSMutableArray alloc] initWithCapacity:20];
		for (int i = 0; i<=19; i++) {
			block *newBlock = [[block alloc] initWithX:56+91*(i%5) withY:160+40*((i-(i%5))/5) withLife:3];
			[ourblocks addObject:newBlock];
			[newBlock release];
			
			
		}
		balltethered = YES;
		paused = NO;
		lives=3;
		won=NO;
		lost=NO;
		frameTickMode=NO;
	}
	return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	CGAffineTransform t0 = CGContextGetCTM(context);
	t0 = CGAffineTransformInvert(t0);
	t0 = CGAffineTransformTranslate(t0, 0, 480);
	t0 = CGAffineTransformRotate(t0, -PI/2);
	CGContextConcatCTM(context,t0);
	
	CGContextBeginPath(context);
	CGContextSetRGBFillColor(context, 1, 0, 0, 1);
	CGContextAddEllipseInRect(context, CGRectMake(theball.x-10, theball.y-10, 20, 20));
	CGContextAddRect(context, CGRectMake(thepaddle.x-50, thepaddle.y-10, 100, 20));
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFill);
	
	//NSEnumerator *enumerator = [ourblocks objectEnumerator];
	//id thingie;
	//while (thingie = [enumerator nextObject]) {
	//	CGContextAddRect(context, CGRectMake([thingie x]-40, [thingie y]-15, 80, 30));
	//}
	for (NSUInteger i=0; i<=19; i++) {
		id object;
		object=[ourblocks objectAtIndex:i];
		if ([object life]>0) {
			[object drawMe:context];
		}
		
		
	}
	
    
	
	
}

- (void)physics:(NSTimer *)timer{
	if (!paused){
		if (frameTickMode) {
			paused=YES;
		}
		theball.collided=NO;
		[thepaddle doCollision:theball];
		for (NSUInteger i=0; i<=19; i++) {
			if ([[ourblocks objectAtIndex:i] life]>0) {
				[[ourblocks objectAtIndex:i] doCollision:theball];
			}
			
		}
		[theball updatePlace];
		if (balltethered) {
			theball.x=thepaddle.x;
		}
		else {
			if ((theball.x<10&&theball.dx<0) || (theball.x>470&&theball.dx>0)) {
				theball.dx=-theball.dx;
				[theball accommodateDxDy];
			}
			if (theball.y>310&&theball.y>0) {
				theball.dy=-theball.dy;
				[theball accommodateDxDy];
			}
			if (theball.y<-10) {
				theball.y=50;
				theball.x=thepaddle.x;
				balltethered=YES;
				lives=lives-1;
				theball.dx=0;
				theball.dy=0;
				if (lives<1) {
					lost=YES;
					paused=YES;
				}
			}
		}
		if ([self win]) {
			won=YES;
			paused=YES;
		}
		
		
		[self setNeedsDisplay];
	}	
}
- (void)resetGame{
	for (NSUInteger i = 0; i<=19; i++) {
		[[ourblocks objectAtIndex:i] setLife:3];
	}
	theball.y=50;
	balltethered=YES;
	lives=3;
	theball.dx=0;
	theball.dy=0;
}	
- (void)takeSingleTap {
	if (won || lost) {
		won=NO;
		lost=NO;
		paused=NO;
		[self resetGame];
	}
}	
- (void)takeDoubleTap{
	if (paused&&!won&&!lost) {
		paused=NO;
	} else if (balltethered) {
		balltethered=NO;
		theball.dx=0;
		theball.dy=7;
		[theball accommodateDxDy];
	}
}
- (void)takeTripleTap{
/*	if (frameTickMode) {
		frameTickMode=NO;
	}else {
		frameTickMode=YES;
	}*/
	[self resetGame];
}
- (BOOL)win{
	BOOL check=YES;
	id object;
	for (NSUInteger i=0; i<=19; i++) {
		object=[ourblocks objectAtIndex:i];
		if ([object life]>0) {
			check=NO;
			break;
		}
	}
	return check;
}	
- (void)dealloc {
	[theball release];
	[ourblocks release];
	[thepaddle release];
    [super dealloc];
}


@end
