//
//  AudioQueueManager.m
//  SimpleSamples
//
//  Created by Garth Griffin on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 Took lots of info from these two blog posts.
 For reading samples: http://trailsinthesand.com/exploring-iphone-audio-part-1/ (parts 1-5)
 For writing samples: http://stackoverflow.com/questions/2067267/where-to-start-with-audio-synthesis-on-iphone
*/
 
#import "AudioQueueManager.h"


@implementation AudioQueueManager

@synthesize audioCallbackObject;
@synthesize audioCallbackSelector;
@synthesize currentBuffer;
@synthesize bufferLen;

// Function prototypes.
void AudioQueueManager_DefaultAudioInputCallback(void *inUserData, 
                                                 AudioQueueRef inAQ, 
                                                 AudioQueueBufferRef inBuffer, 
                                                 const AudioTimeStamp *inStartTime, 
                                                 UInt32 inNumberPacketDescriptions, 
                                                 const AudioStreamPacketDescription *inPacketDescs);
void AudioQueueManager_DefaultAudioOutputCallback(void *outUserData, AudioQueueRef outAQ, 
                                                  AudioQueueBufferRef outBuffer);

OSStatus AudioQueueManager_checkStatus(OSStatus s, NSString* caller);

// Require a pointer to self because C++ code can't use Objective-C 'self' keyword.
AudioQueueManager* AudioQueueManager_self;

OSStatus AudioQueueManager_checkStatus(OSStatus s, NSString* caller) {
	if (s) {
		NSLog(@"WARNING (AudioManager: %@) status = %ld", caller, s);
	}
    return s;
}

-(id) initWithFormat:(AudioStreamBasicDescription)format {
    if (self = [super init]) {
        AudioQueueManager_self = self;
        state.audioFormat = format;
    }
    return self;
}

/*
 Stream description.
 See the docs for list of enum values.
 Each buffers will be filled with frames.
 Each frame contains some number of packets.
 Each packet contains some number of bytes of audio data.
 Each byte of audio data will be in the specified format
 at the specified sample rate.
 */
+(AudioStreamBasicDescription) audioStream16BitPCMWithSampleRate:(float) sampleRate channels:(int)channels {
    AudioStreamBasicDescription a;
    a.mSampleRate       = sampleRate;
	a.mFormatID         = kAudioFormatLinearPCM;
	a.mFramesPerPacket	= 1;
	a.mChannelsPerFrame	= channels;
	a.mBitsPerChannel	= 16;
	a.mBytesPerPacket	= 2;
	a.mBytesPerFrame	= 2;
    a.mReserved         = 0;  // Don't know what this is, must be 0?
    a.mFormatFlags = 
        kAudioFormatFlagIsSignedInteger | 
        kAudioFormatFlagIsPacked |
        kAudioFormatFlagIsBigEndian;
    return a;
}


void AudioQueueManager_DefaultAudioInputCallback(void *inUserData, 
                                                 AudioQueueRef inAQ, 
                                                 AudioQueueBufferRef inBuffer, 
                                                 const AudioTimeStamp *inStartTime, 
                                                 UInt32 inNumberPacketDescriptions, 
                                                 const AudioStreamPacketDescription *inPacketDescs) {
    AudioQueueManager_self->currentBuffer = inBuffer;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [AudioQueueManager_self->audioCallbackObject performSelector:AudioQueueManager_self->audioCallbackSelector 
                                                 withObject:AudioQueueManager_self];
#pragma clang diagnostic pop    
    AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
}

void AudioQueueManager_DefaultAudioOutputCallback(void* outUserData, 
                                                  AudioQueueRef outAQ, 
                                                  AudioQueueBufferRef outBuffer) {
    AudioQueueManager_self->currentBuffer = outBuffer;
    outBuffer->mAudioDataByteSize = 
        AudioQueueManager_self->state.audioFormat.mBytesPerFrame * AudioQueueManager_self->bufferLen;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [AudioQueueManager_self->audioCallbackObject performSelector:AudioQueueManager_self->audioCallbackSelector 
                                                      withObject:AudioQueueManager_self];
#pragma clang diagnostic pop 
    AudioQueueEnqueueBuffer(outAQ, outBuffer, 0, NULL);
}

