function signal_noisy = addNoise(type,signal_clean,noise_level)
% [signal_noisy] = addNoise(type,signal_clean,noise_level)
%
% Author: Sean Epstein (rmapcep@ucl.ac.uk)
%
% Add noise to DWI signal
% 
% INPUTS:
% type - string, specifies the noise distribution, e.g. 'rician'
%
% signal_clean -    N x M, where N is the number of DWI sampling points
%              and M is the number of signal repeats, dimensionless
%
% noise_level - structure containing mean and standard deviation of the
% noise to be added: noise_level.mu and noise_level.sigma
%
% OUTPUTS:
% signal_noisy -    N x M, signal_clean with added noise

switch type
    case 'rician'
        real_channel = signal_clean + ...
            normrnd(noise_level.mu,noise_level.sigma,size(signal_clean));
        imag_channel = normrnd(noise_level.mu,noise_level.sigma,size(signal_clean));
        signal_noisy = sqrt(real_channel.^2 + imag_channel.^2);
    otherwise
        error('Noise model not defined')

end
end