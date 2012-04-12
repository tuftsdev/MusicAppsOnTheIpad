//
//  ViewController.m
//  SimpleSamples
//
//  Created by Garth Griffin on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize theLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) renderOldstyle {
    testcount++;
    //[theLabel setText:[NSString stringWithFormat:@"val: %d", testcount]];
    [audioManager getAudioFrame];
    double sum = 0;
    int len = 60;
    for (int i=0; i<len; i++) {
		sum += (audioManager.spectrumData[i]);
	}
    sum /= len;
    //[theLabel setText:[NSString stringWithFormat:@"avg: %f", sum]];
	[theLabel setText:[NSString stringWithFormat:@"val: %f", audioManager.spectrumData[10]]];
    //[theLabel setText:[NSString stringWithFormat:@"val: %f", audioManager.audioData[10]]];
}

- (void) renderInput:(id)sender {
    //NSLog(@"render input");
    testcount++;
    AudioQueueBufferRef currentBuffer = audioQueueManager.currentBuffer;
    //NSLog(@"buffer bytes: %lu", currentBuffer->mAudioDataByteSize);
    //[theLabel setText:[NSString stringWithFormat:@"bytes: %d", currentBuffer->mAudioDataByteSize]];
    SInt16* audioData = currentBuffer->mAudioData;
    //int numSamples = currentBuffer->mAudioDataByteSize/sizeof(SInt16);
    long absSum = 0;
    for (int i=0; i<audioQueueManager.bufferLen; i++) absSum += abs(audioData[i]);
    float absAvg = ((float)absSum/audioQueueManager.bufferLen)/32768;
    //[theLabel setText:[NSString stringWithFormat:@"value at 1000: %d", audioData[1000]]];
    [theLabel setText:[NSString stringWithFormat:@"average: %1.2f", absAvg]];
    

}

- (void) renderOutput:(id)sender {
    //NSLog(@"render output");
    testcount++;
    [theLabel setText:[NSString stringWithFormat:@"count: %d", testcount]];
    AudioQueueBufferRef currentBuffer = audioQueueManager.currentBuffer;
    currentBuffer->mAudioDataByteSize = outputFrameSize*sizeof(SInt16);
    SInt16* audioData = (SInt16*)currentBuffer->mAudioData;
    for (int i=0; i<outputFrameSize; i++) {
        audioData[i] = (SInt16)(noisy?i:0);
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Debug.
    [theLabel setText:@"new test"];
    noisy = NO;
    testcount = 0;
    

    audioQueueManager = [[AudioQueueManager alloc] 
                         initWithFormat:[AudioQueueManager audioStream16BitPCMWithSampleRate:44100 channels:1]];
    OSStatus s;
    
    // For recording.
    //s=[audioQueueManager initializeInputWithTarget:self selector:@selector(renderInput:) bufferSize:2048];
    // For synthesizing.
    s=[audioQueueManager initializeOutputWithTarget:self selector:@selector(renderOutput:) bufferSize:outputFrameSize];
    
    s=[audioQueueManager start];

    /*
     // The AVAudioSession interruption delegates should be implemented in order to 
     // correctly handle interruptions.
    NSError* error = nil;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (error) NSLog(@"setActive error: %@", [error localizedDescription]);
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) NSLog(@"setCategory error: %@", [error localizedDescription]);    
     */
    
    
    /*
    // AudioManager init.
    audioManager = [[AudioManager alloc] init];
	audioManager.computeSpectrum = YES;
	[audioManager initializeAudioUnit];
	[audioManager startAudioUnit];
	// alert if audio unit is not working 
	// (assume it means no microphone is available)
	if (audioManager.errorStatus) {
		UIAlertView *alertView = [[UIAlertView alloc] 
								  initWithTitle:@"No microphone available." 
								  message:@"Connect a microphone to see the audio." 
								  delegate:self 
								  cancelButtonTitle:@"OK" 
								  otherButtonTitles:nil];
		[alertView show];
	}
    
    // Start a timer.
    theTimer = [NSTimer scheduledTimerWithTimeInterval:.2 
                                                target:self 
                                              selector:@selector(renderOldstyle) 
                                              userInfo:nil 
                                               repeats:YES];
     */

}

-(IBAction)buttonPushed:(id)sender {
    noisy = !noisy;
}

-(IBAction)buttonOn:(id)sender {
    noisy = YES;
}

-(IBAction)buttonOff:(id)sender {
    noisy = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
