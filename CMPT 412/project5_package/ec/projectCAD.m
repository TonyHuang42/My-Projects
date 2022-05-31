clear;
close all;

load('../data/PnP.mat');
P = estimate_pose(x,X);

figure(1);
imshow(image);
hold;
plot(x(1,:),x(2,:),'r.');

proj_X = P*[X;ones(1,size(X,2))];
proj_X = proj_X(1:2,:) ./ proj_X(3,:);
plot(proj_X(1,:),proj_X(2,:),'bO');

figure(2);
[~,R,~] = estimate_params(P);
rotated_v = R*cad.vertices';
trimesh(cad.faces,rotated_v(1,:),rotated_v(2,:),rotated_v(3,:));

figure(3);
imshow(image);
hold;
proj_v = P*[cad.vertices'; ones(1,size(cad.vertices',2))];
proj_v = proj_v(1:2,:) ./ proj_v(3,:);
patch('Faces',cad.faces,'Vertices',proj_v','FaceColor','b','LineStyle','none','FaceAlpha',0.25);