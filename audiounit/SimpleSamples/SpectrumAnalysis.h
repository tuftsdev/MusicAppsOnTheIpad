/*
 *  SpectrumAnalysis.h
 *  spektrum
 *
 *  Created by Garth Griffin on 4/8/10.
 *  Copyright Garth Griffin 2010. 
 *	
 */

struct SPECTRUM_ANALYSIS;
typedef struct SPECTRUM_ANALYSIS* SpectrumAnalysisPtr;

// Creates a spectrum analysis object. The length must be a power of 2.
SpectrumAnalysisPtr SpectrumAnalysisCreate(int length);

// Destroys a spectrum analysis object.
void SpectrumAnalysisDestroy(SpectrumAnalysisPtr p);

/*
 Do the spectrum analysis.
 
 Inputs:
	p: SpectrumAnalysis handle (opaque).
	inTimeSignal: time signal of same length as specified in SpectrumAnalysisCreate.
	outMagSpec: magnitude spectrum, length of array must be at least half the length of the time signal
 
 The input signal is weighted with a Hann window, then an in-place FFT is taken, and then the resulting magnitude
 spectrum is copied to the output buffer.
 */
void SpectrumAnalysisProcess(SpectrumAnalysisPtr p, const float* inTimeSignal, float* outMagSpec);
