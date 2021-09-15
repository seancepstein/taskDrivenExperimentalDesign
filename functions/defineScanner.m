function scanner = defineScanner(fig_number)

switch fig_number
    case 2
        % names of scanner settings
        scanner.name = {'Adjusted'};
        
        % number of scanner settings
        scanner.number = length(scanner.name);
        
        % noise associated with scan settings, normalised to 1
        scanner.(scanner.name{1}).noise.SNR = 150.6;
        scanner.(scanner.name{1}).noise.mu = 0;
        scanner.(scanner.name{1}).noise.sigma = 1/scanner.(scanner.name{1}).noise.SNR;
        scanner.(scanner.name{1}).noise.type = 'rician';
        
        % seed for generating noise
        scanner.seed = 27893;
    case 3
        
        % names of scanner settings
        scanner.name = {'Empirical'};
        
        % number of scanner settings
        scanner.number = length(scanner.name);
        
        % noise associated with scan settings, normalised to 1
        scanner.(scanner.name{1}).noise.SNR = 56.31;
        scanner.(scanner.name{1}).noise.mu = 0;
        scanner.(scanner.name{1}).noise.sigma = 1/scanner.(scanner.name{1}).noise.SNR;
        scanner.(scanner.name{1}).noise.type = 'rician';
        
        % seed for generating noise
        scanner.seed = 27893;
        
    case {4,5}
        
        % names of scanner settings
        scanner.name = {'Synthetic'};
        
        % number of scanner settings
        scanner.number = length(scanner.name);
        
        scanner.SNR_norm = 20 * sqrt(9/14);
        
        % noise associated with scan settings, normalised to 1
        scanner.(scanner.name{1}).noise.SNR = 20;
        scanner.(scanner.name{1}).noise.mu = 0;
        scanner.(scanner.name{1}).noise.sigma = 1/scanner.(scanner.name{1}).noise.SNR;
        scanner.(scanner.name{1}).noise.type = 'rician';
        
        % seed for generating noise
        scanner.seed = 27893;
        
end

end

