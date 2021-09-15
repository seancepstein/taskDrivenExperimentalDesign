% Figure number to reproduce
% 2, 3, 4, or 5

fig_number = 2;

% Load pre-computed data? If false, run simulation from scratch
load_data = true;

if load_data
    switch fig_number
        case 2
            load fig_2.mat
        case 3
            load fig_3.mat
        case {4,5}
            load fig_4_5.mat
    end
else
    % tissue properties
    tissue = defineTissue(fig_number);
    % bval sampling scheme
    sampling = defineSampling(fig_number);
    % scanner settings
    scanner = defineScanner(fig_number);
    % fitting settings
    fitting = defineFitting(fig_number);
    % simulation settings
    simulation = defineSimulation(fig_number, tissue);
    % generate data
    data = generateData(tissue,sampling,scanner,simulation);
    results = [];
    for i = 1:tissue.number
        for j = 1:sampling.number
            for k = 1:scanner.number
                for l = 1:fitting.number
                    % fit each model in turn
                    switch fitting.name{l}
                        case 'ADC'
                            for m = 1:fitting.ADC.number
                                switch fitting.ADC.method{m}
                                    case 'wLS'
                                        % fit ADC using weighted linear least squares
                                        results = WLS_ADCfit(results,data,tissue,sampling,scanner,simulation,i,j,k);
                                end
                            end
                        case 'IVIM'
                            for m = 1:fitting.IVIM.number
                                switch fitting.IVIM.method{m}
                                    case 'sNLLS'
                                        % fit IVIM using sNLLS
                                        results = sNLLS_IVIMfit(results,data,tissue,sampling,scanner,fitting,simulation,i,j,k);
                                    case 'bcNLLS'
                                        % fit IVIM using bcNLLS
                                        results = bcNLLS_IVIMfit(results,data,tissue,sampling,scanner,fitting,simulation,i,j,k);
                                end
                            end
                    end
                end
            end
        end
    end
    
    % calculate ROC curves
    % TODO: document this function
    results = calculateROC(fig_number,results,sampling,scanner,tissue,simulation);
    
    clear i j k l m
    
end

% generate figures
plotFigures(fig_number, tissue, sampling, scanner, results, simulation, data)