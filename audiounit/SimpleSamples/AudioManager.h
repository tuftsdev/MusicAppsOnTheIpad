//
//  AudioManager.h
//  spektrum
//
//  Created by Garth Griffin on 3/23/10.
//  Copyright Garth Griffin 2010. 
//

/*
 Useful tutorial here: http://www.slideshare.net/invalidname/core-audio-dont-be-afraid-to-play-it-loud-360idev-san-jose-2010
 */

/*
 NOTE 
 This implementation of the FFT uses a lot of floating point operations.
 On the older arm6 iPhone architecture, this is very expensive, so if you are
 targeting older architectures it is recommended that you turn OFF the
 "compile for thumb" option under Target Info -> Build.
 For more information see: http://stackoverflow.com/questions/8390606/is-there-a-way-to-compile-for-arm-rather-than-thumb-in-xcode-4
 */


#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioManager : NSObject {
	float* audioData;
	int audioLen;
	float* spectrumData;
	int spectrumLen;
	
	BOOL computeSpectrum;
	
	int errorStatus;
}

-(void)initializeAudioUnit;
-(void)startAudioUnit;
-(void)stopAudioUnit;
-(void)getAudioFrame;
-(BOOL)testGettingAudio;

@property(readonly) float* audioData;
@property(readonly) int audioLen;
@property(readonly) float* spectrumData;
@property(readonly) int spectrumLen;
@property(readonly) int errorStatus;
@property BOOL computeSpectrum;

@end

