layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
figure(1);
imshow(img')
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.
output_2 = reshape(output{2}.data, 24, 24, 20);
output_3 = reshape(output{3}.data, 24, 24, 20);

figure(2);
for i = 1 : 20
    subplot(4, 5, i);
    img = output_2(:,:,i);
    imshow(img')
end
sgtitle('CONV layer')

figure(3);
for i = 1 : 20
    subplot(4, 5, i);
    img = output_3(:,:,i);
    imshow(img')
end
sgtitle('ReLU layer')