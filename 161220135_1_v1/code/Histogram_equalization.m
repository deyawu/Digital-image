function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
    if numel(size(input_image)) == 3
        %this is a RGB image
        %here is just one method, if you have other ways to do the
        %equalization, you can change the following code
        disp('this is a colorful image! ');
        [output] = color_equal(input_image);
    else
        %this is a gray image
        disp('this is a gray image! ');
        [output] = hist_equal(input_image);
    end

    
    function [color_output] = color_equal(input_image)
       %方法一：直接对每个通道进行直方图均衡化
%         r=input_image(:,:,1);
%         v=input_image(:,:,2);
%         b=input_image(:,:,3);
%         r = hist_equal(r);
%         v = hist_equal(v);
%         b = hist_equal(b);
%         color_output = cat(3,r,v,b);


% %         方法二：转换成hsv图像，进行均衡化
        hsv_image = rgb2hsv(input_image);
        h = hsv_image(:,:,1);
        s = hsv_image(:,:,2);
        v = hsv_image(:,:,3);
        v = hsv_hist_equal(v);
        s = hsv_hist_equal(s);
        color_output = hsv2rgb(h,s,v);   
    end

    function[output2] = hsv_hist_equal(input_channel)
        output2 = input_channel;
        [p_length,p_width] = size(input_channel);
        channel_one = uint8(zeros(p_length,p_width));
        for i = 1:p_length
            for j = 1:p_width
                channel_one(i,j) = input_channel(i,j)*255;  % change 0 ~ 255
            end
        end
        k = hist_equal(channel_one);
        for i = 1:p_length
            for j = 1:p_width
                output2(i,j) = (double(k(i,j)))/255;
            end
        end
    end

    function [output2] = hist_equal(input_channel)
    % 通道直方图均衡化
        output2 = input_channel;
        [p_length,p_width] = size(input_channel);
        mapping = getmap(input_channel);
        for i = 1:p_length
            for j = 1:p_width
                output2(i,j) = mapping(input_channel(i,j)+1);
            end
        end
    end
    
    function[mapping] = getmap(input_channel)         % 获取通道的映射关系
        %you should complete this sub-function
        [p_length,p_width] = size(input_channel);
        %disp([num2str(p_length),num2str(p_width)]);  
        num_count = zeros(256);     % 计算每个灰度值的像素值
        for i=1:p_length
            for j=1:p_width
                gray_value = input_channel(i,j);
                num_count(gray_value+1) = num_count(gray_value+1)+1;
            end
        end
        prob_count = zeros(256);   
        dest_count = zeros(256);   % 存储映射表
        for i = 1:256
            prob_count(i) = num_count(i) / (p_length * p_width);
            prob_sum = 0;
            for j = 1:i
                prob_sum = prob_sum + prob_count(j);
            end
            dest_count(i) = prob_sum * 255;   % 共有255个灰度级
        end  
        mapping = fix(dest_count);     % 截尾取整
    end
end







