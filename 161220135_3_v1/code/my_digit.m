function output = my_digit(input_image)
%in this function, you should finish the digit recognition task.
%the input parameter is a matrix of an image which contains a digit.
%the output parameter represents which digit it is.
    store_datas = [     % 0 ~ 9
    0.4146    0.4286    0.4460    0.4669
    0.3750    0.3333    0.3250    0.5000
    0.2269    0.4923    0.4692    0.4192
    0.2349    0.5239    0.2421    0.5745
    0.1951    0.5147    0.3196    0.5517
    0.5500    0.3654    0.2192    0.5231
    0.5261    0.3519    0.5087    0.5017
    0.2000    0.5654    0.2808    0.2385
    0.4661    0.5167    0.5239    0.5601
    0.4372    0.4770    0.3830    0.6251
    ];

    img_size = size(input_image); %ÖĞÖµÂË²¨
    
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
    output = mat2str(result);
end
