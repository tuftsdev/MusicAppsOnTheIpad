//
//  DoodleCanvas.m
//  Doodle
//
//  Created by Ming Chow on 2/19/13.
//  Copyright (c) 2013 Ming Chow. All rights reserved.
//

#import "DoodleCanvas.h"

@implementation DoodleCanvas

@synthesize panGestureRecognizer;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialize pan gesture recognizer
        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePans:)];
        
        // The number of touches to trigger pan
        panGestureRecognizer.minimumNumberOfTouches = 1;
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        // Add gesture recognizer to the view
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

-(void) handlePans:(UIPanGestureRecognizer *)sender
{
    CGPoint pos = [sender locationInView:sender.view];
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"You are starting at %@", NSStringFromCGPoint(pos));
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        lastX = pos.x;
        lastY = pos.y;
        [self setNeedsDisplay]; // redrawing
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"You stopped at %@", NSStringFromCGPoint(pos));
    }
}

- (void)drawRect:(CGRect)rect
{
    // Get current graphics context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    // Draw a blue filled circle
    CGContextSetFillColorWithColor(currentContext, [UIColor blueColor].CGColor);
    CGRect circleRect1 = CGRectMake(lastX, lastY, 50.0f, 50.0f);
    CGContextFillEllipseInRect(currentContext, circleRect1);
    CGContextStrokePath(currentContext);
}

@end
