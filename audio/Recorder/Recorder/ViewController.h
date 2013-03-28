//
//  ViewController.h
//  Recorder
//
//  Created by Ming Chow on 3/29/12.
//  Taken from http://www.techotopia.com/index.php/Recording_Audio_on_an_iPhone_with_AVAudioRecorder_(iOS_4)
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
-(IBAction) recordAudio;
-(IBAction) playAudio;
-(IBAction) stop;

@end