-(OSStatus) allocateBuffersOfLength:(int)numSamples {
    int bufBytes = numSamples*state.audioFormat.mBytesPerFrame;
    NSLog(@"Allocating buffers of size %d", bufBytes);
    OSStatus s;
    for(int i = 0; i < AUDIO_QUEUE_NUM_BUFFERS; i++) {
        s = AudioQueueAllocateBuffer(state.audioQueue,
                                     bufBytes, &state.buffers[i]);
        AudioQueueManager_checkStatus(s, @"Allocate buffer");
    }
    return s;
}

/* 
 Callback must re-enqueue buffer! Use this line of code:
     AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
 Alternatively, use the target/selector version of this (see below).
 */
-(OSStatus)  initializeInputWithCallback:(AudioQueueInputCallback)callback 
                                userInfo:(void*)userInfo 
                        bufferSize:(int)len
{
    bufferLen = len;
    OSStatus s;
    s = AudioQueueNewInput(&state.audioFormat, 
                           callback, 
                           userInfo,
                           CFRunLoopGetCurrent(), // Could be NULL for separate thread.
                           kCFRunLoopCommonModes, // I don't know what this is.
                           0, // Reserved. Must be zero. I don't know what it is. 
                           &state.audioQueue);
    if (AudioQueueManager_checkStatus(s, @"new input")) return s;
    if ([self allocateBuffersOfLength:len]) return s;
    for (int i=0; i<AUDIO_QUEUE_NUM_BUFFERS; i++) {
        s = AudioQueueEnqueueBuffer(state.audioQueue,
                                    state.buffers[i], 0, NULL);
        if (AudioQueueManager_checkStatus(s, @"Enqueue buffer")) return s;
    }
    return s;
}

-(OSStatus) initializeInputWithTarget:(NSObject*)target selector:(SEL)selector bufferSize:(int)len {
    audioCallbackObject = target;
    audioCallbackSelector = selector;
    return [self initializeInputWithCallback:AudioQueueManager_DefaultAudioInputCallback 
                                    userInfo:&state 
                                  bufferSize:len];
}

/* 
 Callback must re-enqueue buffer! Use this line of code:
    AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
 Alternatively, use the target/selector version of this (see below).
 */

-(OSStatus)  initializeOutputWithCallback:(AudioQueueOutputCallback)callback 
                                 userInfo:(void*)userInfo 
                               bufferSize:(int)len
{
    
    bufferLen = len;
    OSStatus s;
    s = AudioQueueNewOutput(&state.audioFormat, 
                            callback, 
                            userInfo,
                            CFRunLoopGetCurrent(), // Could be NULL for separate thread.
                            kCFRunLoopCommonModes, // I don't know what this is.
                            0, // Reserved. Must be zero. I don't know what it is. 
                            &state.audioQueue);
    if (AudioQueueManager_checkStatus(s, @"new output")) return s;
    s = [self allocateBuffersOfLength:len];
    if (AudioQueueManager_checkStatus(s, @"allocate buffers")) return s;
    
    // TODO Prime the buffers.
    // Need to call the callback. I don't know how to do that.
    
    return s;
}

-(OSStatus) initializeOutputWithTarget:(NSObject*)target selector:(SEL)selector bufferSize:(int)len {
    NSLog(@"init output target");
    
    audioCallbackObject = target;
    audioCallbackSelector = selector;

    
    OSStatus s = [self initializeOutputWithCallback:AudioQueueManager_DefaultAudioOutputCallback 
                                     userInfo:&state 
                              bufferSize:len];
    AudioQueueManager_checkStatus(s, @"init output target");
    
    // Allocate the buffers.
    s = [self allocateBuffersOfLength:len];
    
    // Prime the buffers.
    NSLog(@"priming");
    for (int i=0; i<AUDIO_QUEUE_NUM_BUFFERS; i++) 
        AudioQueueManager_DefaultAudioOutputCallback(&state, state.audioQueue, state.buffers[i]);
    
    return s;
}

-(OSStatus) start {
    OSStatus s = AudioQueueStart(state.audioQueue, NULL);
    AudioQueueManager_checkStatus(s, @"start");
    return s;
}




@end
