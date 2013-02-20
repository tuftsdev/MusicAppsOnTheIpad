//
//  DoodleCanvas.h
//  Doodle
//
//  Created by Ming Chow on 2/19/13.
//  Copyright (c) 2013 Ming Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoodleCanvas : UIView
{
    CGFloat lastX;
    CGFloat lastY;
}
@property (nonatomic, retain)UIPanGestureRecognizer *panGestureRecognizer;

-(void) handlePans:(UIPanGestureRecognizer *)sender;
@end
