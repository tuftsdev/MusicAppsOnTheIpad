//
//  ViewController.m
//  TouchDragPan
//
//  Created by Ming Chow on 1/18/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize panGestureRecognizer;

-(void) handlePans:(UIPanGestureRecognizer *)sender
{
    CGPoint pos = [sender locationInView:sender.view];
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"You are starting at %@", NSStringFromCGPoint(pos));
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"You moved to %@", NSStringFromCGPoint(pos));        
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"You stopped at %@", NSStringFromCGPoint(pos));
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize pan gesture recognizer
    panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePans:)];
    
    // The number of touches to trigger pan
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    
    // Add gesture recognizer to the view
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
