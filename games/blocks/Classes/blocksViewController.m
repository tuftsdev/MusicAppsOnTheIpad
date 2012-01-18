//
//  blocksViewController.m
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright University of Chicago 2010. All rights reserved.
//

#import "blocksViewController.h"

@implementation blocksViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	theTimer = [NSTimer	scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(logic:) userInfo:nil repeats:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	[[[self view] thepaddle] setX:[touch locationInView:touch.view].y];
	if ([touch tapCount]==1) {
		[[self view] takeSingleTap];
	}
    else if ([touch tapCount]==2) {
		[[self view] takeDoubleTap];
	}
    else if ([touch tapCount]==3) {
		[[self view] takeTripleTap];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	[[[self view] thepaddle] setX:[touch locationInView:touch.view].y];
}	

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
}

- (void)logic:(NSTimer *)timer
{
	[[self view] physics:timer];
}

- (void)dealloc
{
    [super dealloc];
}

@end
