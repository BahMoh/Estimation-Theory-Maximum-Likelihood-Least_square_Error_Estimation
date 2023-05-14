% Mohamad Alikhani
clc
clear;
close all
% Sampling time
Ts = 0.1;
% No. datapoints
n = 600;
% Number of parameters
q = 2;
P = 1*eye(q);
P1 = P;
A_1 = 3;
A_2 = 2;

theta_WRLS(:,1) = zeros(q,1);
theta_RLS(:,1) = zeros(q,1);
for k = 1:n
 
     % Signal & Measurement
     s(k) = A_1 * cos(15.9 * pi * k) + A_2 * sin(6.3 * pi * k);
     t(k) = k * Ts;
     % sqrt(9) corresponds to std = 3
     z(k) = s(k)+(sqrt(9))*randn(1,1);

     % LS
     Gama_LS(k,:) = [cos(15.9*pi*k) sin(6.3*pi*k)];
     Z(k,:) = z(k);

     gama = [cos(15.9 * pi * k) sin(6.3 * pi * k)];
     d1(k) = A_1;
     d2(k) = A_2; 
  
 
end
theta_LS = inv(Gama_LS' * Gama_LS) * Gama_LS' * Z

estimated_signal = zeros(1, n);
for k=1:n+1
    estimated_signal(k)=theta_LS(1)*cos(15.9*pi*k) + theta_LS(2)*sin(6.3*pi*k);
end
figure
plot(estimated_signal, 'r--')
hold on
plot(s)



