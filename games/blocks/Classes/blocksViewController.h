//
//  blocksViewController.h
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright University of Chicago 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CADisplayLink.h>
#import "Ball.h"
#import "blockyView.h"

@interface blocksViewController : UIViewController {
	NSTimer *theTimer;

	
}
-(void)logic:(NSTimer *)timer;

@end

