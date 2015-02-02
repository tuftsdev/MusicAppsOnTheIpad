//
//  Graph.h
//  Demo
//
//  Created by Ron Lasser on 9/13/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Graph : UIView

@property (nonatomic, strong) NSMutableArray *graphXData;
@property (nonatomic, strong) NSMutableArray *graphYData;

- (void) printArray;

@end
