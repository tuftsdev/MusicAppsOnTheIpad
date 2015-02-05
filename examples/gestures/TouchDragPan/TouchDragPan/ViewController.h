//
//  ViewController.h
//  TouchDragPan
//
//  Created by Ming Chow on 1/18/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;

-(void) handlePans:(UIPanGestureRecognizer *)sender;

@end
