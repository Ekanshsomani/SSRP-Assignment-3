% Parameters 
Fs = 4000; % Sample rate (samples per second)
T = 3; % Duration (seconds) 

% Create Time Vector 
t = 0:1/Fs:T-1/Fs; % Generate Audio Signal (Sine Wave) 

audio_signal = 0.5 * sin(2 * pi * 440 * t) + 2 * sin(2 * pi * 880 * t) + 0.25 * sin(2 * pi * 1760 * t);

% Number of samples
N = length(audio_signal);

X_manual = zeros([1 N]);
omega_0 = 440*pi;
for k = 1:N
    Angle = k * omega_0 * t;
    X_manual(k) = audio_signal * (cos(Angle) + 1i*sin(Angle))';
end

f_manual = (0:N-1) * Fs/N;
magnitude_manual = abs(X_manual)/N;

% Plot Comparison
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot(f_manual, magnitude_manual);

title('Manually Computed DFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
set(axes1,'GridAlpha',0.5,'MinorGridAlpha',0.4,'XMinorGrid','on')
set(gca,'FontSize',12)

% Compute DFT using MATLAB built-in function
X_builtin = fftshift(fft(audio_signal));

% Magnitude of the built-in DFT
magnitude_builtin = abs(X_builtin)/N;

% Define Frequency Vector
N = length(X_builtin);
f_bultin = (-N/2: (N-1)/2) * (2*Fs / N);

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot(f_bultin, magnitude_builtin);

title('MATLAB Built-in FFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
set(axes1,'GridAlpha',0.5,'MinorGridAlpha',0.4,'XMinorGrid','on')
set(gca,'FontSize',12)

% Display Comparison
figure;
plot(f_manual, magnitude_manual, 'r', f_bultin, magnitude_builtin, 'b--');
title('Comparison of Manually Computed DFT and MATLAB FFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('Manual DFT', 'MATLAB FFT');