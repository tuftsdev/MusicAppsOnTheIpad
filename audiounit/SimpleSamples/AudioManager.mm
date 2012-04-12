//
//  AudioManager.m
//  spektrum
//
//  Created by Garth Griffin on 3/23/10.
//  Copyright Garth Griffin 2010. 
//

#import "AudioManager.h"
#import "SpectrumAnalysis.h"

// initial length of buffers (adjusted at runtime if necessary)
#define INIT_BUFFER_LEN 2048

// hardware constants
#define kOutputBus 0
#define kInputBus 1

// Function prototypes.
void checkStatus(OSStatus s);
void rioInterruptionListener(void *inClientData, UInt32 inInterruption);
void setBufferLens(int length);
void analysisBuffersAlloc(int length);
void analysisBuffersReAlloc(int length);
void analysisBuffersFree();

@implementation AudioManager

@synthesize audioData;
@synthesize audioLen;
@synthesize spectrumData;
@synthesize spectrumLen;
@synthesize computeSpectrum;
@synthesize errorStatus;

// Needed because c++ funcs can't recognize obj-c 'self'
AudioManager *THIS;

/*
 Global variables for the AudioUnit
 */
// The AudioUnit itself.
AudioComponentInstance audioUnit;
// Global status variable used for error reporting.
OSStatus status;
// We must store the stream description as a global because callbacks
// may need to know packet sizes for buffer allocation.
AudioStreamBasicDescription audioFormat;
// The rendering callback dumps data into a collection of buffers.
// We keep a global to avoid unnecessary memory allocation.
AudioBufferList *bufferList;

/*
 Global variables for audio processing
 (some also in class interface)
 */
SInt16* grabbedAudioData;
int grabbedAudioLen;
SpectrumAnalysisPtr spectrumAnalysis;

/*
 Simple function to check that status is okay.
 This prints a warning if the status is not zero.
 */
void checkStatus(OSStatus s) {
	if (s) {
		NSLog(@"WARNING (AudioManager): status = %ld",s);
		THIS->errorStatus = (int)s;
	}
}

#pragma mark -Audio Session Interruption Listener

/*
 This is called by the AudioUnit when an interruption occurs.
 For example, I believe removing the headphones will call this function.
 */
void rioInterruptionListener(void *inClientData, UInt32 inInterruption) {
	printf("Session interrupted! --- %s ---", inInterruption == kAudioSessionBeginInterruption ? "Begin Interruption" : "End Interruption");
	
	if (inInterruption == kAudioSessionEndInterruption) {
		// make sure we are again the active session
		AudioSessionSetActive(true);
		AudioOutputUnitStart(audioUnit);
	}
	
	if (inInterruption == kAudioSessionBeginInterruption) {
		AudioOutputUnitStop(audioUnit);
	}
}

#pragma mark -RIO Render Callback

/*
 This is called by the AudioUnit every time fresh samples are available.
 */
static OSStatus rioRenderCallback(void *inRefCon, 
                                  AudioUnitRenderActionFlags *ioActionFlags, 
                                  const AudioTimeStamp *inTimeStamp, 
                                  UInt32 inBusNumber, 
                                  UInt32 inNumberFrames, 
                                  AudioBufferList *ioData) {
	// Check that our buffers are the right size
	// The device has insisted that it give me interleaved stereo despite asking for 
	// one channel per frame.
	// Since the mic is mono, every other value is zero.
	// It is worth noting that this is not true on the simulator.
	// So... wtf.
	// Anyhow, we must multiply mBytesPerFrame by two and discard every other value.
	// On hardware without this problem, this will be the equivalent of 
	// rough downsampling by a factor of two.
	UInt32 inBytesTotal = inNumberFrames*audioFormat.mBytesPerFrame*2;
	if (inBytesTotal != bufferList->mBuffers[0].mDataByteSize) {
		NSLog(@"AudioManager.rioRenderCallback: BufferList reallocing to %lu bytes",inBytesTotal);
		bufferList->mBuffers[0].mDataByteSize = inBytesTotal;
		bufferList->mBuffers[0].mData = realloc(bufferList->mBuffers[0].mData, inBytesTotal);
	}
	
	// render the audio
	status = AudioUnitRender(audioUnit, ioActionFlags, inTimeStamp, 1, inNumberFrames, bufferList);
	checkStatus(status);
	
	// return success
	return 0;
}
 

