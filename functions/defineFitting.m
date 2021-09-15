function fitting = defineFitting(fig_number)

switch fig_number
    case 2
        % number of models to fit to data
        fitting.number = 1;
        fitting.name = {'IVIM'};
        
        % number of IVIM fitting methods
        fitting.IVIM.number = 1;
        
        % name of IVIM fitting methods
        fitting.IVIM.method = {'sNLLS'};
        
        % IVIM s0 fitting flag - whether s0 is fit or obtained from s(b=0)
        fitting.IVIM.s0_fit = false;
        
        % set NLLS fitting options for fmincon
        fitting.IVIM.NLLS.options = optimoptions('fmincon', 'Algorithm', 'sqp','Display','off');
        fitting.IVIM.NLLS.solver = 'fmincon';
        
        % set upper and lower bounds for NLLS fitting
        fitting.IVIM.NLLS.lb = [0; 0; 0; 0];
        fitting.IVIM.NLLS.ub = [2; 1; 10; 500];
        
        % set whether NLLS fit is seeded with 'groundtruth' generative parameters
        % or 'mean' tissue parameters
        fitting.IVIM.seed = 'mean_blind';
    case 3
        % number of models to fit to data
        fitting.number = 2;
        fitting.name = {'ADC','IVIM'};
        
        % number of ADC fitting methods
        fitting.ADC.number = 1;
        
        % name of ADC fitting methods
        fitting.ADC.method = {'wLS'};
        
        % number of IVIM fitting methods
        fitting.IVIM.number = 1;
        
        % name of IVIM fitting methods
        fitting.IVIM.method = {'bcNLLS'};
        
        % IVIM s0 fitting flag - whether s0 is fit or obtained from s(b=0)
        fitting.IVIM.s0_fit = false;
        
        % set NLLS fitting options for fmincon
        fitting.IVIM.NLLS.options = optimoptions('fmincon', 'Algorithm', 'sqp','Display','off');
        fitting.IVIM.NLLS.solver = 'fmincon';
        
        % set upper and lower bounds for NLLS fitting
        fitting.IVIM.NLLS.lb = [0; 0; 0; 0];
        fitting.IVIM.NLLS.ub = [2; 1; 10; 500];
        
        % set whether NLLS fit is seeded with 'groundtruth' generative parameters
        % or 'mean' tissue parameters
        fitting.IVIM.seed = 'mean_blind';
        
    case {4,5}
        
        % number of models to fit to data
        fitting.number = 2;
        fitting.name = {'ADC','IVIM'};
        
        % number of ADC fitting methods
        fitting.ADC.number = 1;
        
        % name of ADC fitting methods
        fitting.ADC.method = {'wLS'};
        
        % number of IVIM fitting methods
        fitting.IVIM.number = 2;
        
        % name of IVIM fitting methods
        fitting.IVIM.method = {'sNLLS','bcNLLS'};
        
        % IVIM s0 fitting flag - whether s0 is fit or obtained from s(b=0)
        fitting.IVIM.s0_fit = false;
        
        % set NLLS fitting options for fmincon
        fitting.IVIM.NLLS.options = optimoptions('fmincon', 'Algorithm', 'sqp','Display','off');
        fitting.IVIM.NLLS.solver = 'fmincon';
        
        % set upper and lower bounds for NLLS fitting
        fitting.IVIM.NLLS.lb = [0; 0; 0; 0];
        fitting.IVIM.NLLS.ub = [2; 1; 10; 500];
        
        % set whether NLLS fit is seeded with 'groundtruth' generative parameters
        % or 'mean' tissue parameters
        fitting.IVIM.seed = 'mean_blind';
        
end

end

