%% Reading and displaying data with 3 spatial dimensions
% Here we show examples of 3D *volumes* where each _voxel_ (voxel = a pixel in a 3D volume) can have a single
% or multiple values associated with it. In this section, we will only look
% at the case where a voxel has a single value. You can see an example of
% a voxel having multiple values in the color example from the 2D images
% and the dt-mri example.


%% How to run this demo 
% You can download the datasets from Canvas
%
% Download and extract */dicom/dicom_slices.zip*.

%%
% You should have this directory structure:
%   
%   /display_3d.m
%   /dicom/img00001.dcm
%   ...
%   /dicom/img00057.dcm


close all; 
clear variables;

%% 3D scalar volumes
% So far we have looked at 2D _images_ (width and height). We can also look
% at 3D _volumes_ where we have a width, height and depth component. We call 
% them _volumes_ instead of _images_ when we add the depth component. You
% can think of this as "stacking" 2D images on top of each other.
%
% An example of a 3D volume is the scans taken from MRI or CT machines.
%
% Here we have images stored in a format called DICOM. 

% The path where the images are stored.
volPath = fullfile(pwd,'dicom');

% Each image has this as a prefix.
volPrefix = 'img';

% Number of images to load (set to the number of images in the folder).
numImgs = 57;

% We will store the volume here.
vol = [];

% Loop over all the dicom images in the folder.
for a=1:numImgs
    % Pad to match the file name.    
    imgNumber = sprintf('%05i',a);
    % Combine the names to match the filenames.
    imgName = [volPrefix, imgNumber, '.dcm'];
    % Combine the path and the image filesname.    
    imgNamePath = fullfile(volPath, imgName);
    % Read the dicom image.
    img2D = dicomread(imgNamePath);
    
    % This is a 2D scalar image. Store it in the volume.
    vol(:,:,a) = img2D;
end

% We can see what the size of our volume is,
%   width x height x depth
% Note that each voxel has a single value.
size(vol)
%%

% We can look at it from a 3D perspective.
fId = figure;
% slice() shows planes in the 3d volume.
slice(vol, round(size(vol,2)/2), round(size(vol,1)/2), round(size(vol,3)/2));
axis image; colormap gray;
shading flat;

% This rotates the volume just for visualization purposes in this demo.
for a=1:72
   pause(0.01);
   camorbit(5,0,'data',[0 1 1])
   drawnow
   
   % This part records the GIF.
   frame = getframe(1);
   im = frame2im(frame);
   [A,map] = rgb2ind(im,256);
   filename = fullfile('rot3d.gif');
   if a == 1
       imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.25);
   else
       imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.25);
   end
   % end GIF stuff.
   
end
close(fId);
% End rotate volume.

%%
% <<rot3d.gif>>


% We can also view a single slice as a 2D image.
idx = 25;
figure; imagesc((vol(:,:,idx))); colormap gray; axis image;