-(id)init {
	if (self = [super init]) {
		// set c++ 'THIS' to obj-c 'self'
		THIS = self;
		
		// initialize buffer lengths to -1 so we know they're not alloc'd yet
		grabbedAudioLen = -1;
		audioLen = -1;
		spectrumLen = -1;
		
		// initialize error status to zero
		errorStatus = 0;
	}
	return self;
}


/*
 Functions for allocating, reallocating, and freeing the analysis buffers.
 These could be their own class, except for the silliness about the spectrum
 analyzer needing different lengths.
 */
void setBufferLens(int length) {
	grabbedAudioLen = length;
	THIS->audioLen = length/2;
	THIS->spectrumLen = THIS->audioLen/2;
}
void analysisBuffersAlloc(int length) {
	// calculate lengths
	setBufferLens(length);
	
	// allocate buffers
	grabbedAudioData = (SInt16*)malloc(sizeof(SInt16)*grabbedAudioLen);
	THIS->audioData = (float*)malloc(sizeof(float)*THIS->audioLen);
	THIS->spectrumData = (float*)malloc(sizeof(float)*THIS->spectrumLen);
	
	// allocate spectrum analysis struct
	spectrumAnalysis = SpectrumAnalysisCreate(THIS->audioLen);
}
void analysisBuffersReAlloc(int length) {
	// calculate lengths
	setBufferLens(length);
	
	// re-allocate buffers
	grabbedAudioData = (SInt16*)realloc(grabbedAudioData, sizeof(SInt16)*grabbedAudioLen);
	THIS->audioData = (float*)realloc(THIS->audioData, sizeof(float)*THIS->audioLen);
	THIS->spectrumData = (float*)realloc(THIS->spectrumData, sizeof(float)*THIS->spectrumLen);
	
	// free and allocate a new spectrum analysis struct
	SpectrumAnalysisDestroy(spectrumAnalysis);
	spectrumAnalysis = SpectrumAnalysisCreate(THIS->audioLen);
}
void analysisBuffersFree() {
	free(grabbedAudioData);
	free(THIS->audioData);
	free(THIS->spectrumData);
	SpectrumAnalysisDestroy(spectrumAnalysis);
}

// computes the audio spectrum from audio data (decibels)
-(void) getAudioFrame {
	int audioBytes = bufferList->mBuffers[0].mDataByteSize;
	int newGrabbedAudioLen = audioBytes/sizeof(SInt16);
	
    NSLog(@"sizeof SInt16 = %lu", sizeof(SInt16));
	// allocate buffers if necessary
	if (audioLen == -1 || spectrumLen == -1 || grabbedAudioLen == -1) {
		NSLog(@"AudioManager.computeSpectrum: first time buffer allocation, length %d",newGrabbedAudioLen);
		analysisBuffersAlloc(newGrabbedAudioLen);
	}
	
	// resize buffers if necessary
	if (newGrabbedAudioLen != grabbedAudioLen) {
		NSLog(@"AudioManager.computeSpectrum: buffer resizing to length %d",newGrabbedAudioLen);
		analysisBuffersReAlloc(newGrabbedAudioLen);
	}
	
	// grab audio data
	memcpy(grabbedAudioData, bufferList->mBuffers[0].mData, audioBytes);
	
	// copy to audioData buffer converting to float and omitting every other value
	// (because device gives interleaved stereo, see rioRenderCallback for details)
	for (int i=0; i<audioLen; i++) {
		audioData[i] = (float)(grabbedAudioData[i*2]);
	}
	
	// compute spectrum if required
	if (computeSpectrum) {
		SpectrumAnalysisProcess(spectrumAnalysis, audioData, spectrumData);
	}
}

// starting and stopping the audio unit
-(void)startAudioUnit {
	status = AudioOutputUnitStart(audioUnit);
	checkStatus(status);
}
-(void)stopAudioUnit {
	status = AudioOutputUnitStop(audioUnit);
	checkStatus(status);
}

