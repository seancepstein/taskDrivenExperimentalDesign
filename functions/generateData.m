function data = generateData(tissue,sampling,scanner,simulation)
% [data] = generateData(tissue,sampling,scanner)
%
% Author: Sean Epstein (rmapcep@ucl.ac.uk)
%
% Generate DWI data from tissue, sampling, and scanner properties
%
% INPUTS:
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
% OUTPUTS:
% data - structure containing parameters, clean, and noisy DWI signal

% seed random number generator for parameter generation
rng(tissue.seed)

%% generate noise-free signal for each patient
% iterate over each tissue
for i = 1:tissue.number
    % generate parameters for each patient
    params = repmat(tissue.(tissue.name{i}).params.mu,1,simulation.(tissue.name{i}).number)...
        + randn(4,simulation.(tissue.name{i}).number).*...
        repmat(tissue.(tissue.name{i}).params.sigma,1,simulation.(tissue.name{i}).number);
    
    % ensure generated parameters are >= 0
    data.(tissue.name{i}).params = max(params,zeros(size(params)));
    
    % iterate over sampling schemes
    for j = 1:sampling.number
        % iterate over patients
        for k = 1:simulation.(tissue.name{i}).number
            
            % compute ROI size for each patient
            data.(tissue.name{i}).(sampling.name{j}).(sprintf('ROI_%d', k)).ROI_size = ...
                max(round(normrnd(tissue.(tissue.name{i}).ROIsize.mu,...
                tissue.(tissue.name{i}).ROIsize.sigma)),1);
            
            % compute number of sampling points, based on ROI size
            data.(tissue.name{i}).(sampling.name{j}).(sprintf('ROI_%d', k)).bvals = ...
                repmat(sampling.(sampling.name{j}).bvals,...
                data.(tissue.name{i}).(sampling.name{j}).(sprintf('ROI_%d', k)).ROI_size,...
                1);
            
            % generate noisefree signal for each set of parameters
            data.(tissue.name{i}).(sampling.name{j}).(sprintf('ROI_%d', k)).signal_clean = ...
                signalIVIM(data.(tissue.name{i}).params(:,k),...
                data.(tissue.name{i}).(sampling.name{j}).(sprintf('ROI_%d', k)).bvals);
        end
        
    end
end

%% add noise to noise-free signal
% seed random number generator for noise addition
rng(scanner.seed)
% iterate over tissues
for i = 1:tissue.number
    % iterate over sampling schemes
    for j = 1:sampling.number
        % iterate over patients
        for k = 1:simulation.(tissue.name{i}).number
            % iterate over scanner settings
            for l = 1:scanner.number
            data.(tissue.name{i}).(sampling.name{j}).(sprintf('ROI_%d', k)).(scanner.name{l}).signal_noisy = ...
                addNoise(...
                scanner.(scanner.name{l}).noise.type,...
                data.(tissue.name{i}).(sampling.name{j}).(sprintf('ROI_%d', k)).signal_clean,...
                scanner.(scanner.name{l}).noise);
            end    
        end
    end
end


end