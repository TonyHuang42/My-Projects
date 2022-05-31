%% Reading and displaying 2D/3D tensor data
% Here we show examples of 2D and 3D DT-MRIs where each voxel has
% multiple values (a matrix in fact!) associated with it.


%% How to run this demo 
% You can download the datasets from Canvas
% 
% Download and extract */dtmri/dtmri.zip*.

%%
% You should have this directory structure:
%   
%   /display_dtmri.m
%   /dtmri/cBrainSlice34-2
%   /dtmri/sag_struct_2005_3T_2_to_GH_96x96x66_full


close all
clear variables


%% 2D DTMRI
% We look at a 2D DTMRI slice. 

% Load the data.
dt2dPathFile = fullfile(pwd, 'dtmri', 'cBrainSlice34-2');
dt2dStruct = load(dt2dPathFile);
TensorIM = dt2dStruct.TensorIM;

% This is a 2D image with a 3x3 matrix at each pixel.
size(TensorIM)
%%

% We can look at the image only considering one of the matrix values.
% In this case we pick the first matrix value (i.e. 1st row & 1st column of the matrix).
figure; imagesc(TensorIM(:,:,1,1));
%%

% If we only look at one pixel we can see the matrix of values.
x = 10;
y = 10;
figure; imagesc(squeeze(TensorIM(x,y,:,:)))
%%

% This is the matrix in numerical form,
squeeze(TensorIM(x,y,:,:))

%% 
% One way we can summarize this matrix is to look at the eigenvectors.
% These eigenvectors can be _roughly_ thought of as describing how the water
% is moving through the tissue.
[vecs, vals] = eig(squeeze(TensorIM(x,y,:,:)));

figure;
line(  [x x+vecs(1,1)] , [y y+vecs(2,1)] , [0 vecs(3,1)]);
hold on
line(  [x x+vecs(1,2)] , [y y+vecs(2,2)] , [0 vecs(3,2)]);
line(  [x x+vecs(1,3)] , [y y+vecs(2,3)] , [0 vecs(3,3)]);
view([45,45,30]);
grid on;
%%

% So now rather than a matrix at each pixel, we have 3 lines.

% Drawing 3 eignevector "lines" for each pixel in the image
fId = figure;
for i = 1:size(TensorIM,1) 
    for j = 1:size(TensorIM,2)
            [vecs, vals] = eig(squeeze(TensorIM(i,j,:,:)));              
           %we will choose random colors for evey triplet of vectors
           % clr=rand(1,3);
            %we are scaling each eigenvector by the corresponding eigenvalue
            e=diag(vals)/norm(diag(vals));             
            line( [i i+e(1)*vecs(1,1)] , [j j+e(1)*vecs(2,1)] , [0 e(1)*vecs(3,1)],'color',[1 0 0]);
            hold on
            line( [i i+e(2)*vecs(1,2)] , [j j+e(2)*vecs(2,2)] , [0 e(2)*vecs(3,2)],'color',[0 1 0]);
            line( [i i+e(3)*vecs(1,3)] , [j j+e(3)*vecs(3,2)] , [0 e(3)*vecs(3,3)],'color',[0 0 1]);
    end
end
axis image

% We can zoom in and spin this around to get a better sense that we have 3
% lines at each pixel value.
% This part is to zoom around and make the GIF. 
maxA = 10;
for a=1:maxA
    frame = getframe(fId);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    filename = fullfile('dtmri2d.gif');
    if a == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
        zoom(1.2);
    elseif a==maxA
        % Do nothing.
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);        
        zoom(1.2);
    end    
end

for b=1:36
    camorbit(10,0,'data',[0 1 1])
    drawnow
    frame = getframe(fId);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.25);
end
close(fId);
% End zooming around and making the GIF.

%%
% <<dtmri2d.gif>>

%% 3D DTMRI 
% Let us examine a 3D DT-MRI. This is the same concept as the 2D DT-MRI,
% but we have the added dimension of depth.

dtPathFile = fullfile(pwd,'dtmri','sag_struct_2005_3T_2_to_GH_96x96x66_full');
%load('dtmri/sag_struct_2005_3T_2_to_GH_96x96x66_full.mat')
dtStruct = load(dtPathFile);

% The eigen vectors computed earlier.
vecs =dtStruct.sag_struct_2005_3T_2.EVEC;

% width x height x matrix x matrix x depth
size(vecs)
%%


% All first eigen vectors in the volume
vec1=squeeze(  vecs(:,:,:,1,:)  );

% note the order of dimensions
size(vec1)  %    96    96     3    66
%%

% we can change this order:
v1=permute(vec1,[1 2 4 3]);

%mesh grid will create 3 matrices
%one will contain the x coordinates of location to draw the eigenvectros
%one will contain the y coordinates of location to draw the eigenvectros
%one will contain the z coordinates of location to draw the eigenvectros
% try   [xx,yy]=meshgrid(1:3,2:7);
%note how these contain x and y coordiantes each in a 2D array

stp=10;

[xx,yy,zz]  = meshgrid(  1:stp:96,  1:10:96, 1:10:66  );
% At these locations xx,yy,zz, we will draw the vectors

% This figure shows 3 eigen vectors in the 3D volume.
figure;
quiver3(  xx,  yy,  zz,...   %the locations, and now the actual vectors
    squeeze(v1(1:stp:end,1:stp:end,1:stp:end,1)),...
    squeeze(v1(1:stp:end,1:stp:end,1:stp:end,2)),...
    squeeze(v1(1:stp:end,1:stp:end,1:stp:end,3)))

% Get the second and third eigen vectors.
v2=permute(squeeze(  vecs(:,:,:,2,:)  ),[1 2 4 3]);
v3=permute(squeeze(  vecs(:,:,:,3,:)  ),[1 2 4 3]);
hold on
quiver3(  xx,  yy,  zz, ...   %the locations, and now the actual vectors
    squeeze(v2(1:stp:end,1:stp:end,1:stp:end,1)),...
    squeeze(v2(1:stp:end,1:stp:end,1:stp:end,2)),...
    squeeze(v2(1:stp:end,1:stp:end,1:stp:end,3)),'color',[1 0 0]);
quiver3(  xx,  yy,  zz, ...   %the locations, and now the actual vectors
    squeeze(v3(1:stp:end,1:stp:end,1:stp:end,1)),...
    squeeze(v3(1:stp:end,1:stp:end,1:stp:end,2)),...
    squeeze(v3(1:stp:end,1:stp:end,1:stp:end,3)),'color',[0 1 0]);
axis image;


