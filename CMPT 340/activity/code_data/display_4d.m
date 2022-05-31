%% Reading and displaying 4D data.
% Here we will show examples of 3D volumes being recorded over time. Note
% here that the 4D means we have 3 spatial and 1 time dimensions.

%% How to run this demo 
% You can download the datasets from Canvas
% 
% Download and extract */4dpet/4dpet.zip*.

%%
% You should have this directory structure:
%   
%   /display_4d.m
%   /4dpet/001.img
%   /4dpet/001.mhd
%   ...
%   /4dpet/016.img
%   /4dpet/016.mhd


close all
clear variables

%% 4D-PET
% We can have a 3D volume recorded over time. This time dimension is
% considered as the 4th dimension. Here each voxel has as a single value
% for a point in time.

% Where the 4dpet data is stored.
petPath = fullfile('4dpet');

pet4D = [];
% How many 3D volumes there are.
nVols = 16;
for a=1:nVols
    petName = sprintf('%03i.img',a);
    fd = fopen(fullfile(petPath, petName));
    pet3D = fread(fd, inf, 'float');
    size(pet3D)
    fclose(fd);
    pet4D(:,:,:,a) = pet3D;
end

% The size(dimensions) are incorrect. 
size(pet4D)
%%

% This is the correct dimensions.
pet4D = reshape(pet4D ,   [128 128 95  16]   );

% This is the correct size. Width x height x depth x time
size(pet4D)
%%

% We have 16 3D volumes that are changing over time. Let's look at them.
fId = figure;
for a=1:size(pet4D,4)
    %imagesc(pet4D(:,:,50,a)); axis image;
    vol = pet4D(:,:,:,a);
    slice(vol, round(size(vol,2)/2), round(size(vol,1)/2), round(size(vol,3)/2))
    axis tight 
    shading flat;
    colorbar
    caxis([0 10])
    caxis manual
    
    title(sprintf('3D PET volume:%i',a));
    %snapnow;
    frame = getframe(1);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    filename = fullfile('pet4d.gif');
    if a == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end

    pause(0.5)
end
close(fId);

%%
% <<pet4d.gif>>


% We can look at how a single voxel changes over time.
% Fix the spatial coordinates.
x = 64; 
y = 64;
z = 50;

% Get the different values the same voxel has over time.
vox = pet4D(x,y,z,:);

% We have these extra empty dimensions.
size(vox)
%%

% The squeeze() function gets rid of empty dimensions.
vox = squeeze(vox);

% We have 16 values corresponding to the 16 time steps.
size(vox)
%%

% Plot the voxel's value chaning over time. Note the similarities this has
% with the 1D data at the start in the eeg example.
figure; plot(1:size(vox,1),vox,'-o');
title('The same voxel changing over time');
xlabel('time');
ylabel('pet-value');



