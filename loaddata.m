function [ input, output ] = loaddata( folder )

tbl = readtable(fullfile(folder, 'filenames.txt'));
input = zeros(256, height(tbl));
output = zeros(4, height(tbl));
for i = 1:height(tbl)
    input(:, i) = reshape( ...
        im2double(rgb2gray(imread(fullfile(folder, tbl{i,2}{1})))), ...
                  1, []);
    output(tbl{i,1}, i) = 1;
end
end