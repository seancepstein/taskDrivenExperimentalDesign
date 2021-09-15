function sampling = defineSampling(fig_number)

switch fig_number
    case 2
        % names of each sampling scheme
        sampling.name = {'Ten'};
        
        % number of sampling schemes
        sampling.number = length(sampling.name);
        
        % bvalues of each sampling scheme
        sampling.(sampling.name{1}).bvals = 1e-3*[0, 10, 20, 30, 50, 80, 100, 200, 400, 800]';
        
        % length of each sampling scheme
        sampling.(sampling.name{1}).nbvals = length(sampling.(sampling.name{1}).bvals);
    case 3
        % names of each sampling scheme
        sampling.name = {'Five'};
        
        % number of sampling schemes
        sampling.number = length(sampling.name);
        
        % bvalues of each sampling scheme
        sampling.(sampling.name{1}).bvals = 1e-3*[0, 50, 100, 300, 600]';
        
        % length of each sampling scheme
        sampling.(sampling.name{1}).nbvals = length(sampling.(sampling.name{1}).bvals);
        
    case {4,5}
        
        % names of each sampling scheme
        sampling.name = {'Nine'};
        
        % number of sampling schemes
        sampling.number = length(sampling.name);
        
        % bvalues of each sampling scheme
        sampling.(sampling.name{1}).bvals = 1e-3*[0, 10, 20, 40, 80, 100, 200, 400, 600]';
        
        % length of each sampling scheme
        sampling.(sampling.name{1}).nbvals = length(sampling.(sampling.name{1}).bvals);
        
end

end

