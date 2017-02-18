% ImportRoster(rosterCSVFilename)
%   Imports a CSV file from the given filename.
%   Filename should be given as a string.
%   CSV should include a column for instrument type.
%   (Should have column headers, with at least an "Instrument" header.)
%
%   Returns a cell array containing the contents of the roster CSV.

function output = ImportRoster(rosterCSVFilename)

fid = fopen(rosterCSVFilename);
% Read in data to a single column in a cell array
roster = textscan(fid, '%s', 'delimiter', ',');
roster = roster{1}; % Why do I have to do this?
% Reset pointer to beginning of data file
fid = fopen(rosterCSVFilename);
% Get number of newlines in the data file
newLines = textscan(fid, '%s', 'delimiter', '\n');
numRows = length(newLines{1}); % Convert numLines to int
% Close data file
fclose(fid);

% Figure out how many columns are actually in the data file
% Should be an integer...
numCols = length(roster) / numRows;
% Create a cell array with contents of roster CSV
% Use numRows and numCols to determine correct size
% Need to transpose after reshaping because of the way the file has
% been read into the roster array.
output = reshape(roster, numCols, numRows)';

end