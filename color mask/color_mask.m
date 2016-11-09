%% color_mask
%
% This function is used to draw different ROI with different colors and
% different transparent degrees in one target image
%  
%  Input parameters
%
%  img: target image, should be gray (Ny*Nx*1) or color (Ny*Nx*3)
%  mask: mask containing different ROI, different ROI should be labeled by 1,2,3,...,N_ROI
%  matrix_rgb: rgb value for each ROI, should be a N_ROI*3 matrix
%  transparent: transparent degree for each ROI mask, 
%               transparent degree increases from 0 to 1, 
%               namely 0 -- non-transparent and 1--totally transparent
%  
%  Principle
%     
%     img_coef+color_coef = 1 % transparent degree is equal to img_coef
%     img_new_rgb(:,:,1) =  img_old_gray*img_coef+r_color*color_coef*mask_ROI
%     img_new_rgb(:,:,2) =  img_old_gray*img_coef+r_color*color_coef*mask_ROI
%     img_new_rgb(:,:,3) =  img_old_gray*img_coef+r_color*color_coef*mask_ROI
%     or
%     img_new_rgb(:,:,1) =  img_old_rgb(:,:,1)*img_coef+r_color*color_coef*mask_ROI
%     img_new_rgb(:,:,2) =  img_old_rgb(:,:,2)*img_coef+r_color*color_coef*mask_ROI
%     img_new_rgb(:,:,3) =  img_old_rgb(:,:,3)*img_coef+r_color*color_coef*mask_ROI
%
%  An example:
%
%   img = rand(128,128);
%   mask = 0*img;
%   mask(10:20,10:20) = 1; %ROI 1
%   mask(30:40,30:40) = 2; %ROI 2
%   matrix_rgb =[100,150,100; 210 39 170];
%   transparent = 0.5;
%   color_mask(img,mask,matrix_rgb,transparent);
%%
function [res] = color_mask(img,mask,matrix_rgb,transparent)
% error detection
[Ny,Nx,Nz] = size(img);
[Ny_m,Nx_m] = size(mask);
if Ny~=Ny_m || Nx~=Nx_m
    error('The sizes of image and mask should be equal!');
    res = -1;
    return
end

if Nz~=1 && Nz~=3
    error('The input image should be gray or rgb image!')
    res = -1;
    return
end

if ~ismatrix(matrix_rgb)
    error('matrix_rgb should be a matrix');
    res = -1;
    return
end

[Ny_rgb,Nx_rgb] = size(matrix_rgb);

if Nx_rgb~=3
    error('matrix_rgb should be a matrix of N*3!')
    res = -1;
    return
end

if sum(sum(mod(mask,1)))~=0 || sum(sum(mask<0))~=0
    error('value of mask should be integer and larger than or equal to zero!')
    res = -1;
    return
end

N_ROI = max(max(mask));

if Ny_rgb~=N_ROI
    error('size of rgb array should be equal to size of ROI!')
    res = -1;
    return
end

if transparent<0 || transparent>1
    error('The transparent coefficient should be between 0 and 1!');
    res = -1;
    return
end



%% parameter setting

img_coef = transparent;
color_coef = 1-img_coef;

r_color = matrix_rgb(:,1);
g_color = matrix_rgb(:,2);
b_color = matrix_rgb(:,3);

%% processing
img = double(img);
img = img./max(max(max(img)));
current_img_rgb = zeros(Ny,Nx,3);

mask_transparent = (mask==0)+(mask~=0)*img_coef; % mask to set transparent coeffient for ROI area only


if Nz==1
    current_img_rgb(:,:,1) = img.*mask_transparent;
    current_img_rgb(:,:,2) = img.*mask_transparent;
    current_img_rgb(:,:,3) = img.*mask_transparent;
else
    current_img_rgb(:,:,1) = img(:,:,1).*mask_transparent;
    current_img_rgb(:,:,2) = img(:,:,2).*mask_transparent;
    current_img_rgb(:,:,3) = img(:,:,3).*mask_transparent;
end

for k = 1:N_ROI
    current_img_rgb(:,:,1) = current_img_rgb(:,:,1)+r_color(k)/255*color_coef*(mask==k);
    current_img_rgb(:,:,2) = current_img_rgb(:,:,2)+g_color(k)/255*color_coef*(mask==k);
    current_img_rgb(:,:,3) = current_img_rgb(:,:,3)+b_color(k)/255*color_coef*(mask==k);
end

figure;imshow(current_img_rgb)
end