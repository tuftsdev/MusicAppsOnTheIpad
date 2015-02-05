//
//  ViewController.h
//  PostMessageApp
//
//  Created by Ming Chow on 1/10/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *feedback;
@property (nonatomic, retain) IBOutlet UITextField *content;

-(IBAction)buttonPressed:(id)sender;

@end
