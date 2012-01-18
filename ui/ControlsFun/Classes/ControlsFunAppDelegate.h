//
//  ControlsFunAppDelegate.h
//  ControlsFun
//
//  Created by Ming Chow on 12/28/09.
//  Copyright Tufts University 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ControlsFunViewController;

@interface ControlsFunAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ControlsFunViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ControlsFunViewController *viewController;

@end
