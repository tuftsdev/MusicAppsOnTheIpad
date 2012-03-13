//
//  DrawingTestUIView.m
//  DrawingTest
//
//  Created by Ming Chow on 1/16/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//  Largely taken from my AndroidDrawingTest project
//

#import "DrawingTestUIView.h"

@implementation DrawingTestUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Get current graphics context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // Set line width
    CGContextSetLineWidth(currentContext, 5.0f);
 
    // Draw a blue filled circle
    CGContextSetFillColorWithColor(currentContext, [UIColor blueColor].CGColor);
    CGRect circleRect1 = CGRectMake(100.0f, 100.0f, 50.0f, 50.0f);
    CGContextFillEllipseInRect(currentContext, circleRect1);
    CGContextStrokePath(currentContext);
    
    // Draw a green stroked circle
    CGContextSetStrokeColorWithColor(currentContext, [UIColor greenColor].CGColor);
    CGRect circleRect2 = CGRectMake(200.0f, 50.0f, 75.0f, 75.0f);
    CGContextStrokeEllipseInRect(currentContext, circleRect2);
    CGContextStrokePath(currentContext);
    
    // Draw red text
    CGContextSetAllowsAntialiasing(currentContext, YES); // Self-explanatory
    CGContextSetShouldAntialias(currentContext, YES); // Ditto
    [[UIColor redColor] set];
    UIFont *theFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0f]; // load the font
    NSString *theText = @"Hey, this works!";
    [theText drawAtPoint:CGPointMake(20.0f, 200.0f) withFont:theFont];
    
    // Draw an image
    UIImage *img = [UIImage imageNamed:@"krusty.png"];
    if (img != nil) {
        [img drawAtPoint:CGPointMake(25.0f, 250.0f)];
        //[img drawInRect:CGRectMake(25.0f, 250.0f, 10.0f, 20.0f)];
    }
    else {
        NSString *errorStr = @"Could not find image to render";
        [errorStr drawAtPoint:CGPointMake(25.0f, 250.0f) withFont:theFont];
    }
}

@end
