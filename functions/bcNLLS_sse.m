function sse = bcNLLS_sse(params_FIT,params_SET,bvals,measured_signal,s0_fit)
% [sse] = = bcNLLS_sse(params_FIT,params_SET,bvals,measured_signal,s0_fit)
%
% Author: Sean Epstein (rmapcep@ucl.ac.uk)
%
% Sum of square errors cost function for bound-constrained NLLS IVIM fitting
% 
% INPUTS:
% params_FIT - 2-tuple or 3-tuple. if s0_fit = true, params_FIT is 
%       a 3-tuple and params_FIT(1) = S0, params_FIT(2) = fp, 
%       params_FIT(3) = Dp; otherwise params_FIT is a 2-tuple and 
%       params_FIT(1) = fp, params_FIT(2) = Dp
%
% params_SET - 1-tuple or 2-tuple. if s0_fit = true, params_SET is a
%       1-tuple and params_FIT(1) = Dt; otherwise params_SET is a 2-tuple  
%       and params_FIT(1) = S0; params_FIT(2) = Dt
%
% bvals - N x 1, where N is the number of DWI sampling points:
%         diffusion weighting, s mm^-2
%
% measured signal - N x 1, where N is the number of DWI sampling points:
%                  measured diffusion weighted signal, dimensionless
%
% s0_fit - boolean, determines whether s0 is explictly estimated
%
% OUTPUTS:
% signal_noisy -    N x M, signal_clean with added noise

if s0_fit
    S0 = params_FIT(1,:);
    fp = params_FIT(2,:);
    Dt = params_FIT(3,:);
    Dp = params_FIT(4,:);

else
    fp = params_FIT(1,:);
    Dt = params_FIT(2,:);
    Dp = params_FIT(3,:);
    
    S0 = params_SET(1,:);
end

estimated_signal =  S0 .* (fp .*exp(-bvals .* (Dt + Dp)) + (1-fp) .* exp(-bvals .* Dt));
sse = sum((estimated_signal - measured_signal).^2);
end