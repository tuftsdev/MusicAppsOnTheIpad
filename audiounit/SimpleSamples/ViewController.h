//
//  ViewController.h
//  SimpleSamples
//
//  Created by Garth Griffin on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioSession.h>
#import "AudioManager.h"
#import "AudioQueueManager.h"

static const int outputFrameSize = 1024;
@interface ViewController : UIViewController {
    NSTimer* theTimer;
    int testcount;
    AudioManager* audioManager;
    AudioQueueManager* audioQueueManager;
    BOOL noisy;
}

@property(nonatomic, retain) IBOutlet UILabel* theLabel;

@end
