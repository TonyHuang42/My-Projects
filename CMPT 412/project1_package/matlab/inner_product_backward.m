function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
input_od = param.w*output.diff;
param_grad.w = (input.data*output.diff');
param_grad.b = (sum(output.diff,2))';
end
