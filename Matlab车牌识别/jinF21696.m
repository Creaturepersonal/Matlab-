clc;
clear;
%读取图像
f = imread('晋F21696.jpg');
imshow(f);title('原图');
%灰度图
img1 = rgb2gray(f);
figure;
imshow(img1);title('灰度图');
%直方图均衡化
img2 = histeq(img1,256);
figure;
imshow(img2);title('直方图均衡化图像');
figure;
imhist(img2);title('均衡直方图');
%中值滤波
img3 = medfilt2(img2,[3 3]);
figure;
imshow(img3),title('中值滤波图像');
%图像二值化
img4 = im2bw(img3,0.76);
figure;
imshow(img4),title('二值图像');
%将面积小于50的部分移除
img5 = bwareaopen(img4, 50);
figure;
imshow(img5);title('移除面积小于50后的图像');
split_img = split(img5);
%将图像进行分割
[word1,split_img] = split_word(split_img);
figure;
imshow(word1);title('1');

[word2,split_img] = split_word(split_img);
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
distinguish_code = char(['0':'9' 'A':'Z' '京辽鲁陕苏豫浙贵晋']);

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
        top = 45;
    elseif i == 2
        bottom = 11;
        top = 36;
    elseif i >= 3
        bottom = 1;
        top = 10;
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
        %disp(table(k));
    end
    disp(distinguish_code(min_index));
end
%disp(iden(1));
% f = imread('F.jpg');
% f = split(f);
% f = imresize(f,[40,20]);
% imshow(f);title('f');
% imwrite(f,'f.jpg');





