clc;
clear;
f = imread('兰A20008.jpg');
f = imrotate(f,-1,'nearest','crop');
imshow(f);title('原图');
img = rgb2gray(f);
% img = histeq(img,512);
img = tofloat(img);
figure;
imshow(img);title('灰度图');
w = fspecial('average',5);
img1 = imfilter(img,w,'replicate');
% img1 = medfilt2(img,[7,7]);
figure;
imshow(img1);title('均值滤波');
[t,sm] = graythresh(img1);
% ibw = im2bw(img1,t-0.005);
ibw = im2bw(img1,t);
ibw = ~ibw;
figure;
imshow(ibw);title('二值图');
img2 = bwareaopen(ibw, 150);
figure;
imshow(img2);title('移除面积小于200后的图像');
% split_img = split(img2);


[m,n] = size(img1);
xmin = 1;
xmax = n;
ymin = 1;
ymax = m;
while img2(:,xmin) == 1
    img2(:,xmin) = 0;
    xmin = xmin + 1;
end
for x = 1:m
    for y = 1:n
        if img2(x,y) == 1
            img2(x,y) =0;
        else
            break;
        end
    end
end
for x = m:1
    for y = n:1
        if img2(x,y) == 1
            img2(x,y) =0;
        else
            break;
        end
    end
end
figure;
imshow(img2);title('dsl');
% disp(sum(img2(:,10)));
% disp(sum(img2(ymin,:)));

while sum(img2(:,xmin)) >= m -100 && xmin < n
    xmin = xmin+1;
    if sum(img2(:,xmin)) == m - 100 
        break;
    end
end
while sum(img2(:,xmax)) >= m - 100 && xmax > 1
    xmax = xmax - 1;
    if sum(img2(:,xmax)) == m - 100 
        break;
    end
end
while sum(img2(ymin,:)) >= n - 100 && ymin < n
    ymin = ymin+1;
    if sum(img2(ymin,:)) == n - 100
        break;
    end
end
while sum(img2(ymax,:)) >= n - 100 && ymax > 1
    ymax = ymax - 1;
    if sum(img2(ymax,:)) == n - 100
        break;
    end
end
xmin = xmin + 5;
xmax = xmax - 5;
ymin = ymin + 5;
ymax = ymax -5;
width = xmax - xmin;
height = ymax - ymin;
imgc = imcrop(img2,[xmin,ymin,width,height]);
figure;
imshow(imgc);title('裁剪');
imgc = bwareaopen(imgc, 50);
[r,c] = size(imgc);
for i = 1:26
    for j = 1:c
        imgc(i,j) = 0;
    end
end
split_img = split(imgc);
figure;
imshow(split_img);title('分割后的图像');
% [L, num] = bwlabel(split_img,8);
% [r,c] = size(L);
% for i = 1:r
%     for j = 1:c
%         if L(r,c) < 20
%             split_img(r,c) = 0;
%         end
%     end
% end
width = 0;
[x,y] = size(split_img);
% while sum(split_img(:,width + 1)) >=0 && width+1<=n
%     width  = width +1;
%     
% end
% for i = 1:n
%     for j = 1:m
%        if  split_img(j,i) <= 50 && 
[word1,split_img] = split_word(split_img);
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
distinguish_code = char(['0':'9' 'A':'Z' '京辽鲁陕苏豫浙贵晋蒙兰']);

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
        top = 47;
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
    end
%     tablemin = min(table);
%     find_index = find(table(1,:) == tablemin);
%     imgname1 = strcat(distinguish_code(max(find_index)),'.jpg');
%     imgdis1 = imread(imgname1);
%     imgdis1 = imresize(imgdis1,[40,20]);
%     imgdis1 = im2bw(imgdis1,0.5);
    %disp(max(find_index))
%     disp(find_index)
    %iden(i) = distinguish_code(max(find_index));
    %disp(iden(i));
%     disp(distinguish_code(max(find_index)));
    disp(distinguish_code(min_index));
end

