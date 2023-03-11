% This is non-dimensionalized, so s, i, r, n, should be multiplied by N
% to get the actual values.

% Define constants
gamma = 1; 
lambda = 1;
n = 1;

% Define functions
syms s(t) i(t) r(t)

% Define system
ds = diff(s) == -gamma * s * i + lambda * r;
di = diff(i) == gamma * s * i - i;
dr = diff(r) == i - lambda * r;

system = [ds di dr];
initial = [n 0 0];

% Convert to Matlab function
[V, S] = odeToVectorField(system);
M = matlabFunction(V,'vars',{'t','Y'});

% Solve on interval
interval = [0 20];
ySol = ode45(M,interval,initial);

% Plot solutions
tValues = linspace(0,20,100);
yValues = deval(ySol,tValues,1);
plot(tValues,yValues)
hold on;
yValues1 = deval(ySol,tValues,2);
plot(tValues,yValues1)
yValues2 = deval(ySol,tValues,3);
plot(tValues,yValues2)
legend('s', 'i', 'r');

