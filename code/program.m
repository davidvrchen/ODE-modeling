% This is non-dimensionalized, so s, i, r, n, should be multiplied by N
% to get the actual values.

% Define constants
d = 1;
c = 2;
l = 2;

% Non-dimensionalize constants
gamma = c * d;
lambda = l * d;
s0 = 0.95;
i0 = 0.025;
r0 = 0.025;
n0 = s0 + i0 + r0;


% Define functions
%syms s(t) i(t) r(t)

% Define system
%ds = diff(s) == -gamma * s * i + lambda * r;
%di = diff(i) == gamma * s * i - i;
%dr = diff(r) == i - lambda * r;

%system = [ds di dr];
%initial = [n 0 0];

% Convert to Matlab function
%[V, S] = odeToVectorField(system);
%M = matlabFunction(V,'vars',{'t','Y'});

V = @(t,x)[-gamma * x(1) * x(2) + lambda * x(3);
    gamma * x(1) * x(2) - x(2);
    x(2) - lambda * x(3)];

% Endemic solution
% C = ((gamma-1)/(gamma * (lambda+1)));
% V0 = [1/gamma; lambda*C; C];

% Regular solution
V0 = [s0; i0; r0];

[T,Z] = ode45(V, [0 10], V0);

s = Z(:,1);
i = Z(:,2);
r = Z(:,3);

%f1 = fit(T, s, 'poly9');             % fit Rat23 model into y(t) data
%f2 = fit(T, i, 'poly9');             % fit Rat33 model into z(t) data
%f3 = fit(T, r, 'poly9');             % fit Rat33 model into z(t) data

%subplot(2, 2, 1)
%plot(T,s)
%subplot(2, 2, 2)
%plot(T, i)
%subplot(2, 2, 3)
%plot(T, r)
%subplot(2, 2, 4)
plot(T, s, "LineWidth", 2)
hold on;
plot(T, i, "LineWidth", 2)
plot(T, r, "LineWidth", 2)
legend('s', 'i', 'r');
xlabel('Non-dimensionalized time');
ylabel('Non-dimensionalized population');

saveas(gcf, sprintf("short ts s=%02d, i=%02d, r=%02d, l=%02d g=%02d.pdf", s0, i0, r0, lambda, gamma))

% Solve on interval
%interval = [0 20];
%ySol = ode45(M,interval,initial);

% Plot solutions
%tValues = linspace(0,20,100);
%yValues = deval(ySol,tValues,1);
%plot(tValues,yValues)
%hold on;
%yValues1 = deval(ySol,tValues,2);
%plot(tValues,yValues1)
%yValues2 = deval(ySol,tValues,3);
%plot(tValues,yValues2)
%legend('s', 'i', 'r');

