function output = my_operator(input_image)
%in this function, you should finish the operator recognition task.
%the input parameter is a matrix of an image which contains an operator.
%the output parameter represents which operator it is. 
    store_datas = [  
     1     1     1     1            % -
     0.1600    0.2057    0.2645    0.3102   % +
     0.5714    0.5714    0.5714    0.5714   % =
    ];

    img_size = size(input_image);
    if(numel(img_size) > 2)
        input_image = im2bw(input_image);
    end

    input_image = 1 - input_image;
    [n, m] = find(input_image);
    n = unique(n);
    m = unique(m);
    input_image = 1 - input_image;
    input_image = input_image(n(1):n(end), m(1):m(end));

    result = get_equal_dots(store_datas,input_image);
    if result == 0
        output = '-';
    elseif result == 1
        output = '+';
    else
        output = '=';
    end
end
