//
//  ViewController.m
//  SimpleApp
//
//  Created by Ming Chow on 1/31/13.
//  Copyright (c) 2013 Ming Chow. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize feedbackLabel, volumeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonTriggered:(id)sender
{
    UIButton *theButton = (UIButton *)sender;
    NSLog(@"You pressed the button %@", theButton.currentTitle);
    if ([theButton.currentTitle isEqualToString:@"Hit Me One"]) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"Button Pressed"
                                                      message:@"You sunk my battleship"
                                                     delegate:self
                                            cancelButtonTitle:@"Nice!"
                                            otherButtonTitles:nil,
                             nil];
        [view show];
    }
    else if ([theButton.currentTitle isEqualToString:@"Hit Me One More Time"]) {
        [feedbackLabel setText:@"Britney, is that you?"];
    }
    else if ([theButton.currentTitle isEqualToString:@"One Last Shot"]) {
        [feedbackLabel setText:@"Finished playing."];
    }
}

-(IBAction)sliderChanged:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    NSString *volumeText = [NSString stringWithFormat:@"%f", slider.value];
    [volumeLabel setText:volumeText];
}

@end
