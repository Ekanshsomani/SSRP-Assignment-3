fs = 100;
t = 0:1/fs : 10 - 1/fs;
x = exp(-2 .* t);
X = fftshift(fft(x));

% Define Frequency Vector
N = length(X);
f = (-N/2: (N-1)/2) * (2*fs / N);

% Overlay with Magnitude Spectrum
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot(f, abs(X));

title('Amplitude Spectrum')
xlabel('f');
ylabel('X_m');

% Set the remaining axes properties
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
set(axes1,'GridAlpha',0.5,'MinorGridAlpha',0.4,'XMinorGrid','on')
set(gca,'FontSize',12)

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
scatter(f, angle(X));

title('Phase Spectrum')
% xlim([0,10]);
% ylim([0, 0.5]);   % optional to resize axis limits
xlabel('f');
ylabel('\theta');

% Set the remaining axes properties
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
set(axes1,'GridAlpha',0.5,'MinorGridAlpha',0.4,'XMinorGrid','on')
set(gca,'FontSize',12)

