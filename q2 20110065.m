T = 1; % Pulse width
t = linspace(-2*T, 2*T, 1000); % Time vector over a longer interval 

% Define the rectangular pulse 
x = double(abs(t) <= T/2); % Compute the Fourier Transform 
X = fftshift(fft(x)); % Define the frequency vector 
Fs = 1000 / (2*T); % Sampling frequency 
N = length(t); 
f = linspace(-Fs/2, Fs/2, N); % Frequency vector including negative frequencies 

plot(f, abs(X));

total_energy = sum(abs(X(N/2 : end)).^2); % Sum of squared magnitudes 
cumulative_energy = cumsum(abs(X(N/2 : end)).^2); % Cumulative sum of squared magnitudes 
cumulative_energy_normalized = cumulative_energy / total_energy; 

index_90 = find(cumulative_energy_normalized >= 0.9, 1, 'first'); 
frequency_90 = f(N/2 + index_90)