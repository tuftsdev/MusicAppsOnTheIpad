//
//  ViewController.m
//  TipCalculator
//
//  Created by Ming Chow on 1/11/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize percentages, billDollarAmount, billCentsAmount, percentage, tipAmount;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    percentages = [[NSMutableArray alloc] initWithObjects:@"No tip", @"5%", @"10%", @"15%", @"20%", @"25%", @"30%", @"35%", @"40%", @"45%", @"50%", nil];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)backgroundTouched:(id)sender
{
    [billDollarAmount resignFirstResponder];
    [billCentsAmount resignFirstResponder];    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [percentages count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [percentages objectAtIndex:row];
}

-(IBAction)calculate:(id)sender
{
    NSInteger index = [percentage selectedRowInComponent:0];
    if (index == 0) {
        [tipAmount setText:@"Uh, no tip necessary!"];
    }
    else {
        NSString *dollars = billDollarAmount.text;
        NSString *cents = billCentsAmount.text;
        if (dollars == nil || cents == nil || [cents length] != 2 || [dollars length] < 1) {
            [tipAmount setText:@"Bad bill amount!"];
        }
        else {
            dollars = [dollars stringByAppendingString:@"."];
            dollars = [dollars stringByAppendingString:cents];
            double tip = [dollars doubleValue] * ([[percentages objectAtIndex:index] doubleValue] / 100.0);
            
            // The tip amount as string
            NSString *tipText = [[NSString alloc] initWithFormat:@"%f", tip];
            NSRange pos = [tipText rangeOfString:@"."];
            tipText = [tipText substringToIndex:pos.location + 3];
            
            // The new bill + tip amount as string
            NSString *newBillTotal = [[NSString alloc] initWithFormat:@"%f",[dollars doubleValue] + [tipText doubleValue]];
            pos = [newBillTotal rangeOfString:@"."];
            newBillTotal = [newBillTotal substringToIndex:pos.location + 3];

            // Put everything together
            NSString *resultText = [[NSString alloc]initWithFormat:@"Tip amount is $%@\nBill and tip total is $%@", tipText, newBillTotal];
            [tipAmount setText:resultText];
        }
    }
}

@end
