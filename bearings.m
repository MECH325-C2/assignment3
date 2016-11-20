function [ outputArguments ] = bearings( axialForce, radialForce, designLife, rotationalSpeed, K )

%{
Application-spesific variables:
axialForce F_a
radialForce F_r

designLife L_D
rotationalSpeed n_D [rev/min]

Bearings-spesific variables:
K_A - geometry factor,  initial guess is 1.5
K_B ?

%}

% Constants 
a = 10/3; % for roller bearings in general
V = 1 % as inner race rotates
applicationFactor = 3; % a_f (see table 11-5), ASSUMPTION of machinery with moderate impact

% Values used by Timken manufacturer (see top of page 590)
x_0 = 0;        % guaranteed life
b = 3/2;        % shape parameter
theta = 4.48;   % scale parameter



%% Bearing calculations, using tapered roller bearings
% See example 11-8

% As this bearing is alone, it carries the net thrust load
F_e = 0.4 * radialForce + K * axialForce;   % N, dynamic equivalent load. eq. 11-19

L_D = designLife * rotationalSpeed * 60;    % 
L_R = 90*10^6;                              % 

x_D = L_D / L_R;    % multiple of rating life

R_D = sqrt(0.99);   % estimated for each bearing



C_10 = applicationFactor * F_e * (x_D/(x_0+(theta-x_0)*(1-R_D)^(1/b)))^(1/a); % eq 11-10, caltaloge entry C_10 should equal or exceed this value

display(C_10);

end
