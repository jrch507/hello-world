close all;
clear all;
clc;

% create mask for coins
I = imread('coins.png');
level = graythresh(I);
BW = im2bw(I,level);
mask = bwlabel(BW);

% show color masks in original coin image
N = max(max(mask));
matrix_rgb = zeros(15,3);
for k = 1:N
    matrix_rgb(k,1) = round(255-255*(k-1)/N);
    matrix_rgb(k,2) = round(255*(k-1)/N);
    matrix_rgb(k,3) = round(255*(rem(k,round(N/5))-1)/round(N/5));
end
transparent = 0.5;
color_mask(I,mask,matrix_rgb,transparent);


