//
//  ViewController.h
//  TweetsTable
//
//  Created by Ming Chow on 3/13/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>
//                                           ^^^^^^^^^^^^^^^^^^^^^^^
//                                           protocol
{
    NSMutableArray *tweets;
}

@property (strong, nonatomic) UITableView *tweetsTable;

@end
