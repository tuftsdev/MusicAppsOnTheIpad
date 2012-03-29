//
//  ViewController.m
//  Recorder
//
//  Created by Ming Chow on 3/29/12.
//  Taken from http://www.techotopia.com/index.php/Recording_Audio_on_an_iPhone_with_AVAudioRecorder_(iOS_4)
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize recordButton, playButton, stopButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Disable the play and stop buttons at start
    playButton.enabled = NO;
    stopButton.enabled = NO;
    
    // Set up location of sound files
    NSArray *dirPaths;
    NSString *docsDir;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Sounds are stored in the Core Audio Format (.caf).  See https://developer.apple.com/library/mac/#documentation/MusicAudio/Reference/CAFSpec/CAF_intro/CAF_intro.html
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.caf"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2], 
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0], 
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    // Set up the recorder for recording
    recorder = [[AVAudioRecorder alloc]initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    if (error) {
        NSLog(@"***** Error: %@", [error localizedDescription]);
        
    }
    else {
        [recorder prepareToRecord];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void) recordAudio
{
    if (!recorder.recording) {
        playButton.enabled = NO;
        stopButton.enabled = YES;
        [recorder record];
    }
}

-(void)stop
{
    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    if (recorder.recording) {
        [recorder stop];
    }
    else if (player.playing) {
        [player stop];
    }
}

-(void) playAudio
{
    if (!recorder.recording) {
        stopButton.enabled = YES;
        recordButton.enabled = NO;
        
        // Stop the player if it is playing audio
        if (player) {
            [player stop];
        }
        NSError *error;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url
                                                        error:&error];
        
        player.delegate = self;
        if (error) {
            NSLog(@"***** Error: %@", [error localizedDescription]);
        }
        else {
            [player play];
        }
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    recordButton.enabled = YES;
    stopButton.enabled = NO;
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"***** Decode Error: %@", [error localizedDescription]);
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    // Dummy...
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"***** Encode Error: %@", [error localizedDescription]);
}

@end