// initialize the audio unit
-(void)initializeAudioUnit {
	UInt32 flag;
	
	// describe the audio unit
	AudioComponentDescription desc;
	desc.componentType = kAudioUnitType_Output;
	desc.componentSubType = kAudioUnitSubType_RemoteIO;
	desc.componentFlags = 0;
	desc.componentFlagsMask = 0;
	desc.componentManufacturer = kAudioUnitManufacturer_Apple;
	
	// get the component
	AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);
	
	// get audio units
	status = AudioComponentInstanceNew(inputComponent, &audioUnit);
	checkStatus(status);
	
	// enable IO for recording
	flag = 1;
	status = AudioUnitSetProperty(audioUnit, 
								  kAudioOutputUnitProperty_EnableIO, 
								  kAudioUnitScope_Input, 
								  kInputBus, 
								  &flag, 
								  sizeof(flag));
	checkStatus(status);
	
	// describe format
	audioFormat.mSampleRate			= 44100.00;
	audioFormat.mFormatID			= kAudioFormatLinearPCM;
	audioFormat.mFormatFlags		= kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
	audioFormat.mFramesPerPacket	= 1;
	audioFormat.mChannelsPerFrame	= 1;
	audioFormat.mBitsPerChannel		= 16;
	audioFormat.mBytesPerPacket		= 2;
	audioFormat.mBytesPerFrame		= 2;
	
	// Apply requested format to the output bus of the AudioUnit.
    // This tells the AudioUnit how to format the data it outputs.
	status = AudioUnitSetProperty(audioUnit,
								  kAudioUnitProperty_StreamFormat, 
								  kAudioUnitScope_Input, 
								  kOutputBus, 
								  &audioFormat, 
								  sizeof(audioFormat));
	checkStatus(status);
	
    // Specify the callback for the input bus of the AudioUnit.
    // This tells the AudioUnit what function to call when new
    // samples are available. In the function we have to render
    // the data into the AudioUnit.
	AURenderCallbackStruct callbackStruct;
	callbackStruct.inputProc = rioRenderCallback;
	callbackStruct.inputProcRefCon = (__bridge void*)THIS;  // Wtf is '__bridge'.
	status = AudioUnitSetProperty(audioUnit, 
								  kAudioOutputUnitProperty_SetInputCallback, 
								  kAudioUnitScope_Global,
								  kInputBus, 
								  &callbackStruct, 
								  sizeof(callbackStruct));
	checkStatus(status);
	
	// disable automatic recorder buffer allocation (we do it manually)
	flag = 0;
	status = AudioUnitSetProperty(audioUnit, 
								  kAudioUnitProperty_ShouldAllocateBuffer, 
								  kAudioUnitScope_Output, 
								  kInputBus, 
								  &flag, 
								  sizeof(flag));
	checkStatus(status);
	
	// set up buffer list
	bufferList = (AudioBufferList*)malloc(sizeof(AudioBufferList));
	bufferList->mNumberBuffers = audioFormat.mChannelsPerFrame;
	for (UInt16 i=0; i<bufferList->mNumberBuffers; i++) {
		bufferList->mBuffers[i].mNumberChannels = 1;
		bufferList->mBuffers[i].mDataByteSize = INIT_BUFFER_LEN*audioFormat.mBytesPerFrame;
		bufferList->mBuffers[i].mData = malloc(bufferList->mBuffers[i].mDataByteSize);
	}
	
	// initialize audio unit
	status = AudioUnitInitialize(audioUnit);
	checkStatus(status);
}

// Tests the audio unit.
// Audio data of almost all zeroes indicates the audio unit is not receiving data.
-(BOOL)testGettingAudio {
	// Minimum ratio of zeroes:datapoints required for 'fail' result.
	const float minZeroRatioToFail = .999;
	
	// Max number of test to run (will exit early if test result is below cutoff set above).
	// This must be high to ensure at least one frame of audio.
	const int maxNumTests = 30;
	
	// don't need to compute spectrum, so temporarily turn that off, but will be restored
	BOOL prevCompSpec = computeSpectrum;
	computeSpectrum = NO;
	
	// run the tests
	for (int i=0; i<maxNumTests; i++) {
		[self getAudioFrame];
		int zeroCount = 0;
		for (int j=0; j<audioLen; j++) {
			if (audioData[i] == 0) zeroCount++;
		}
		
		// calculate ratio of zeroes to datapoints
		float zeroRatio = (float)zeroCount/audioLen;
		if (zeroRatio < minZeroRatioToFail) {
			// if we're below the failure ratio, return YES right away
			computeSpectrum = prevCompSpec;
			return YES;
		}
	}
	
	// all tests were run and all were above failure ratio, so return NO
	computeSpectrum = prevCompSpec;
	return NO;
}

-(void)dealloc {
	AudioUnitUninitialize(audioUnit);
	
	// free bufferList
	for (UInt16 i=0; i<bufferList->mNumberBuffers; i++) {
		free(bufferList->mBuffers[i].mData);
	}
	free(bufferList);
	
	// free analysis buffers
	analysisBuffersFree();
}

@end
