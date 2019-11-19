function output = my_edgelinking(binary_image, row, col)
%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary 
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores 

    output = linking_first(binary_image,row,col);
    
end

% 内边界跟踪算法
function output = linking_first(binary_image,row,col)
    dir = 7;   % 按照8邻接检测边界
    store_dots = zeros(row*col,2);
    first_dot = [row,col];
    numcount = 1;   %记录有边界的像素点数
    next_dot = safe_dot(binary_image,row,col,dir);
    while(next_dot(1) == 1)     
        store_dots(numcount,:) = [row,col];
        row = next_dot(2);
        col = next_dot(3);
        dir = next_dot(4);
        if ((first_dot(1) == row)&&(first_dot(2) == col))
            output = store_dots(1:numcount,:);
            break;
        end
        next_dot = safe_dot(binary_image,row,col,dir);
        numcount = numcount+1;
    end
    if(next_dot(1) == 0)
        output = [0,0];  %查找失败
    end   
end
function islegal = safe_dot(binary_image,row,col,dir)
    islegal = zeros(1,4); %存放 legal_flag, 下一个（row,col）
    if (mod(dir,8) == 1)  %奇数
        dir = mod(dir+6,8);
    else
        dir = mod(dir+7,8);
    end
    for i = dir:dir+8            %转一圈进行遍历
        switch mod(i,8)
            case 0
                if (binary_image(row,col+1) == 1)
                    islegal(1) = 1;
                    islegal(2) =row;
                    islegal(3) = col+1;
                end
            case 1
                if (binary_image(row-1,col+1)==1)
                    islegal(1) = 1;
                    islegal(2) = row-1;
                    islegal(3) = col+1;
                end
            case 2
                if (binary_image(row-1,col)==1)
                    islegal(1) = 1;
                    islegal(2) =row-1;
                    islegal(3) = col;
                end
            case 3
                if (binary_image(row-1,col-1)==1)
                    islegal(1) = 1;
                    islegal(2) = row-1;
                    islegal(3) = col-1;
                end
            case 4
                if(binary_image(row,col-1)==1)
                    islegal(1) = 1;
                    islegal(2) = row;
                    islegal(3) = col-1;
                end
            case 5
                if (binary_image(row+1,col-1)==1)
                    islegal(1) = 1;
                    islegal(2) = row+1;
                    islegal(3) = col-1;
                end
            case 6
                if(binary_image(row+1,col) == 1)
                    islegal(1) = 1;
                    islegal(2) = row+1;
                    islegal(3)  = col;
                end
            case 7
                if(binary_image(row+1,col+1)==1)
                    islegal(1) = 1;
                    islegal(2) = row+1;
                    islegal(3) = col+1;
                end
        end
        islegal(4) = mod(i,8);
        if islegal(1) == 1
            break;
        end
    end
end

















