# Task-driven assessment of experimental designs in diffusion MRI: a computational framework

This code reproduces the data and figures included in *Task-driven assessment of experimental designs in diffusion MRI: a computational framework*, Sean C. Epstein, Timothy J.P. Bray, Margaret A. Hall-Craggs, and Hui Zhang

## Software requirements

[Matlab](http://mathworks.com), code tested on build 2020b.

## Running the code

1. Clone this repository into your local machine. Ensure that the repository's root directory is set as your current Matlab folder and all subfolders are added to your Matlab path.
1. Run `taskDriven_reproduce.m`
    1. By default, this will produce figures from pre-computed data. To generate data from scratch, adjust line 7 of `taskDriven_reproduce.m` to `load_data = false;` 
    1. By default, this will reproduce Figure 2. Adjust line 4 of `taskDriven_reproduce.m` to `fig_number = 2;`, `3;`, `4;`, or `5;` as required.