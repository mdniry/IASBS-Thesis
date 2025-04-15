% [Program Name], version 0.5
% Date: 14020207
% Copyleft 🄯 2023 by [author], all lefts are reserved!

clc

disp("[Program Name], version 0.5")
disp("Date 14020207")
disp("Copyleft 2023 by [author], all lefts are reserved!")

%---------- Constants ----------%
N      = 20;                           % Number of particles
alpha  = 0.5;                          % 0 < α < 1
eta    = 0.001;                        % η is viscosity; وشکسانی
                                       % (*@\rl{وشکسانی ویژگی سیال لزج است.}@*)
%-------------------------------%

x = alpha * ...                        % a comment ...
    (alpha - 1);

t = zeros(N, 1);                       % list of time scales
for i = 1 : N
    t(i) = i;
end
