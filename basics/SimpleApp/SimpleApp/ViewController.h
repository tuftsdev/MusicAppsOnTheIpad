//
//  ViewController.h
//  SimpleApp
//
//  Created by Ming Chow on 2/7/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (strong) AVAudioPlayer *player;
@property (nonatomic, strong) IBOutlet UILabel *feedbackLabel;
@property (nonatomic, strong) IBOutlet UILabel *volumeLabel;

// IBOutlet is needed to associate properties in your application with components in Interface Builder (IB)
-(IBAction)buttonTriggered:(id)sender;
-(IBAction)sliderChanged:(id)sender;

@end
