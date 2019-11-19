%DIP19 Assignment 3
%Character Recongnition

clc; clear all;
path = ('../asset/image/example.png');
imgInput = imread(path);
imgOutput = my_calculator(imgInput);
output_path = get_path(path);
imwrite(imgOutput,output_path);

subplot(1, 2, 1);
imshow(imgInput);
subplot(1, 2, 2);
imshow(imgOutput);

% path = ('../asset/image/test2.jpg');
% imgInput = imread(path);
% %ch = my_digit(imgInput);
% ch = my_operator(imgInput);
% disp(ch);


function str = get_path(input_path)
    x = strsplit(input_path,'/');
    y = strsplit(x{4},'.');
    str =join(['../asset/image/',y{1},'_result.',y{2}]);
end




