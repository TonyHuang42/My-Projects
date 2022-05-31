function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    reshaped_input_data = reshape(input.data, h_in, w_in, c, batch_size);
    padded_input_data = padarray(reshaped_input_data, [pad, pad], 'both');
    for i = 1 : h_out
        for j = 1 : w_out
            filter = padded_input_data((i-1)*stride+1:(i-1)*stride+k,(j-1)*stride+1:(j-1)*stride+k,:,:);
            output.data(i,j,:,:) = max(filter, [], [1, 2]);
        end
    end
    output.data = reshape(output.data, h_out*w_out*c, batch_size);
end



