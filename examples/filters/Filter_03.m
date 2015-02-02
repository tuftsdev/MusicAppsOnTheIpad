sample_rate = 32768;  %power of 2
number_samples = 256;
 
freq = [1 15] * 1000;
amplitude = [1 0.5];
 
% Calculate integer vector of samples
t = (0:number_samples-1) / sample_rate;
 
% signal - original noisy sinewave function
signal = amplitude * sin(2*pi*freq'*t);
% plot (signal);

% -------------------------------------
% Set cutoff frequency (500 Hz)
freq_cutoff_hz = 500;
 
% normalize cutoff frequency to Nyquist
% this reduces amount of data shown on plot
nyquist = sample_rate / 2;
freq_cutoff_norm = freq_cutoff_hz / nyquist;
 
% Specify FIR order -- coefficients - 1
order = 28;

% -------------------------------------
% FIR1 filter
% fir1 implements the classical method of windowed linear-phase
% FIR digital filter design [1]. It designs filters in standard lowpass,
% highpass, bandpass, and bandstop configurations. By default the
% filter is normalized so that the magnitude response of the filter
% at the center frequency of the passband is 0 dB.
fir1_coeff = fir1(order, freq_cutoff_norm);

% -------------------------------------
% Analyse the filter using the Filter Visualization tool
% 'Fs' ? controls the sampling frequency of filters in FVTool.
% The sampling frequency vector must be of the same length as the
% number of filters or a scalar value. If it is a vector, each value
% is applied to its corresponding filter. If it is a scalar,
% the same value is applied to all filters.
fvtool(fir1_coeff, 'Fs', sample_rate)

% -------------------------------------
% filter orginal noisy sine wave signal
filtered_signal = filter(fir1_coeff, 1, signal);

% -------------------------------------
% group delay is a measure of the time delay of the amplitude crest and
% troughs of the sinusoidal modes of a signal through a system,
% and a function of each mode.
% Group delay by number of samples
group_delay = median(grpdelay(fir1_coeff))
% group delay in seconds
group_delay_sec = group_delay / sample_rate;
 
% -------------------------------------
% Plot the original signal...
figure(1)
plot(t, signal, 'LineWidth', 1)
% put additon plots on same chart
hold on
% plot filtered signal with transient (delay)
%plot(t-group_delay_sec, filtered_signal, 'r-', 'LineWidth', 3)
 
% plot filtered signal without transient)
plot(t(order:end)-group_delay_sec, filtered_signal(order:end), 'k', 'LineWidth', 3);
 
grid on
hold off