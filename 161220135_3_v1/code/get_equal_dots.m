function result = get_equal_dots(store_datas,src_img)
    src_data = solve(src_img);
    [data_length,data_width] = size(store_datas);
    comp_data = zeros(data_length,1);
    for  i = 1:data_length
        sum = 0;
        for j =1:data_width
            sum = sum + (store_datas(i,j)-src_data(j)).^2;
        end
        comp_data(i) = sum;
    end
    [min_x,index] = min(comp_data);
    result = index-1;
end

function store_datas = solve(img)
    store_datas = zeros(1,4);
    [img_len,img_wid] = size(img);
    img = 1-img;
    data = length(find(img(1:fix(img_len/2),1:fix(img_wid/2))));
    store_datas(1) = data/(img_len/2 * img_wid/2);
    data = length(find(img(1:fix(img_len/2),fix(img_wid/2):img_wid)));
    store_datas(2) = data/(img_len/2 * img_wid/2);
    data = length(find(img(fix(img_len/2):img_len,1:fix(img_wid/2))));
    store_datas(3) = data/(img_len/2 * img_wid/2);
    data = length(find(img(fix(img_len/2):img_len,fix(img_wid/2):img_wid)));
    store_datas(4) = data/(img_len/2 * img_wid/2);
end
