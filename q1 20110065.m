data = readmatrix("hydrophone.csv");
v = data(:, 5);
t = data(:, 10);

% Now we have two possible approaches.

% t at first glance seems uniformly spaced. Assuming that:

ts = mean(diff(t));
fs = 1 / ts;

n = length(v);
V = fft(v);
f = (0:n-1)*(fs/n);

% Plot only the first half of the spectrum 
f = f(1:n/2+1); % First half of the frequency vector 
V = V(1:n/2+1); % First half of the Fourier Transform

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot(f, abs(V));
title('Magnitude Spectrum');
xlim([0,1e8]);
ylim([0, 0.5]);   % optional to resize axis limits
xlabel('f');
ylabel('V_m');

box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');

% Set the remaining axes properties
set(axes1,'GridAlpha',0.5,'MinorGridAlpha',0.4,'XMinorGrid','on')

set(gca,'FontSize',12)

figure2 = figure;
axes2 = axes('Parent',figure2);
hold(axes2,'on');
scatter(f, angle(V))
title('Phase Spectrum');
xlim([0,5e7]);
% ylim([0, 50]);   % optional to resize axis limits
xlabel('f');
ylabel('V_\theta');

box(axes2,'on');
grid(axes2,'on');
hold(axes2,'off');

% Set the remaining axes properties
set(axes2,'GridAlpha',0.5,'MinorGridAlpha',0.4,'XMinorGrid','on')

set(gca,'FontSize',12)

btIdx = find(f <= 2500000, 1, 'last'); % exclude the initial low frequencies that have abnormally high amplitudes

Vm = abs(V(btIdx:end));
[max_mag, max_idx] = max(Vm);

db_level = max_mag * 10^(-0.3);

lower_idx = find(Vm(1:max_idx) <= db_level, 1, 'last'); 
upper_idx = find(Vm(max_idx:end) <= db_level, 1, 'first') + max_idx - 1;

lower_frequency = f(lower_idx + btIdx); 
upper_frequency = f(upper_idx + btIdx);

bandwidth = upper_frequency - lower_frequency