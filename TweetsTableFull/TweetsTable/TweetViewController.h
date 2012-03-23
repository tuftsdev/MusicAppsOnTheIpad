//
//  TweetViewController.h
//  TweetsTable
//
//  Created by Ming Chow on 3/13/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewController : UIViewController

// The dirty hack for a multi-line label: http://stackoverflow.com/questions/990221/multiple-lines-of-text-in-uilabel
@property (nonatomic, retain) IBOutlet UILabel *tweetLabel;
@property (nonatomic, retain) NSString *theTweet;

@end
