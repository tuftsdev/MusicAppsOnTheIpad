//
//  ViewController.m
//  libpdDemo
//
//  Created by Connor Taylor on 2/11/15.
//  Copyright (c) 2015 Comp150. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Adds your class to the list of listeners held by the dispatcher
    // Source is the name of the receiver that you want to receive data from
    PdDispatcher *dispatcher = (PdDispatcher *)[PdBase delegate];
    [dispatcher addListener:self forSource:@"testOutput"];
    
    // Send a float to Pd.
    // More methods here: https://github.com/libpd/libpd/wiki/objc#sending-messages-to-pd
    [PdBase sendFloat:220.0 toReceiver:@"testInput"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiveBangFromSource:(NSString *)source
{
    if ([source isEqual: @"testOutput"]){
        NSLog(@"Received bang from Pd");
    }
}

@end
