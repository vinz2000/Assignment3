%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Users\vince\Desktop\tudelft\physics\Assignment3\gravity.txt
%
% Auto-generated by MATLAB on 15-Jun-2023 17:14:09

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 6);

% Specify range and delimiter
opts.DataLines = [2, 6561]; %till 80 degrees
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["E04", "E05", "E03", "VarName4", "Var5", "Var6"];
opts.SelectedVariableNames = ["E04", "E05", "E03", "VarName4"];
opts.VariableTypes = ["double", "double", "double", "double", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var5", "Var6"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var5", "Var6"], "EmptyFieldRule", "auto");

% Import the data
gravity = readtable("C:\Users\vince\Desktop\tudelft\physics\Assignment3\gravity.txt", opts);

%% Convert to output type
gravity = table2array(gravity);

%% Clear temporary variables
clear opts
gravity=sortrows(gravity,2);
gravity=gravity(454:4544,:);
V = [gravity(:,1) gravity(:,2) gravity(:,3) gravity(:,4)];
V = [0 0 1 0; V];
V(1,3)=0;
V(3,3)=0;
sc_2=vecml2sc(gravity(:,3), gravity(:,4), 110);
save(['V.mat'],'V')
