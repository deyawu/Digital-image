%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores 

function output = my_edge(input_image)
    output = my_edge_sobel(input_image);
   %output = my_edge_candy(input_image);
end

function output = my_edge_candy(input)
    lower_bound = 0.15;  % 需要动态调整
    higher_bound = 0.2;
    [img_length,img_width] = size(input);
    output = input;
    p= input;   % 存储中间过程的梯度值  
    q= input; % 非极大值抑制
    gaus_img = my_gausfilter(input);   %高斯滤波
    sector = zeros(img_length,img_width); %存储区域
    
     M = [-1,0,1;-2,0,2;-1,0,1]; % 卷积因子
     N = [1,2,1;0,0,0;-1,-2,-1];
    img_x = imfilter(gaus_img,M,'replicate');  % 水平卷积
    img_y= imfilter(gaus_img,N,'replicate');   % 垂直卷积
    for i = 2:img_length-2                       % 获取每个点梯度的方向
        for j = 2:img_width-2
            Gx = (img_x(i,j))^2;
            Gy = (img_y(i,j))^2;
            p(i,j) = sqrt(Gx+Gy);
            theta = abs(atand(Gx/Gy));  %得到°的表示
            if ((theta > 22.5) && (theta < 67.5))
                sector(i,j) = 0;
            elseif ((theta > 67.5) && (theta < 112.5))
                 sector(i,j) = 1; 
            elseif((theta > 112.5)&&(theta < 157.5))
                sector(i,j) = 2;
            else 
                 sector(i,j) = 3;   
            end    
        end
    end     
    for i = 2:img_length-2
        for j = 2:img_width-2
            switch sector(i,j)
                case 0
                    if ((p(i,j)>p(i-1,j+1))&& (p(i,j)>p(i+1,j-1)))
                        q(i,j) = p(i,j);
                    else
                        q(i,j) = 0;                    
                    end
                case 1
                    if((p(i,j)>p(i,j-1)) && (p(i,j)>p(i,j+1)))
                        q(i,j) = p(i,j);
                    else
                        q(i,j) = 0;
                    end
                case 2
                    if((p(i,j)>p(i-1,j-1)) && (p(i,j)>p(i+1,j+1)))
                        q(i,j) = p(i,j);
                    else
                        q(i,j) = 0;
                    end
                case 3
                    if((p(i,j)>p(i-1,j))&&(p(i,j)>p(i+1,j)))
                        q(i,j) = p(i,j);
                    else
                        q(i,j) = 0;
                    end
                otherwise
                    disp('wrong information!');
            end
        end
    end
    figure(3);histogram(q);
   % 双阈值检测
   for i = 2:img_length-2
       for j = 2:img_width-2
           if(q(i,j) > higher_bound)
               output(i,j) = 1;
           elseif(q(i,j) < lower_bound)
               output(i,j) = 0;
           else
               t = max([q(i-1,j-1),q(i-1,j),q(i-1,j+1), ...
                   q(i,j-1),q(i,j+1),q(i+1,j-1),q(i+1,j),q(i+1,j+1)]);
               if(t > higher_bound)
                   output(i,j) = 1;
               else
                   output(i,j) = 0;
               end
                   
           end
       end
   end
end

function output = my_edge_sobel(input)
    output = input;
    [img_length,img_width] = size(input);
     M = [-1,0,1;-2,0,2;-1,0,1]; % 卷积因子
     N = [1,2,1;0,0,0;-1,-2,-1];
    threadhold = 1.3;       % 需要动态调整
   % threadhold = 0.3;
    put_test = zeros(img_length,img_width);
    
    img_x = imfilter(input,M,'replicate');
    img_y= imfilter(input,N,'replicate');
    for i = 1:img_length
        for j = 1:img_width
           t = sqrt(img_x(i,j)*img_x(i,j)+img_y(i,j)*img_y(i,j));
           put_test(i,j) = t;
           if t > threadhold
               output(i,j) = 1;
           else
               output(i,j) = 0;
           end
        end
    end
    figure(3);histogram(put_test);
end

function output = my_gausfilter(input)
    sigma = 1;                                      % 高斯滤波
    gausFilter = fspecial('gaussian',[3,3],sigma);
    output = imfilter(input,gausFilter,'replicate'); % 高斯滤波后的图像
end
















