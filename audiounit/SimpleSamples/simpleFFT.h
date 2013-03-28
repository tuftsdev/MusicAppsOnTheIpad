/*
 *  simpleFFT.h
 *  
 *	This file contains a simple implementation of a floating-point Fast Fourier Transform.
 *	The algorithm is taken from Numerical Recipes in C (2nd ed.).
 *
 *  It was written primarily by Garth W. Griffin as part of his work at
 *	the Drexel ECE Deptartment's Music Entertainment Technology laboratory
 *	under Youngmoo Kim. Other students in the lab assisted with the effort,
 *	in particular Ray Migneco. 
 *
 *	2009
 *  
 */


/*
 This function computes the Discrete Fourier Transform of a real-valued signal
 in the time domain. The length of the signal must be a power of 2. The operation
 is done in-place, but the output will be two buckets longer than the input.
 This must be taken into account when allocating memory.
 
 Inputs:
	data: real-valued signal in time-domain
	length: length of the data array (must be power of 2)
 
 Outputs:
 The positive half of the symmetric signal, stored in the input array.
 Because of the Nyquist term, the output requires length+2 buckets. This
 must be accounted for beforehand!
 */
void RealFFT_forward(float* data, int length);


/*
 This function computes the inverse Discrete Fourier Transform of the frequency domain
 transofrm of a real-valued signal. Imaginary components in the output are assumed to be
 zero and are discarded.
 
 // for real-valued signal x:
 RealFFT_forward(x, length_x);
 RealFFT_inverse(x, length_x);
 // x is (essentially) unchanged.
 
 Inputs:
	data: FFT of a real-valued signal
	length: The length of the output signal.
 
 Outputs:
 The real values of the inverse FFT of the input, stored in the input array.
 */
void RealFFT_inverse(float* data, int length);