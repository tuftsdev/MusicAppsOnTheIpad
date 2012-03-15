//
//  ViewController.m
//  AccelTest
//
//  Created by Ming Chow on 3/15/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize motionManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    // Initialize and set up accelerometer
    self.motionManager = [[CMMotionManager alloc] init];
    if ([self.motionManager isAccelerometerAvailable]) {
        [self.motionManager setAccelerometerUpdateInterval:1.0f/1.0f]; // 1 update per second
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                // Callback function for accelerometer updates
                NSLog(@"ACCELEROMETER: x = %.04f, y = %.04f, z = %.04f",
                      accelerometerData.acceleration.x,
                      accelerometerData.acceleration.y,
                      accelerometerData.acceleration.z);
        }];
    }
    else {
        NSLog(@"Accelerometer is not available");
    }
    
    // Initialize and set up gyroscope
    if ([self.motionManager isGyroAvailable]) {
        [self.motionManager setGyroUpdateInterval:1.0f/20.0f]; // 20 updates per second
        [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData, NSError *error) {
                // Callback function for gyroscope updates
                NSLog(@"GYRO ROTATION: X = %.04f, Y = %.04f, Z = %.04f",
                      gyroData.rotationRate.x,
                      gyroData.rotationRate.y,
                      gyroData.rotationRate.z);
        }];
    }
    else {
        NSLog(@"Gyroscope is not available");
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.motionManager = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
