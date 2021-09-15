function results = bcNLLS_IVIMfit(results,data,tissue,sampling,scanner,fitting,simulation,idx_tissue,idx_sampling,idx_scanner)
% [results] = bcNLLS_IVIMfit(results,data,tissue,sampling,scanner,fitting,simulation,idx_tissue,idx_sampling,idx_scanner)
% Author: Sean Epstein (rmapcep@ucl.ac.uk)
%
% Fit IVIM model to DWI data using bound-constrained NLLS
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
% fitting - structure, contains information about fitting method, e.g.
% whether S0 is fit or fixed
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

% s0 fitting flag
s0_fit = fitting.IVIM.s0_fit;

% allocate memory for bcNLLS fitted parameters
parameters_bcNLLS = NaN(4,simulation.(tissue.name{idx_tissue}).number);

% NLLS fitting loss function
fmincon_loss_bcNLLS = NaN(1,simulation.(tissue.name{idx_tissue}).number);

if s0_fit
    fitting.IVIM.NLLS.lb = fitting.IVIM.NLLS.lb([1 2 3 4]);
    fitting.IVIM.NLLS.ub = fitting.IVIM.NLLS.ub([1 2 3 4]);
else
    fitting.IVIM.NLLS.lb = fitting.IVIM.NLLS.lb([2 3 4]);
    fitting.IVIM.NLLS.ub = fitting.IVIM.NLLS.ub([2 3 4]);
end

%% perform fitting
tic
for m = 1:simulation.(tissue.name{idx_tissue}).number
    
    % noisy signal
    signal_noisy = data.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(sprintf('ROI_%d', m)).(scanner.name{idx_scanner}).signal_noisy;

    % diffusion weighting b-values
    bvals = data.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(sprintf('ROI_%d', m)).bvals;
    
    
    % set seed and fixed parameters for NLLS
    switch fitting.IVIM.seed
        case 'groundtruth' % seed NLLS with generative parameters
            if  s0_fit
                % seed with groundtruth parameters
                seed = data.(tissue.name{idx_tissue}).params([1 2 3 4],m);
                % do not fix any parameters
                params_fix = [];
            else
                % seed with groundtruth parameters
                seed = data.(tissue.name{idx_tissue}).params([2 3 4],m);
                % set S0 to S(b=0)
                parameters_bcNLLS(1,m) = mean(signal_noisy(bvals == 0));
                % fix S0 from S(b=0)
                params_fix = [parameters_bcNLLS(1,m)];
            end
            
        case 'mean' % seed NLLS with mean tissue parameters
            if  s0_fit
                % seed with mean tissue parameters
                seed = tissue.(tissue.name{idx_tissue}).params.mu([1 2 3 4]);
                % do not fix any parameters
                params_fix = [];
            else
                % seed with mean tissue parameters
                seed = tissue.(tissue.name{idx_tissue}).params.mu([2 3 4]);
                % set S0 to S(b=0)
                parameters_bcNLLS(1,m) = mean(signal_noisy(bvals == 0));
                % fix S0 from S(b=0)
                params_fix = [parameters_bcNLLS(1,m)];
            end
            
        case 'mean_blind' % seed NLLS with mean tissue parameters
            if  s0_fit
                % seed with mean tissue parameters
                seed = tissue.param_means([1 2 3 4]);
                % fix Dt from linear fitting
                params_fix = [];
            else
                % seed with mean tissue parameters
                seed = tissue.param_means([2 3 4]);
                % set S0 to S(b=0)
                parameters_sNLLS(1,m) = mean(signal_noisy(bvals == 0));
                % fix S0 from S(b=0) and Dt from linear fitting
                params_fix = [parameters_sNLLS(1,m)];
            end
            
        otherwise
            error('NLLS seeding must be either ''mean'', ''mean_blind'', or ''groundtruth''')
    end
    
    % finish setting up fmincon problem
    fitting.IVIM.NLLS.x0 = seed;
    fitting.IVIM.NLLS.objective = @(params_fit) bcNLLS_sse(params_fit,params_fix,bvals,signal_noisy,s0_fit);   
    
    % perform fmincon fit
    [params_NLLS_fit, fmincon_loss_bcNLLS(1,m)] = fmincon(fitting.IVIM.NLLS);
    
    % combine fitted parameters
    if s0_fit
        % S0, fp, Dt, Dp
        parameters_bcNLLS(:,m) = params_NLLS_fit;
    else
        % fp, Dt, Dp
        parameters_bcNLLS(2:4,m) = params_NLLS_fit;
    end
end

% time taken for bcNLLS fitting
time_per_fit = toc/simulation.(tissue.name{idx_tissue}).number;

%% save fitted parameters and loss function to results structure
% time taken per fit
results.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(scanner.name{idx_scanner}).IVIM.bcNLLS.time_per_fit = time_per_fit;

% bcNLLS parameters
results.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(scanner.name{idx_scanner}).IVIM.bcNLLS.parameters = ...
    parameters_bcNLLS;

% NLLS loss function
results.(tissue.name{idx_tissue}).(sampling.name{idx_sampling}).(scanner.name{idx_scanner}).IVIM.bcNLLS.loss_NLLS = ...
    fmincon_loss_bcNLLS;
end