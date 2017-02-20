clear; close all; clc

scoreFile = 'sample_data.csv';

fprintf('Sample unordered roster: \n\n')
roster = ImportRoster(scoreFile);
disp(roster)

fprintf('Sample score order: \n\n')
order = GetOrderConfig();
disp(order)

fprintf('New, score-ordered roster: \n\n')
newRoster = ScoreOrder(scoreFile);
disp(newRoster)


