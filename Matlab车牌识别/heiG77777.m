clc;
clear;
clc;
clear;
f = imread('��G77777.jpg');
imshow(f);title('ԭͼ');
img_gray = rgb2gray(f);
figure;
imshow(img_gray);title('�Ҷ�ͼ');
hf = histeq(img_gray,512);
figure;
imshow(hf);title('���⻯ͼ');
hf = medfilt2(hf,[3,3]);
[t,sm] = graythresh(hf);
img_bw = im2bw(hf,t+0.27);
figure;
imshow(img_bw);title('��ֵͼ');
[r,c] = size(img_bw);
for i = 1:5
    for j = 1:c
        img_bw(i,j) = 0;
    end
end
figure;
imshow(img_bw);title('����ͼ��');
img = bwareaopen(img_bw, 4);
figure;
imshow(img);title('ͼ��');
split_img = split(img);
figure;
imshow(split_img);title('�ָ���ͼ��');
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
%��ÿ���ָ���ַ���������
word1 = imresize(word1,[40,20]);
word2 = imresize(word2,[40,20]);
word3 = imresize(word3,[40,20]);
word4 = imresize(word4,[40,20]);
word5 = imresize(word5,[40,20]);
word6 = imresize(word6,[40,20]);
word7 = imresize(word7,[40,20]);
%���ź��ͼ����ʾ
figure;
subplot(1,7,1);imshow(word1);title('1');
subplot(1,7,2);imshow(word2);title('2');
subplot(1,7,3);imshow(word3);title('3');
subplot(1,7,4);imshow(word4);title('4');
subplot(1,7,5);imshow(word5);title('5');
subplot(1,7,6);imshow(word6);title('6');
subplot(1,7,7);imshow(word7);title('7');
%��ͼ�����
imwrite(word1,'11.jpg'); 
imwrite(word2,'12.jpg');
imwrite(word3,'13.jpg');
imwrite(word4,'14.jpg');
imwrite(word5,'15.jpg');
imwrite(word6,'16.jpg');
imwrite(word7,'17.jpg');

%��ÿһ���ַ�����ʶ��
distinguish_code = char(['0':'9' 'A':'Z' '����³����ԥ�����ɶ���']);

num = 1;
disp('ʶ����');
for i = 1:7
    table = [];
    str = strcat('1',int2str(i));
    word = imread([str,'.jpg']);
    sub_word = imresize(word,[40,20],'nearest');
    sub_word =  im2bw(sub_word,0.5);
    if i == 1
        bottom = 37;
        top = 48;
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
