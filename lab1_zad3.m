clear all;
close all;
clc

image = imread('krolik.jpg');
gray = rgb2gray(image);
%in order to use imadjust properly, all values in image cells must be in [0
%1]
gray1 = im2double(gray);


figure
imshow(gray);
rectangle1 = getrect; %rectangle is a vector [xmin ymin width height]
%rectangle1 = imcrop(gray, rectangle);
xmin = uint8(rectangle1(1,1));
ymin = uint8(rectangle1(1,2));
width = uint8(rectangle1(1,3));
height = uint8(rectangle1(1,4));

%changing the value of contrast on photo
   gray1(ymin:ymin+height , xmin:xmin+width) = imadjust(gray1(ymin:ymin+height , xmin:xmin+width), [0.4 0.7], [0 1]); 
imshow(gray1);
