/*
   Garth W. Griffin, 2009

	Provides a simple FFT implementation.
 
 Note! The data array must have two extra buckets for repacking. I know, I know, it's stupid. Deal with it.
*/

#include <math.h>
#include "simpleFFT.h"

// shortcut to swap two values in place
#define SWAP(a,b)tempr=(a);(a)=(b);(b)=tempr

// prototypes
void realFFT(float* indata, unsigned long n, int isign);
void FFT(float* data, unsigned long nn, int isign);
void unpackRealFFT(float* data, int n);
void repackRealFFT(float* data, int n);

/* realFFT: calculates Fourier transform of a set of data points
 *  data: input signal
 *  n: number of data points (must be power of 2)
 *  isign: 1 for FFT, -1 for iFFT
 *
 * This function calculates the Fourier transform of a set of n real-valued
 * data points stored in the array data, replacing the data in the array with
 * the positive frequency half of its Fourier transform. The real-valued
 * first and last components of the complex transform are data[0] and data[1],
 * each of which has imaginary component equal to zero.
 * The value of n must be a power of two.
 * 
 * This function calculates the inverse Fourier transform of an array of
 * complex data if that data is the Fourier transform of real data.
 * In this case, the input must be formatted like the output of a forward
 * transform using this function. The result must be multiplied by 2/n;
 * 
 * This code was taken from Numerical Recipes in C.
 * Some edits were added by GWG.
 */
void realFFT(float* indata, unsigned long n, int isign) {

    // GWG EDIT
    // numerical recipes was set up to work with 1:n
    // this is a workaround to make it work with 0:n-1
    float* data = indata - 1;
	
	void FFT(float* data,unsigned long nn,int isign); 
	unsigned long i, i1, i2, i3, i4, np3; 
	float c1 = 0.5, c2, h1r, h1i, h2r, h2i; 
	double wr, wi, wpr, wpi, wtemp, theta; //Doubleprecisionforthetrigonometricrecurrences. 
	theta = 3.141592653589793/(double)(n>>1); //Initializetherecurrence. 
	if(isign==1){ 
		c2=-0.5; 
		FFT(data, n>>1, 1); //Theforwardtransformishere. 
	} 
	else{ 
		c2=0.5; //Otherwisesetupforaninversetransform. 
		theta = -theta; 
	} 
	wtemp = sin(0.5*theta); 
	wpr = -2.0*wtemp*wtemp; 
	wpi = sin(theta); 
	wr = 1.0 + wpr; 
	wi = wpi; 
	np3 = n+3; 
	for(i=2; i<=(n>>2); i++){ //Case i=1 doneseparatelybelow. 
	i4 = 1 + (i3 = np3 - (i2 = 1+ (i1 = i + i - 1)) ); 
	h1r = c1*(data[i1] + data[i3]); //Thetwoseparatetransformsareseparatedoutof data. 
	h1i = c1*(data[i2] - data[i4]); 
	h2r = -c2*(data[i2] + data[i4]); 
	h2i = c2*(data[i1] - data[i3]); 
	data[i1] = h1r + wr*h2r - wi*h2i; //Here theyare recombinedtoformthetruetransformof theoriginalrealdata. 
	data[i2] = h1i + wr*h2i + wi*h2r; 
	data[i3] = h1r - wr*h2r + wi*h2i; 
	data[i4] = -h1i + wr*h2i + wi*h2r; 
	wr=(wtemp=wr)*wpr-wi*wpi+wr; //Therecurrence. 
	wi=wi*wpr+wtemp*wpi+wi; 
	} 
	if(isign==1){
		data[1]=(h1r=data[1])+data[2]; //Squeezetheﬁrst andlast datatogethertogetthemall withintheoriginal array. 
		data[2]=h1r-data[2]; 
	} else{ 
		data[1]=c1*((h1r=data[1])+data[2]); 
		data[2]=c1*(h1r-data[2]); 
		FFT(data,n>>1,-1); //Thisistheinversetransformforthecaseisign=-1.
	} 
}


/* FFT: implementation of Fast Fourier Transform
 *  data: input signal
 *  nn: the number of FFT points
 *  isign: 1 for FFT, -1 for iFFT
 *
 * Replaces data with transform of the data.
 * This algorithm is taken from "Numerical Recipes in C" (2nd ed.).
 * Note that the first element must be zero, and the values in data
 * must alternate between real and imaginary values.
 */
void FFT(float* data, unsigned long nn, int isign) {

	unsigned long n,mmax,m,j,istep,i;
	float wtemp,wr,wpr,wpi,wi,theta;
	float tempr,tempi;
	
	n=nn << 1;
	j=1;
	for(i=1;i<n;i+=2) {
		if(j > i) {
			SWAP(data[j],data[i]);
			SWAP(data[j+1],data[i+1]);
		}
		m=n >> 1;
		while(m >= 2 && j > m) {
			j -= m;
			m >>= 1;
		}
		j += m;
	}
	
	mmax=2;
	while(n > mmax) {
		istep=mmax << 1;
		theta=isign*(6.28318530717959/mmax);
		wtemp=sin(0.5*theta);
		wpr = -2.0*wtemp*wtemp;
		wpi=sin(theta);
		wr=1.0;
		wi=0.0;
		for(m=1;m<mmax;m+=2) {
			for(i=m;i<=n;i+=istep) {
				j=i+mmax;
				tempr=wr*data[j]-wi*data[j+1];
				tempi=wr*data[j+1]+wi*data[j];
				data[j]=data[i]-tempr;
				data[j+1]=data[i+1]-tempi;
				data[i] += tempr;
				data[i+1] += tempi;
			}
			wr=(wtemp=wr)*wpr-wi*wpi+wr;
			wi=wi*wpr+wtemp*wpi+wi;
		}
		mmax=istep;
	}

}


/* unpackRealFFT: reorders output of realFFT forward transform
 *  data: data after forward transform from realFFT
 *  n: length of data array
 *
 * Formats values in data array to be alternating real/complex values from
 * positive half of symmetric spectrum of FFT of real signal. As a result,
 * the length of data will increase by two buckets. There must be enough
 * space already malloc'd to allow this to happen.
 *
 * For some reason, numerical recipes calculates the conjunct of what matlab
 * and other such programs calculate. Thus, we take the conjunct here as well
 * by multiplying each imaginary component by -1.
 */
void unpackRealFFT(float* data, int n) {
    for (int i=3; i<n; i+=2) data[i] *= -1;
    data[n] = data[1];
    data[1] = data[n+1] = 0.0;
}

/* repackRealFFT: exactly reverses unpack
 *  data: data after being unpacked
 *  n: length of original array (i.e. not including extra two buckets)
 * 
 * See unpack for details.
 */
void repackRealFFT(float* data, int n) {
    data[1] = data[n];
    for (int i=3; i<n; i+=2) data[i] *= -1;
}

/* 
 * realFFT_forward: does forward FFT of real data
 * realFFT_inverse: does inverse FFT to real data
 *
 * data: data to perform FFT on
 * length: length of data array (not including two extra buckets)
 */

void RealFFT_forward(float* data, int length) {
	realFFT(data, length, 1);
	unpackRealFFT(data, length);
}

void RealFFT_inverse(float* data, int length) {
	repackRealFFT(data, length);
	realFFT(data, length, -1);
}


