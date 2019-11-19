function output = my_calculator(input_image)
%in this function, you should finish the character recognition task.
%the input parameter is a matrix of an image which contains several expressions
%the output parameter is a matrix of an image which contains the results of expressions 

mysize = size(input_image);
if numel(mysize) > 2
    input_image = im2bw(input_image); 
end
Points = getStartPoint(input_image);
for i = 1:10
    for j = 1:3
        result = Cut_and_calculate(Points(i,j,:), input_image);
        img = imread(['../asset/data/' mat2str(result(1)) '.png']);
        [img_length,img_width] = size(img);
        for m = 1:img_length
            for n = 1:img_width
                input_image(result(2)+m,result(3)+n) = img(m,n);
            end
        end
    end
end
output = input_image;
end

function Points = getStartPoint(input_image)
    Points = zeros(10,3,2);
    start_x = 1;
    start_y = 1;
    while input_image(start_x,20) ~= 0
        start_x = start_x + 1;
    end
    while input_image(20,start_y) ~= 0
        start_y = start_y + 1;
    end
    % 获取第一个方格起始点
    Points(1,1,:) = [start_x + 10, start_y + 10];
    for i = 1:9
        x = Points(i,1,1);
        y = Points(i,1,2);
        while input_image(x,y) ~= 0
            x = x + 1;
        end
        Points(i + 1,1,:) = [x + 10,y];
    end
    for i = 1:10
        for j = 1:2
            x = Points(i,j,1);
            y = Points(i,j,2);
            while input_image(x,y) ~= 0
                y = y + 1;
            end
            Points(i,j+1,:) = [x ,y + 10];
        end
    end
end

function Cut_points = getCutPoints(start, input_image)
    Cut_points = zeros(4);
    start_x = start(1);
    start_y = start(2);
    end_x = start_x;
    end_y = start_y;
    diet_x = 70;
    flag = 0;
    while flag ~= 1
        start_y = start_y + 1;
        for i = start_x:start_x + diet_x
            if(input_image(i,start_y) == 0)
                flag = 1;
                break;
            end
        end
    end
    end_y = start_y;
    while flag ~= 0
        end_y = end_y + 1;
        for i = start_x:start_x + diet_x
            if(input_image(i,end_y + 1) == 0)
                break;
            end
        end
        if i == start_x + diet_x
            flag = 0;
        end
    end
    flag = 1;
    while flag ~= 0
        start_x = start_x + 1;
        for i = start_y:end_y
            if(input_image(start_x, i) == 0)
                flag = 0;
            end
        end
    end
    flag = 1;
    end_x = start_x;
    while flag ~= 0
        end_x = end_x + 1;
        for i = start_y:end_y
            if(input_image(end_x,i) == 0)
                break;
            end
        end
        if i == end_y
            flag = 0;
        end
    end
    end_x = end_x - 1;
   % disp([start_x, start_y, end_x, end_y]);
   Cut_points = [start_x, start_y, abs(end_x-start_x), abs(end_y-start_y)];
end

function result = Cut_and_calculate(points, input_image)
    result = zeros(1,3);
    Cut_points = getCutPoints(points, input_image);
    img_x = imcrop(input_image,[Cut_points(2),Cut_points(1),Cut_points(4),Cut_points(3)]);
    left = str2num(my_digit(img_x));
    %disp(left);
    
    Cut_points = getCutPoints([points(1),Cut_points(2)+Cut_points(4)+10],input_image);
    img_m = imcrop(input_image,[Cut_points(2),Cut_points(1),Cut_points(4),Cut_points(3)]);
    if my_operator(img_m) == '+'
        operator = 1;
    else
        operator = 0;
    end

    Cut_points = getCutPoints([points(1),Cut_points(2)+Cut_points(4)+10],input_image);
    img_y = imcrop(input_image,[Cut_points(2),Cut_points(1),Cut_points(4),Cut_points(3)]);
    right = str2num(my_digit(img_y));
    %disp(right);
    
    equal_pos_x = Cut_points(1);
    
    Cut_points = getCutPoints([points(1),Cut_points(2)+Cut_points(4)+10],input_image);
    result(2) = equal_pos_x;
    result(3) = Cut_points(2) + Cut_points(4) + 20; % position of result after '='
    
    if operator == 0        % minus
        result(1) = left - right;
    else 
        result(1) = left + right;
    end   
%      disp(result);
end












