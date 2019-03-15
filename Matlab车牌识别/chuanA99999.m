clc;
clear;
f = imread('川A99999.jpg');
imshow(f);title('原图');
img_gray = rgb2gray(f);
figure;
imshow(img_gray);title('灰度图');
hf = histeq(img_gray);
figure;
imshow(hf);title('均衡化图');
w = [1,1,1;1,-8,1;1,1,1];
img = hf - imfilter(hf,w,'replicate');
figure;
imshow(img);title('锐化图');
[t,sm] = graythresh(img);
img_bw = im2bw(hf,t+0.4);
figure;
imshow(img_bw);title('二值图');
[m,n] = size(img_bw);
for i = 1:5
    for j = 1:n
        img_bw(i,j) = 0;
    end
end
for i = m-5:m
    for j = 1:n
        img_bw(i,j) = 0;
    end
end
for i = 1:m
    for j = 1:4
        img_bw(i,j) = 0;
    end
end
for i = 1:m
    for j = n-4:n
        img_bw(i,j) = 0;
    end
end   
img_deal = bwareaopen(img_bw, 15);
figure;
imshow(img_deal);title('处理图');

split_img = split(img_deal);
figure;
imshow(split_img);title('分割后的图像');
word1 = imcrop(split_img,[1,1,13,m]);
split_img(:, 1: 13) = 0;
split_img = split(split_img);
% [word1,split_img] = split_word(split_img);
figure;
imshow(word1);title('1');
[word2,split_img] = split_word(split_img);
% word2 = imrotate(word2,-5,'nearest','crop');
figure;
imshow(word2);title('2');

[word3,split_img] = split_word(split_img);
figure;
imshow(word3);title('3');

[word4,split_img] = split_word(split_img);
figure;
imshow(word4);title('4');

[word5,split_img] = split_word(split_img);
figure;
imshow(word5);title('5');

[word6,split_img] = split_word(split_img);
figure;
imshow(word6);title('6');

[word7,split_img] = split_word(split_img);
figure;
imshow(word7);title('7');
%对每个分割的字符进行缩放
word1 = imresize(word1,[40,20]);
word2 = imresize(word2,[40,20]);
word3 = imresize(word3,[40,20]);
word4 = imresize(word4,[40,20]);
word5 = imresize(word5,[40,20]);
word6 = imresize(word6,[40,20]);
word7 = imresize(word7,[40,20]);
%缩放后的图像显示
figure;
subplot(1,7,1);imshow(word1);title('1');
subplot(1,7,2);imshow(word2);title('2');
subplot(1,7,3);imshow(word3);title('3');
subplot(1,7,4);imshow(word4);title('4');
subplot(1,7,5);imshow(word5);title('5');
subplot(1,7,6);imshow(word6);title('6');
subplot(1,7,7);imshow(word7);title('7');
%将图像存盘
imwrite(word1,'11.jpg'); 
imwrite(word2,'12.jpg');
imwrite(word3,'13.jpg');
imwrite(word4,'14.jpg');
imwrite(word5,'15.jpg');
imwrite(word6,'16.jpg');
imwrite(word7,'17.jpg');

%对每一个字符进行识别
distinguish_code = char(['0':'9' 'A':'Z' '京辽鲁陕苏豫浙贵晋蒙鄂云川']);

num = 1;
disp('识别结果');
for i = 1:7
    table = [];
    str = strcat('1',int2str(i));
    word = imread([str,'.jpg']);
    sub_word = imresize(word,[40,20],'nearest');
    sub_word =  im2bw(sub_word,0.5);
    if i == 1
        bottom = 37;
        top = 49;
    elseif i == 2
        bottom = 11;
        top = 36;
    elseif i >= 3
        bottom = 1;
        top = 36;
    end
    for k  = bottom : top
        dif = zeros(40,20);
        imgname = strcat(distinguish_code(k),'.jpg');
        imgdis = imread(imgname);
        imgdis = imresize(imgdis,[40,20]);
        imgdis = im2bw(imgdis,0.5);
        for r = 1:40
            for c = 1:20
                dif(r,c) = sub_word(r,c) - imgdis(r,c);
            end
        end
        dif_count = 0;
        for r = 1:40
            for c = 1:20
                if dif(r,c) ~= 0
                    dif_count = dif_count + 1;
                end
            end
        end
        
        table(k) = dif_count;
        if k == bottom
            min_index = k;
        elseif table(k) < table(min_index)
                min_index = k;
        end
    end
    disp(distinguish_code(min_index));
end