//
//  ViewController.m
//  PopupView
//
//  Created by Ming Chow on 4/10/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize button, pc, ac;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(IBAction)onClick:(id)sender
{
    if (ac == nil && pc == nil) {
        ac = [[AnotherViewController alloc] initWithNibName:@"AnotherViewController" bundle:nil];
        pc = [[UIPopoverController alloc] initWithContentViewController:ac];
    }
    if ([pc isPopoverVisible]) {
        [pc dismissPopoverAnimated:YES];
    }
    else {
        [pc presentPopoverFromRect:button.bounds inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
@end
