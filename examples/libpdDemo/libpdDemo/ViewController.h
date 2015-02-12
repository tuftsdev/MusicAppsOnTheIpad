//
//  ViewController.h
//  libpdDemo
//
//  Created by Connor Taylor on 2/11/15.
//  Copyright (c) 2015 Comp150. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdDispatcher.h"

// To receive messages from Pd, a class must conform to the PdListener protocol
@interface ViewController : UIViewController <PdListener>

// One of the possible messages to receive from Pd.
// More found here: https://github.com/libpd/libpd/wiki/objc#receiving-messages-with-pddispatcher
- (void) receiveBangFromSource:(NSString *)source;

@end

