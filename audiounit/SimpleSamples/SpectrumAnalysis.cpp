/*
 *  SpectrumAnalysis.cpp
 *  spektrum
 *
 *  Created by Garth Griffin on 4/8/10.
 *  Copyright Garth Griffin 2010. 
 *
 */

#include "SpectrumAnalysis.h"
#include "simpleFFT.h"
#include <math.h>
#include <stdlib.h>
#include <stdio.h>


// specify whether or not to do decibel conversion
#define CONVERT_TO_DB 1

// prototype
void convertToDecibels(float* magSpec, int length);
void hannWindowCalculate(float* window, int len);
void getMagFromFFT(const float* inFFTData, float* magData, int len);

#if CONVERT_TO_DB
// sensitivity constant for dB conversion
//	This represents the maximum value expected from the soundcard.
//	It has been optimized experimentally.
static const float k0dBLevel = 18000;
void convertToDecibels(float* magSpec, int length) {
	float ratio;
	for (int i=0; i<length; i++) {
		ratio = magSpec[i]/k0dBLevel;
		if (ratio != 0) {
			magSpec[i] = 10*logf(ratio);
		} else {
			magSpec[i] = k0dBLevel;
		}
	}
}
#endif

// struct to store spectrum analysis instance
struct SPECTRUM_ANALYSIS {
	int mLength;
	float* mWeightingWindow;
	float* mFFTBuffer;
};

// computes a Hanning window of the specified length
void hannWindowCalculate(float* window, int len) {
	int i;
    for (i=0; i<len; i++) {
        window[i] = (float)((1.-cos(2.*M_PI*(i+.5)/((float)len)))/2.);
    }	
}

// calculates the magnitude of the FFT
// signal must be alternating real and complex values
// length of output is inLen/2
// the nyquist term (buckets 0 and 1) is discarded
void getMagFromFFT(const float* inFFTData, float* magData, int len) {
	float real,imag;
	float scalefactor = 1./len;
	for (int i=1; i<=len/2; i++) {
		real = inFFTData[2*i];
		imag = inFFTData[2*i+1];
		magData[i-1] = sqrtf(real*real+imag*imag) * scalefactor;
	}
}


void SpectrumAnalysisProcess(SpectrumAnalysisPtr p, const float* inTimeSig, float* outMagSpec) {
	int len = p->mLength;
	
	// apply the weighting window
	for (int i=0; i<len; i++) {
		p->mFFTBuffer[i] = (inTimeSig[i]) * (p->mWeightingWindow[i]);
	}
	
	// take the FFT
	RealFFT_forward(p->mFFTBuffer, len);

	// compute the magnitude
	getMagFromFFT(p->mFFTBuffer, outMagSpec, len/2);
	
#if CONVERT_TO_DB
	// convert to decibels if required
	convertToDecibels(outMagSpec, len/2);
#endif
}

SpectrumAnalysisPtr SpectrumAnalysisCreate(int length) {
	// allocate a new SPECTRUM_ANALYSIS struct
	SpectrumAnalysisPtr p = (SPECTRUM_ANALYSIS*)malloc(sizeof(SPECTRUM_ANALYSIS));
	p->mLength = length;

	// create Hann window of the correct length
	p->mWeightingWindow = (float*)malloc(length*sizeof(float));
	hannWindowCalculate(p->mWeightingWindow,length);
	
	// allocate the FFT buffer
	// we need two "extra" buckets for nyquist term
	p->mFFTBuffer = (float*)calloc(length+2,sizeof(float));
	
	// return new struct
	return p;
}

void SpectrumAnalysisDestroy(SpectrumAnalysisPtr p) {
	// free the weighting window
	free(p->mWeightingWindow);
	
	// free the FFT buffer
	free(p->mFFTBuffer);
	
	// free the struct
	free(p);
}