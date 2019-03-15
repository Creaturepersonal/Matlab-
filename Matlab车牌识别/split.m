function split_img = split(img)
    [m,n] = size(img);
    top = 1;
    bottom = m;
    left = 1;
    right = n;
    %�ϱ߽�
    while top <= m && sum(img(top,:)) == 0
        top = top + 1;
    end
     %�±߽�
     while bottom >= 1 && sum(img(bottom,:)) == 0
         bottom = bottom - 1;
     end
     %��߽�
     while left >= 1 && sum(img(:,left)) == 0
         left = left + 1;
     end
     %�ұ߽�
     while right <= n && sum(img(:,right)) == 0
         right = right - 1;
     end
     %����ͼ��ĳ���õ��и���ͼ��
     height = bottom - top;
     width = right - left;
     split_img = imcrop(img, [left top width height]);
end
     