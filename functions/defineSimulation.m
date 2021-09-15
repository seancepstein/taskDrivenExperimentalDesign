function simulation = defineSimulation(fig_number, tissue)

switch fig_number
    case 2
        % number of patients
        simulation.(tissue.name{1}).number = 25 * 1000;
        simulation.(tissue.name{2}).number = 22 * 1000;
        simulation.(tissue.name{3}).number = 21 * 1000;
    case 3
        % number of patients
        simulation.(tissue.name{1}).number = 11 * 1000;
        simulation.(tissue.name{2}).number = 17 * 1000;
        
    case {4,5}   
        % number of patients
        simulation.(tissue.name{1}).number = 25000;
        simulation.(tissue.name{2}).number = 25000;
        simulation.(tissue.name{3}).number = 25000;
        simulation.(tissue.name{4}).number = 25000;
     
        
end

end

