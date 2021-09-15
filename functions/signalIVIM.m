function signal = signalIVIM(parameters, bvalues)

% [signal] = signalIVIM(parameters, bvalues)
%
% Author: Sean Epstein (rmapcep@ucl.ac.uk)
%
% Generate DWI signal from the IVIM diffusion model
% 
% INPUTS:
% parameters - 4 x M array, where M is the number of combinations of
%              IVIM model parameters:
%              parameters(1,:) = S0, normalisation, dimensionless
%              parameters(2,:) = fp, perfusion fraction, dimensionless
%              parameters(3,:) = Dt, tissue diffusivity, 10^-3 mm^2 s^-1
%              parameters(4,:) = Dp, perfusion diffusivity, 10^-3 mm^2 s^-1
%
% bvalues -    N x 1, where N is the number of DWI sampling points:
%              diffusion weighting, s mm^-2
%
% OUTPUTS:
% signal -     N x M, where N is the number of DWI sampling points:
%              diffusion weighted signal, dimensionless

S0 = parameters(1,:);
fp = parameters(2,:);
Dt = parameters(3,:);
Dp = parameters(4,:);

signal = S0 .* (fp .*exp(-bvalues .* (Dt + Dp)) + (1-fp) .* exp(-bvalues .* Dt));

end