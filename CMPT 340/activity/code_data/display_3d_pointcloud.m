%% Reading and displaying 3D point cloud
% Here we show examples of 3D point cloud, i.e. multiple (x,y,z) points.
% Each (x,y,z) is an estimate of the location of a protein inside a cell
% The protein in this case is Clathrin: https://en.wikipedia.org/wiki/Clathrin
% Photons are emited by a fluorescent dye Alexa 647 that binds to the protein.

%%
% You should have this directory structure:
%   
%   /display_3d_pointcloud.m
%   /smlm/clathrin_ROI_cmpt340.csv

close all
clear variables

%% Load raw data (clathrin - alexa647)
smlmPathFile = fullfile(pwd, 'smlm', 'clathrin_ROI_cmpt340.csv');
dat = importdata(smlmPathFile);
rawDat = dat.data; % ignore the column labels (i.e. X Y Z)
size(rawDat)

%%
% to speed up processing, let's look at only ~1000 points
points3D=rawDat(round(end/2)-500:round(end/2)+500,:);
size(points3D)

%% Plot the raw data
figure;
scatter3(points3D(:,1),points3D(:,2),points3D(:,3), 20, 'b', 'filled')

axis equal;
xlabel ('X nm');    ylabel ('Y nm');    zlabel ('Z nm');
grid on;
rotate3d;

%% construct graph (nodes and edges)
% two points connected if they are close enough to each other
% i.e. proximity threshold

PT = 800; % proximity threshold
distDat = pdist(points3D);
distMat = squareform(distDat);
distMat_th = distMat.*(distMat <= PT); % thresholded distance matrix
g = graph(distMat_th , array2table(points3D)); % create the graph from the distance matrix
 

%% plot the constructed graph 
figure
p= plot(g,'XData',points3D(:,1),'YData',points3D(:,2),'ZData',points3D(:,3), 'NodeLabel',{});     
axis equal;
p.Marker = 'o';
p.MarkerSize = 3; % change the node size
p.NodeColor = 'b'; % change the node color
p.EdgeColor = [1 0 0]; % change the edge color

xlabel ('X nm');    ylabel ('Y nm');    zlabel ('Z nm');

grid on;
view(3);

%% find the node degree
deg = degree(g);

%% plot the points colored by their degree
figure;
scatter3(points3D(:,1),points3D(:,2),points3D(:,3), 20, deg, 'filled')
axis equal;
colormap(jet);
xlabel ('X nm');    ylabel ('Y nm');    zlabel ('Z nm');
grid on;
rotate3d;



