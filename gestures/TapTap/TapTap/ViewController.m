//
//  ViewController.m
//  TapTap
//
//  Created by Ming Chow on 1/17/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize tapGestureRecognizer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    numTaps = 0;
    self.view.backgroundColor = [UIColor cyanColor];
    
    // Initialize tap gesture recognizer
    tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTaps:)]; // Absolutely need ":" after handleTaps
    
    // The number of fingers that must be on the screen
    tapGestureRecognizer.numberOfTouchesRequired = 3;
    
    // The number of taps in order for gesture to be recognized
    tapGestureRecognizer.numberOfTapsRequired = 2;
    
    // Add gesture recognizer to the view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    tapGestureRecognizer = nil;
}

-(void) handleTaps:(UITapGestureRecognizer *)sender
{
    NSInteger fingerCounter;
    for (fingerCounter = 0; fingerCounter < sender.numberOfTouchesRequired; fingerCounter++) {
        numTaps++;
        CGPoint pos = [sender locationOfTouch:fingerCounter inView:sender.view];
        NSLog(@"Tap #%i finger #%lu at %@", numTaps, (unsigned long)fingerCounter + 1, NSStringFromCGPoint(pos));
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
