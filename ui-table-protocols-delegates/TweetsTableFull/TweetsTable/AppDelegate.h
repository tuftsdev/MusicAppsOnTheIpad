//
//  AppDelegate.h
//  TweetsTable
//
//  Created by Ming Chow on 3/13/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

// See http://stackoverflow.com/questions/6596059/pushviewcontroller-not-working
@property (strong, nonatomic) UINavigationController *navigationController;

@end
