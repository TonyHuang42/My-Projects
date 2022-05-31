function [output] = conv_layer_forward(input, layer, param)
    % Conv layer forward
    % input: struct with input data
    % layer: convolution layer struct
    % param: weights for the convolution layer

    % output: 

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    num = layer.num;
    % resolve output shape
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;

    assert(h_out == floor(h_out), 'h_out is not integer')
    assert(w_out == floor(w_out), 'w_out is not integer')
    input_n.height = h_in;
    input_n.width = w_in;
    input_n.channel = c;

    %% Fill in the code
    % Iterate over the each image in the batch, compute response,
    % Fill in the output datastructure with data, and the shape. 
    output.height = h_out;
    output.width = w_out;
    output.channel = size(param.w, 2);
    output.batch_size = batch_size;

    reshaped_input_data = reshape(input.data, h_in, w_in, c, batch_size);
    padded_input_data = padarray(reshaped_input_data, [pad, pad], 'both');
    for depth = 1 : output.channel
        kernel = reshape(param.w(:,depth),k,k,c,1);
        for i = 1 : h_out
            for j = 1 : w_out
                filter = padded_input_data((i-1)*stride+1:(i-1)*stride+k, (j-1)*stride+1:(j-1)*stride+k, :, :);
                output.data(i,j,depth,:) = sum(filter .* kernel,[1 2 3]) + param.b(depth);
            end
        end
    end
    output.data = reshape(output.data,h_out*w_out*output.channel,batch_size);
end

