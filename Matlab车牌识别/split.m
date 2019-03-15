function split_img = split(img)
    [m,n] = size(img);
    top = 1;
    bottom = m;
    left = 1;
    right = n;
    %上边界
    while top <= m && sum(img(top,:)) == 0
        top = top + 1;
    end
     %下边界
     while bottom >= 1 && sum(img(bottom,:)) == 0
         bottom = bottom - 1;
     end
     %左边界
     while left >= 1 && sum(img(:,left)) == 0
         left = left + 1;
     end
     %右边界
     while right <= n && sum(img(:,right)) == 0
         right = right - 1;
     end
     %计算图像的长宽得到切割后的图像
     height = bottom - top;
     width = right - left;
     split_img = imcrop(img, [left top width height]);
end
     