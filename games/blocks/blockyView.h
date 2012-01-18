//
//  blockyView.h
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright 2010 University of Chicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "block.h"
#import "paddle.h"

@interface blockyView : UIView {
	Ball *theball;
	NSMutableArray *ourblocks;
	paddle *thepaddle;
	BOOL balltethered;
	BOOL paused;
	BOOL won;
	BOOL lost;
	BOOL frameTickMode;
	short lives;
}
@property BOOL balltethered;
@property BOOL paused;
@property NSMutableArray *ourblocks;
@property Ball *theball;
@property paddle *thepaddle;
@property short lives;
@property BOOL won;
@property BOOL lost;
@property BOOL frameTickMode;


- (void)physics:(NSTimer *)timer;
- (BOOL)win;
- (void)resetGame;
- (void)takeSingleTap;
- (void)takeDoubleTap;
- (void)takeTripleTap;

@end
