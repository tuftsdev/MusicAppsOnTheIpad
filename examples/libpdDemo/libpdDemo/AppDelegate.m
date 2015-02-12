//
//  AppDelegate.m
//  libpdDemo
//
//  Created by Connor Taylor on 2/11/15.
//  Copyright (c) 2015 Comp150. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialize the audio controller that handles Core Audio integration
    _audioController = [PdAudioController new];
    if ([_audioController configureAmbientWithSampleRate:44100
                                          numberChannels:2
                                           mixingEnabled:YES] != PdAudioOK){
        NSLog(@"failed to initialize audio controller");
    }
    
    // Configure the dispatcher to listen for messages from Pure Data. PdBase is initialized by libpd
    PdDispatcher *dispatcher = [PdDispatcher new];
    [PdBase setDelegate:dispatcher];
    
    // Open a patch called demo.pd
    _patch = [PdBase openFile:@"demo.pd"
                              path:[[NSBundle mainBundle] resourcePath]];
    
    // Get the unique $0 for a patch that you open
    int dollarZero = [PdBase dollarZeroForFile:_patch];
    
    if (!_patch){
        NSLog(@"Couldn't open the patch");
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Turn off audio controller when the application enters the background
    _audioController.active = NO;
    [PdBase closeFile:_patch];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Turn on the audio controller.  Note that this is also called when your application loads,
    // so putting this in didFinishLaunchingWithOptions is redundant
    _audioController.active = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
