//
//  AppDelegate.h
//  libpdDemo
//
//  Created by Connor Taylor on 2/11/15.
//  Copyright (c) 2015 Comp150. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdAudioController.h"
#import "PdDispatcher.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) PdAudioController *audioController;
@property void *patch;

@end

