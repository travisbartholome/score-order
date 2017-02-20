% newRoster = ScoreOrder(rosterCSVFilename)
%   Creates a roster in score order out of one that is disordered
%   Returns a cell array representing the new roster
%   Uses the score order defined in GetOrderConfig.m
function newRoster = ScoreOrder(rosterCSVFilename)
    % Importing stuff
    roster = ImportRoster(rosterCSVFilename);
    rosterSize = size(roster);
    headers = roster(1,:);
    score_order = GetOrderConfig();
    
    % Which column has instrument information?
    [~, col] = find(strcmp('Instrument', headers));
    instrumentCol = roster(:,col);
    clear col
    
    % Can this be done in a more idiomatic MATLAB way?
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    % Preallocate memory for performance
    newRoster = cell(rosterSize);
    newRoster(1,:) = headers(1,:);
    disp(newRoster)
    working_row = 1; % Pointer to the first empty row in newRoster
    for current_instrument = 1:length(score_order)
        % Which rows contain the current instrument name?
        [rows, ~] = find(strcmp(score_order{current_instrument}, instrumentCol));
        
        % Which rows in newRoster should be filled by this iteration?
        new_rows = 1:length(rows);
        new_rows = new_rows' + working_row;
        working_row = working_row + length(new_rows);
        
        % Add those rows from the old roster to the new one.
        newRoster(new_rows,:) = roster(rows,:);
    end
end