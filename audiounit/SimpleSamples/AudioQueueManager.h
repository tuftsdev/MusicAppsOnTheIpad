//
//  AudioQueueManager.h
//  SimpleSamples
//
//  Created by Garth Griffin on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>

#define AUDIO_QUEUE_NUM_BUFFERS 3

typedef struct {
    AudioStreamBasicDescription audioFormat;
    AudioQueueRef audioQueue;
    AudioQueueBufferRef buffers[AUDIO_QUEUE_NUM_BUFFERS];   
} AudioQueueState;

@interface AudioQueueManager : NSObject {
    int test;
    AudioQueueState state;
}

-(id) initWithFormat:(AudioStreamBasicDescription)format;
+(AudioStreamBasicDescription) audioStream16BitPCMWithSampleRate:(float) sampleRate channels:(int)channels;

//-(OSStatus)  initializeInputWithCallback:(AudioQueueInputCallback)callback 
//                                userInfo:(void*)userInfo 
//                         samplesPerBuffer:(int)numSamples;
-(OSStatus) initializeInputWithTarget:(NSObject*)target 
                             selector:(SEL)selector 
                           bufferSize:(int)len;
//-(OSStatus)  initializeOutputWithCallback:(AudioQueueOutputCallback)callback 
//                                userInfo:(void*)userInfo 
//                         samplesPerFrame:(int)numSamples;  // Currently broken!
-(OSStatus) initializeOutputWithTarget:(NSObject*)target 
                              selector:(SEL)selector 
                            bufferSize:(int)len;

-(OSStatus) start;

@property(nonatomic, retain) NSObject* audioCallbackObject;
@property(nonatomic, unsafe_unretained) SEL audioCallbackSelector;
@property(nonatomic) AudioQueueBufferRef currentBuffer;
@property(readonly) long bufferLen;

@end
