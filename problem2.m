% Mohamad Alikhani
clc;
clear;
close all;

N = 200;
% column vector
x = zeros(N, 1);

% We want N samples
% fi is the frequency!
for n = 1:1:N
    % Samples are made up of different cosine's with different frequencies
    for fi = [5 10 15 20]
        x(n) = x(n) + cos(fi*n);
    end
    % Add gaussian noise to it
    x(n) = x(n) + sqrt(1) * randn(1);
end
% Plot the observation vector
plot(x)

%%Expectation-Maximization
% symbolic functions
% Cause the frequency is unknown we use the symbole f
syms f
% We start from zero because of formula
n =(0:1:N-1)';
ci = cos(n*f);

% Start from 2nd element
for i = 2:1:N
    dU_sym(i,1) = gradient(ci(i));
end

%We Can replace this with the below line
% dU_sym = diff(ci)

Bi = 0.25;
% Initial values for frequencies
freqs = [3.4 7.9 13 19];
f1=3.4;

yh1 = zeros(N, 1);
U = zeros(N, 1);
dU = zeros(N, 1);
for n = 1:1:N
    for f1 = [3.4 7.9 13 19]
        sigma = cos(f1*n);
        yh1(n, 1) = yh1(n, 1) + cos(f1*n) + Bi * (x(n) - sigma);
        U(n, 1) =U(n, 1) + double(subs(ci, f, f1))'*yh1;
        dU(n, 1) = dU(n, 1) + double(subs(dU_sym, f, f1))'*yh1;
    end
end
% for n = 1:1:N*2
%     for f1 = freqs
%         sigma = cos(f1*n);
% 
%         yh1 = cos(f1*n) + Bi * (x - sigma);
% 
%         U = double(subs(ci, f, f1))'*yh1;
%         dU = double(subs(dU_sym, f, f1))'*yh1;
%     end
% end
    