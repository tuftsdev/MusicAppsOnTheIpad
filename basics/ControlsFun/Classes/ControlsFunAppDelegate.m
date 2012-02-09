//
//  ControlsFunAppDelegate.m
//  ControlsFun
//
//  Created by Ming Chow on 12/28/09.
//  Copyright Tufts University 2009. All rights reserved.
//

#import "ControlsFunAppDelegate.h"
#import "ControlsFunViewController.h"

@implementation ControlsFunAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // Override point for customization after app launch
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc
{
    [viewController release];
    [window release];
    [super dealloc];
}

@end
