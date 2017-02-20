% newRoster = ScoreOrder(rosterCSVFilename)
%   Creates a roster in score order out of one that is disordered
%   Uses the score order defined in GetOrderConfig.m
%
%   Saves the new roster into a new CSV file
%   New file has the name 'SCOREORDER_' + rosterCSVFilename
%
%   Returns a cell array representing the new roster
function newRoster = ScoreOrder(rosterCSVFilename)
    % Importing stuff
    roster = ImportRoster(rosterCSVFilename);
    rosterSize = size(roster);
    headers = roster(1,:);
    userScoreOrder = GetOrderConfig();
    
    % Which column has instrument information?
    [~, col] = find(strcmp('Instrument', headers));
    instrumentCol = roster(:,col);
    clear col
    
    % Can this be done in a more idiomatic MATLAB way?
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    % Preallocate memory for performance
    newRoster = cell(rosterSize);
    newRoster(1,:) = headers(1,:);
    workingRow = 1; % Pointer to the first empty row in newRoster
    for currentInstrument = 1:length(userScoreOrder)
        % Which rows contain the current instrument name?
        [rows, ~] = find(strcmp(userScoreOrder{currentInstrument}, instrumentCol));
        
        % Which rows in newRoster should be filled by this iteration?
        newRows = 1:length(rows);
        newRows = newRows' + workingRow;
        workingRow = workingRow + length(newRows);
        
        % Add those rows from the old roster to the new one.
        newRoster(newRows,:) = roster(rows,:);
    end
    
    % Write new roster to a new file
    % Consider testing to see if this filename already exists
    % If so, don't overwrite it
    newFilename = strcat('SCOREORDER_', rosterCSVFilename);
    fid = fopen(newFilename, 'w');
    clear row
    for row = 1:length(newRoster)
        fprintf(fid, '%s,', newRoster{row,1:end-1});
        fprintf(fid, '%s\n', newRoster{row,end});
    end
    fclose(fid);
end