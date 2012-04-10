//
//  ViewController.h
//  PopupView
//
//  Created by Ming Chow on 4/10/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnotherViewController.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) AnotherViewController *ac;
@property (strong, nonatomic) UIPopoverController *pc;

-(IBAction)onClick:(id)sender;

@end
