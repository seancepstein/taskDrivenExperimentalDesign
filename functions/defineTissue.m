function tissue = defineTissue(fig_number)

switch fig_number
    case 2
        % names of each tissue being simulated
        tissue.name = { 'Active', 'Chronic', 'Control'};
        
        % number of tissues being simulated
        tissue.number = length(tissue.name);
        
        % generative model used to generate signal for each tissue
        tissue.(tissue.name{1}).model = 'IVIM';
        tissue.(tissue.name{2}).model = 'IVIM';
        tissue.(tissue.name{3}).model = 'IVIM';
        
        % IVIM parameters - tissue 1
        tissue.(tissue.name{1}).params.mu =    [1;...
            0.12; ...
            0.99; ...
            123.93];
        
        tissue.(tissue.name{1}).params.sigma = [0;...
            0.03; ...
            0.39; ...
            19.9];
        
        tissue.(tissue.name{1}).ROIsize.mu = 1;
        tissue.(tissue.name{1}).ROIsize.sigma = 0;
        
        % IVIM parameters - tissue 2
        tissue.(tissue.name{2}).params.mu =    [1;...
            0.12; ...
            0.35; ...
            124.7];
        
        tissue.(tissue.name{2}).params.sigma = [0;...
            0.02; ...
            0.11; ...
            13.68];
        
        tissue.(tissue.name{2}).ROIsize.mu = 1;
        tissue.(tissue.name{2}).ROIsize.sigma = 0;
        
        % IVIM parameters - tissue 3
        tissue.(tissue.name{3}).params.mu =    [1;...
            0.09; ...
            0.34; ...
            122.7];
        
        tissue.(tissue.name{3}).params.sigma = [0;...
            0.02; ...
            0.09; ...
            18.3];
        
        
        tissue.(tissue.name{3}).ROIsize.mu = 1;
        tissue.(tissue.name{3}).ROIsize.sigma = 0;
        
        % seed for generating tissue parameters
        tissue.seed = 34789;
        
        % threshold bval for two-step sNLLS fitting
        tissue.threshold = 0.199;
        
        % population means
        tissue.param_means = [1;...
            (0.12 + 0.12 + 0.09)/3;
            (0.99 + 0.35 + 0.34)/3;...
            (123.93 + 124.7 + 122.7)/3];
    case 3
        
        % names of each tissue being simulated
        tissue.name = { 'Inflamed', 'Control'};
        
        % number of tissues being simulated
        tissue.number = length(tissue.name);
        
        % generative model used to generate signal for each tissue
        tissue.(tissue.name{1}).model = 'IVIM';
        tissue.(tissue.name{2}).model = 'IVIM';
        
        % IVIM parameters - tissue 1
        tissue.(tissue.name{1}).params.mu =    [1;...
            0.0733; ...
            1.910; ...
            24.17];
        
        tissue.(tissue.name{1}).params.sigma = [0;...
            0.0777; ...
            0.5598; ...
            28.52];
        
        tissue.(tissue.name{1}).ROIsize.mu = 1;
        tissue.(tissue.name{1}).ROIsize.sigma = 0;
        
        % IVIM parameters - tissue 2
        tissue.(tissue.name{2}).params.mu =    [1;...
            0.0456; ...
            0.9158; ...
            44.59];
        
        tissue.(tissue.name{2}).params.sigma = [0;...
            0.0417; ...
            0.2602; ...
            35.21];
        
        tissue.(tissue.name{2}).ROIsize.mu = 1;
        tissue.(tissue.name{2}).ROIsize.sigma = 0;
        
        % seed for generating tissue parameters
        tissue.seed = 34789;
        
        % threshold bval for two-step sNLLS fitting
        tissue.threshold = 0.199;
        
        % population means
        tissue.param_means = [1;...
            (0.0733 + 0.0456)/2;
            (1.910 + 0.9158)/2;...
            (24.17 + 44.59)/2];
        
    case {4,5}
        
        % names of each tissue being simulated
        tissue.name = { 'Healthy', 'Chronic_1', 'Active','Chronic_2'};
        
        % number of tissues being simulated
        tissue.number = length(tissue.name);
        
        % generative model used to generate signal for each tissue
        tissue.(tissue.name{1}).model = 'IVIM';
        tissue.(tissue.name{2}).model = 'IVIM';
        tissue.(tissue.name{3}).model = 'IVIM';
        tissue.(tissue.name{4}).model = 'IVIM';
        
        % IVIM parameters - tissue 1
        tissue.(tissue.name{1}).params.mu =    [1;...
            0.09; ...
            0.35; ...
            123];
        
        tissue.(tissue.name{1}).params.sigma = [0;...
            0; ...
            0; ...
            0];
        
        tissue.(tissue.name{1}).ROIsize.mu = 1;
        tissue.(tissue.name{1}).ROIsize.sigma = 0;
        
        % IVIM parameters - tissue 2
        tissue.(tissue.name{2}).params.mu =    [1;...
            0.12; ...
            0.35; ...
            123];
        
        tissue.(tissue.name{2}).params.sigma = [0;...
            0; ...
            0; ...
            0];
        
        tissue.(tissue.name{2}).ROIsize.mu = 1;
        tissue.(tissue.name{2}).ROIsize.sigma = 0;
        
        % IVIM parameters - tissue 3
        tissue.(tissue.name{3}).params.mu =    [1;...
            0.12; ...
            0.60; ...
            123];
        
        tissue.(tissue.name{3}).params.sigma = [0;...
            0; ...
            0; ...
            0];
        
        
        tissue.(tissue.name{3}).ROIsize.mu = 1;
        tissue.(tissue.name{3}).ROIsize.sigma = 0;
        
        % IVIM parameters - tissue 4
        tissue.(tissue.name{4}).params.mu =    [1;...
            0.12; ...
            0.46; ...
            123];
        
        tissue.(tissue.name{4}).params.sigma = [0;...
            0; ...
            0; ...
            0];
        
        tissue.(tissue.name{4}).ROIsize.mu = 1;
        tissue.(tissue.name{4}).ROIsize.sigma = 0;
        
        % seed for generating tissue parameters
        tissue.seed = 34789;
        
        % threshold bval for two-step sNLLS fitting
        tissue.threshold = 0.05;
        
        % population means
        tissue.param_means = [1;...
            (0.09 + 0.12 + 0.12 + 0.12)/4;
            (0.35 + 0.35 + 0.60 + 0.46)/4;...
            123];
        
end

end

