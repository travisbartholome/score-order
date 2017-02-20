clear; close all; clc

fprintf('Sample Roster: \n\n')
roster = ImportRoster('sample_data.csv');
disp(roster)

fprintf('Sample score order: \n\n')
order = GetOrderConfig();
disp(order)



