//
//  ViewController.h
//  TapTap
//
//  Created by Ming Chow on 1/17/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
@private
    int numTaps;
}
@property (nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;

@end
