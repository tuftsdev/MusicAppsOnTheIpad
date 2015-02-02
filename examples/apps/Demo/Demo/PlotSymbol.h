//
//  PlotSymbol.h
//  Demo
//
//  Created by Ron Lasser on 9/13/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlotSymbol : UIView

- (id)initWithFrame:(CGRect)frame;

//- (void) setLocation: (CGPoint) point;

//- (void) setSize: (CGSize) size;

@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) CGSize size;

@end
