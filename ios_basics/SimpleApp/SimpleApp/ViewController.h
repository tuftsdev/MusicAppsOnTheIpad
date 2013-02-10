//
//  ViewController.h
//  SimpleApp
//
//  Created by Ming Chow on 1/31/13.
//  Copyright (c) 2013 Ming Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *feedbackLabel;
@property (nonatomic, strong) IBOutlet UILabel *volumeLabel;

// IBOutlet is needed to associate properties in your application with components in Interface Builder (IB)
-(IBAction)buttonTriggered:(id)sender;
-(IBAction)sliderChanged:(id)sender;

@end
