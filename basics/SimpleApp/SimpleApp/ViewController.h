//
//  ViewController.h
//  SimpleApp
//
//  Created by Ming Chow on 2/7/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// IBOutlet is needed to associate properties in your application with components in Interface Builder (IB)
-(IBAction)buttonTriggered:(id)sender;
-(IBAction)sliderChanged;

@end
