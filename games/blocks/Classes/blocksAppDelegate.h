//
//  blocksAppDelegate.h
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright University of Chicago 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class blocksViewController;

@interface blocksAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    blocksViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet blocksViewController *viewController;

@end

