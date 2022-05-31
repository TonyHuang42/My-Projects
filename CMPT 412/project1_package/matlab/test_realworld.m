layers = get_lenet();
layers{1, 1}.batch_size = 5;
load lenet.mat

for i = 1 : 5
    A = imread(strcat('./my_image/', num2str(i), '.png'));
    A = im2double(im2gray(A))';
    my_xtest(:, i) = reshape(A, 784, 1);
end
my_ytest = [1, 2, 4, 6, 7];

[output, my_P] = convnet_forward(params, layers, my_xtest(:, 1:5));
[~, my_prediction] = max(my_P, [], 1);
my_prediction = my_prediction - 1;

[my_confusion_matrix, ~] = confusionmat(my_ytest, my_prediction);
confusionchart(my_confusion_matrix);