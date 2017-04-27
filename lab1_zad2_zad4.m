clear all; 
close all; 
clc
image=imread('xray.jpg');
%imageGreyscale=im2double(image);
imageGray = rgb2gray(image);

%wektor z poziomami ciêcia
L = 0.1:0.05:1;
%zliczenie iloœci pikseli dla poziomu ciêcia
for i=1:length(L)
    BW = im2bw(imageGray, L(i));
    counter(i) = sum(BW(:));
    %BW3 = imcomplement(BW);
    counter1(length(L)-(i-1)) = counter(i);
end

    %zrobienie masek i wyœwietlenie w innym colormap
    mask1 = im2bw(imageGray, 0.3);
    figure
    imshow(mask1, 'Colormap', Jet);
    pause
    mask2 = im2bw(imageGray, 0.6);
    figure
    imshow(mask2, 'Colormap', Autumn);
    pause
    mask3 = im2bw(imageGray, 0.8);
    figure
    imshow(mask3, 'Colormap', Copper);
    pause
    
    %na³o¿enie masek na obraz grayscale
    C1=imageGray.*uint8(mask1);
    figure
    imshow(C1);
    C2=imageGray.*uint8(mask2);
    figure
    imshow(C2);
    C3=imageGray.*uint8(mask3);
    figure
    imshow(C3);
%wyœwietlenie zale¿noœci iloœci pikseli od poziomu ciêcia    
figure, hold on
plot(L,counter);
plot(L,counter1);


%----------------------------------------------
%zadanie 4

%finding lines
BWx = edge(imageGray, 'canny'); 
%BWx = edge(mask1, 'canny');
figure 
imshow(BWx);
[H, theta, rho] = hough(BWx);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:)))); % 5 lines
%if less than 5 px gap between lines - merge, minimum length of the line 8
%px
lines = houghlines(BWx, theta, rho, P, 'FillGap', 5, 'MinLength', 8); 

figure
imshow(image), hold on

for k=1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2), 'LineWidth',3,'Color','red');
end

%znajdowanie kó³
Rmin = 10;
Rmax = 100;
%-------------------------------------------------------------
%working on matlab2016R
%threshold = graythresh(imageGray);
%BW1 = im2bw(imageGray, threshold);


%figure
%imshowpair(gray, BW1, 'montage');
%[centers, radii] = imfindcircles(BW1, [Rmin Rmax]);

%figure
%imshow(image);
%viscircles(centers, radii, 'Color', 'r');
%--------------------------------------------------------------

%drawing circles by using hough transformation
%radii = 15:1:40;
%h = circle_hough(BWx, radii, 'same', 'normalise');
%peaks = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', 10);

%figure
%imshow(image);
%hold on;
%for peak = peaks
%   [x,y] = circlepoints(peak(3));
%   plot(x+peak(1), y+peak(2), 'g-');
%end
%hold off