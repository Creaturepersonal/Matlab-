% function [ word, result ] = split_word( img )
% %UNTITLED 此处显示有关此函数的摘要
% %   此处显示详细说明
%     word = [];
%     flag = 0;
%     y1 = 8;
%     y2 = 0.5;
%     
%     while flag == 0
%         [m, n] = size(img);
%         width = 0;
%         while sum(img(:, width+1)) ~= 0 && width <= n-2
%             width = width + 1;
%         end
%         temp = split(imcrop(img, [1,1,width,m]));
%         [m1, n1] = size(temp);
%         if width < y1 && n1/m1>y2
%             img(:, [1, width]) = 0;
%             if sum(sum(img)) ~= 0
%                 img = split(img);
%             else
%                 word = [];
%                 flag = 1;
%             end
%         else
%             word = split(imcrop(img, [1, 1, width, m]));
%             img(:, [1: width]) = 0;
%             if sum(sum(img)) ~= 0
%                 img = split(img);
%                 flag = 1;
%             else
%                 img = [];
%             end   
%         end
%     end
% 
%     result = img;
% end
function [word,result] = split_word(img)
     [m,n] = size(img);
      width = 0;
      while width+1 < n-2 && sum(img(:,width+1)) ~= 0
          width = width+1;
      end
      word = imcrop(img,[1,1,width,m]);
      %img(:, [1: width]) = 0;
      img(:, 1: width) = 0;
      img = split(img);
      result = img;
end