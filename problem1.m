% Mohamad Alikhani
clear;
clc;
close all;

dt = 0.01;
t = -3:dt:13;
f = exp(-0.5 * t.^2) + 0.1 * exp(-0.5 * (t - 10).^2);

figure
plot(t, f)
grid on

syms x;
f = exp(-0.5 * x^2) + 0.1 * exp(-0.5 * (x - 10)^2);

df = diff(f);
ddf = diff(df)
% Error margin
epsilon = 1e-4;

% set the initial condition
% We want to examine the effect of initial condition on the problem
x0 = [0.5 9.5];

% Create a deep copy because we want to compare the initial values
% And their corresponding answers!!!
% We store the minima in the minima array.
minima = repmat(x0, 1);

% Initialize Error (A Value bigger than error)
error = 0.1;

% NFE
iter = zeros(1, 2);
% We do this, we don't need to change the initial condition from 0.5 to 9.5
for i = 1:1:(size(x0) + 1)
    while error > epsilon
        iter(1, i) = iter(1, i) + 1;
        % Function at x0
        F = double(subs(df, x, minima(i)));
        % Derivative at x0
        G = double(subs(ddf, x, minima(i)));

        % Formula
        x_new = minima(i) - F/G;
        
        %Calculate Error
        error = abs(x_new - minima(i));
        % Store the new value inside minima
        minima(i) = x_new;
    end
    % Reset the error to a value that is bigger than epsilon
    error = 0.1;
    disp("The resulting minimum for initial value " + x0(i) + ", is f("...
        + minima(i) + ") = " + double(subs(f, x, minima(i))))
    disp("Number of iterations for the initial value x0 = " + x0(i) + ...
    " is " + iter(i))
    disp(" ")

end