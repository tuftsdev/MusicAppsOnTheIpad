//
//  PlotSymbol.m
//  Demo
//
//  Created by Ron Lasser on 9/13/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import "PlotSymbol.h"

@interface PlotSymbol()



@end

@implementation PlotSymbol



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.location = CGPointMake(frame.origin.x, frame.origin.y);
        self.size = CGSizeMake(frame.size.width, frame.size.height);
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect r = CGRectMake(self.location.x, self.location.y, self.size.width, self.size.height);

    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:r];
    
    
    //set color
    [[UIColor whiteColor] setStroke];
    [[UIColor greenColor] setFill];
    [aPath setLineWidth:2];
    
    // draw shape
   
    
    [aPath stroke];
    [aPath fill];
}


@end
