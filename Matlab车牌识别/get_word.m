function [word,result] = get_word(img)
     [m,n] = size(img);
      width = 0;
      while width+1 < n-2 && sum(img(:,width+1)) ~= 0
          width = width+1;
      end
      word = imcrop(img,[1,1,width,m]);
      img(:, [1: width]) = 0;
      img = split(img);
      result = img;
end