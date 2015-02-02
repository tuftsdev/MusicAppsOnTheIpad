% Low Pass Frequency example to show the generation of the 
% frequency coefficients
% cutoff frequency
Wc = 0.4; 
% filter length
N = 21;
% phase shift
m = (N-1)/2
% samples
n = 0:2*m + 10;
% delayed ideal filter
h = Wc/pi*sinc(Wc*(n-m)/pi);
plot (h);
figure;
% window
window = [ones(1, N) zeros(1, length(n) - N)];
% fir filter
hd = h.*window;
% frequency response
Wresponse = -pi:2*pi/300:pi;
% [h,w] = freqz(b,a,n) returns the n-point frequency response vector,
% h, and the corresponding angular frequency vector, w, for the
% digital filter with numerator and denominator polynomial coefficients
% stored in b and a, respectively.
Hd = freqz(hd, 1, Wresponse);
plot (Wresponse, abs(Hd));
