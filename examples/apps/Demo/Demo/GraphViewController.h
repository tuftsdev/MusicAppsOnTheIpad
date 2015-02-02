//
//  GraphViewController.h
//  Demo
//
//  Created by Ron Lasser on 9/12/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController

@property (nonatomic, assign) BOOL doNotShowGraph;
@property (strong, nonatomic) IBOutlet UILabel *controllerLabel;
@property (strong, nonatomic) NSString *controllerLabelText;


@end
