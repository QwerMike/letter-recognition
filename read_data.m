TRAIN_DATA_PATH = 'data/train';
getfullpath = @(i, x) fullfile(TRAIN_DATA_PATH, num2str(i), x);
input = zeros(256,20,'double');
output = zeros(4, 20);
for i = 1:4
    files = dir(getfullpath(i, '*.bmp'));
    %u can use im2double
    mapfiles = @(x) im2double(rgb2gray(imread(getfullpath(i, x.name))));
    inputPart = arrayfun(@(x) reshape(mapfiles(x), 1, []), files, 'un', 0);
    input(:,5*i-4:5*i) = transpose(cell2mat(inputPart));
    %input = [input, transpose(cell2mat(inputPart))];
    %inputPart = arrayfun(@(x) reshape(x{1}, 1, []), inputPart, 'un', 0);
    
    output(i, 5*i - 4 : 5*i) = ones(1, 5);
end