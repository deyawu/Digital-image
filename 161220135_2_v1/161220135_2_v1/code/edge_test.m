%DIP16 Assignment 2
%Edge Detection
%In this assignment, you should build your own edge detection and edge linking 
%function to detect the edges of a image.
%Please Note you cannot use the build-in matlab edge and bwtraceboundary function
%We supply four test images, and you can use others to show your results for edge
%detection, but you just need do edge linking for rubberband_cap.png.
clc; clear all;
% Load the test image
imgTest = im2double(imread('rubberband_cap.png'));
imgTestGray = rgb2gray(imgTest);   % »Ò¶ÈÍ¼Ïñ
figure(1);clf;
imshow(imgTestGray);
% rubberband_cap.png  cloud.jpg beauty.jpg

%now call your function my_edge, you can use matlab edge function to see
%the last result as a reference first
%img_edge = edge(imgTestGray); %±ßÔµ»¯

filter_gray_image = imgTestGray;
img_edge = my_edge(filter_gray_image);
figure(2);clf;
imshow(img_edge);
% background = im2bw(img_edge,0.5);  clf;
% imshow(background);
%using imtool, you select a object boundary to trace, and choose
%an appropriate edge point as the start point 

 imtool(img_edge);

background = im2bw(imgTest, 1);
imshow(background);
%now call your function my_edgelinking, you can use matlab bwtraceboundary 
%function to see the last result as a reference first. please trace as many 
%different object boundaries as you can, and choose different start edge points.

 Dots = [131,171;65,252;91,46;196,77;283,222];
for i = 1:5
    M = [Dots(i,1),Dots(i,2)];
    Bxy = my_edgelinking(img_edge,M(1),M(2));
    hold on;
    plot(Bxy(:,2),Bxy(:,1),'w','LineWidth',1);
end














