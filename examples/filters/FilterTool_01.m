 % select sample rate
 sample_rate = 30;

% Specify cutoff frequency (2 Hz)
freq_cutoff_hz = 3;
 
% Normalize cutoff frequency to Nyquist
freq_nyq = sample_rate / 2;
freq_cutoff_norm = freq_cutoff_hz / freq_nyq;
 
% Specify FIR filter order: # of coefficients - 1
order = 7;
 
% Find lowpass FIR filter coefficients by:
% cutoff frequency (normalized) and filter order

% fir1 creates low pass filter via Hamming window
fir1_coeff = fir1(order, freq_cutoff_norm);
 
% Analyse the filter using the Filter Visualization Tool
fvtool(fir1_coeff, 'Fs', sample_rate)
 
% Filter the signal with low pass filter coefficients using the FIR filter
% filtered_signal = filter(fir1_coeff, 1, signal);