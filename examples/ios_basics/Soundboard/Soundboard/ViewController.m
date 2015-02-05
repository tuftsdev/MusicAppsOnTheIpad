//
//  ViewController.m
//  Soundboard
//
//  Created by Ming Chow on 2/5/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) buttonPressed {
    self.theLabel.text = @"You pressed the button!";
}

@end
