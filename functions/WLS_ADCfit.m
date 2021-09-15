function results = WLS_ADCfit(results,data,tissue,sampling,scanner,simulation,idx_tissue,idx_sampling,idx_scanner)
% [results] = WLS_ADCfit(results,data,tissue,sampling,scanner,simulation,idx_tissue,idx_sampling,idx_scanner)
% Author: Sean Epstein (rmapcep@ucl.ac.uk)
%
% Fit ADC model to DWI data using weighted least squares
% 
% INPUTS:
% results - structure, contains the output of the fitting process
%
% data - structure, contains input data - the signal to fit
%
% tissue - structure, contains information on tissue being simulated, e.g.
% generative parameters
%
% sampling - structure, contains information on sampling scheme being used,
% e.g. b values
%
% scanner - structure, contains information about scanner e.g. noise
%
% simulation - structure, contains information about simulation, e.g.
% number of repeats
%
% idx_tissue - index relating to the tissue type being fit
%
% idx_sampling - index relating to the sampling method being fit
%
% idx_scanner - index relating to the scanning setup being fit
%
% OUTPUTS:
% results - structure containing fitting output


%% set up fitting

% allocate memory for weighted least squares coefficients
coefficients = NaN(2,simulation.(tissue.name{idx_tissue}).number);

%% perform fitting
tic
for m = 1:simulation.(tissue.name{idx_tissue}).number
    
    % noisy signal
    signal_noisy = data.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(sprintf('ROI_%d', m)).(scanner.name{idx_scanner}).signal_noisy;
    
    % diffusion weighting b-values
    bvals = data.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(sprintf('ROI_%d', m)).bvals;
    
    % number of b-values
    nbvals = length(bvals);
    
    % generate design matrix for linear fitting
    designMatrix = ...
    [bvals,ones(nbvals,1)];

    % first pass: non-weighted least squares
    coefficients_nonweighted = ...
        lscov(designMatrix,...
        log(signal_noisy),...
        ones(size(signal_noisy)));
    
    % estimate noise-free signal
    signal_estimate = exp(coefficients_nonweighted(2)) * exp(-bvals * -coefficients_nonweighted(1));
    
    % compute weighted least squares, using weight = S^2, see https://pubmed.ncbi.nlm.nih.gov/16828568/
    coefficients(:,m) = ...
        lscov(designMatrix,...
        log(signal_noisy),...
        signal_estimate.^2);
end
time_per_fit = toc / simulation.(tissue.name{idx_tissue}).number;
%% save fitting results
% time taken per fit
results.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(scanner.name{idx_scanner}).ADC.wLS.time_per_fit = time_per_fit;

% WLS coefficients
results.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(scanner.name{idx_scanner}).ADC.wLS.coefficients = coefficients;

% ADC parameters from WLS coefficients
results.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(scanner.name{idx_scanner}).ADC.wLS.parameters = ...
    [exp(coefficients(2,:)); ...
    -coefficients(1,:)];

end