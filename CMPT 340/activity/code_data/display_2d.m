%% Reading and displaying data with 2 spatial dimensions 
% Here we show examples of 2D data, specifically 2D *images*. Each pixel can 
% have a _single_ or _multiple_ values associated with it.


%% How to run this demo 
% You can download the datasets from Canvas
% 
% Download */2d_jpg_tif/image2d_gray.tif* and */2d_jpg_tif/viz_head.jpg*. Put them in a folder called
% *2d_jpg_tif*

%%
% You should have this directory structure with the following files:
%   
%   /display_2d.m
%   /2d_jpg_tif/image2d_gray.tif
%   /2d_jpg_tif/viz_head.jpg


close all
clear variables


%% 2D scaler image
% Intuitively, this is an image with no colors (grayscale). There is just a
% single value for each pixel. The _image_ has 2 dimensions (width and
% height), while each _pixel_ has a 1 dimension (intensity).

% First, we load the image.
img2dGrayNamePath = fullfile(pwd,'2d_jpg_tif','image2d_gray.tif');
I = imread(img2dGrayNamePath);

% Look at the dimensions of this image. The first two dimensions are the
% height and width of the image. 
size(I)
%%

figure; 
% This displays the image in the figure, scaling the intensity values to
% make them more visible.
imagesc(I);

% Makes the pixels have uniform size (more realistic scaling).
axis image;

% By default MATLAB assigns a color to the scalar value. We can instead
% display it in grayscale.
colormap gray;

% We can add a title to the image.
title('2D scalar image');

%% How to view a 2D color image
% The _image_ itself has a width and height making it a 2D image. But
% now, at each _pixel_, we have 3 values (We can also say each _pixel_ has
% 3 dimensions, or each _pixel_ has a vector with 3 values).
img2dColorNamePath = fullfile(pwd,'2d_jpg_tif','viz_head.jpg'); 
I = imread(img2dColorNamePath );

% Notice here that the size of I is,
%   width x height x number_of_values_at_each_pixel.d
size(I)
%%

% A color image has 3 channels (red, green, blue). We can separate each
% channel like this,
ch1 = I(:,:,1);
ch2 = I(:,:,2);
ch3 = I(:,:,3);

% Let's view each color channel independently.
figure;

% We can show different images on the same figure using the subplot()
% command. subplot(2,2,1) means divide the figure into 2 rows and 2 columns, 
% then select the placeholder for position 1.
subplot(2,2,1); 
imagesc(ch1); axis image; colormap gray; title('ch1');

% Place channel 2 in position 2.
subplot(2,2,2); imagesc(ch2); axis image; colormap gray; title('ch2');

subplot(2,2,3); imagesc(ch3); axis image; colormap gray; title('ch3');

% Finally, put the original color image in the 4th position.
subplot(2,2,4); imagesc(I); axis image; title('all channels'); 


