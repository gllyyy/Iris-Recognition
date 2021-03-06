function [ row, column, radius ] = findPupilSizeAndLocation( img )
%FINDPUPILCENTER Summary of this function goes here
%[ row, column, radius ] = findPupilSizeAndLocation( img )
%   Detailed explanation goes here
% PUPIL_THREASHOLD = .14;
% PUPIL_THREASHOLD2 = .25;
% img_hsv = rgb2hsv(img);
% imtool(img_hsv);
% value = img_hsv(:,:,3);
% 
% 
% mask = zeros(size(img,1),size(img,2));
% 
% mask(find(value<PUPIL_THREASHOLD)) = 1;
% 
% 
% mask = imopen(mask,strel('square',7));
% mask = clean_Pupil(mask);
% %imtool(mask);
% [r c] = find(mask==1);
% 
% centroidInRowDirection = ones(1,length(r))*r / length(r);
% centroidInColDirection = ones(1,length(c))*c / length(c);
% 
% row = centroidInRowDirection;
% column = centroidInColDirection;
% max_r = max(r);
% min_r = min(r);
% max_c = max(c);
% min_c = min(c);
% 
% radius_r = (max_r-min_r)/2;
% radius_c =(max_c - min_c) / 2;
% 
% radius =( radius_r + radius_c )/ 2;
imshow(img);

fprintf('select 4 points along the edge of the pupil that are not next to',...
    'each other. ideal distance between points is ?/2');

a = impoint(gca);
pt1 = getPosition(a);


a = impoint(gca);
pt2 = getPosition(a);


a = impoint(gca);
pt3 = getPosition(a);


a = impoint(gca);
pt4 = getPosition(a);

A = [pt1(1) pt2(1) pt3(1) pt4(1)];
B = [pt1(2) pt2(2) pt3(2) pt4(2)];

column = sum(A)/4;
row = sum(B)/4;



radius1 = sqrt((pt1(1) - column)^2 + (pt1(2) - row)^2);
radius2 = sqrt((pt2(1) - column)^2 + (pt2(2) - row)^2);
radius3 = sqrt((pt3(1) - column)^2 + (pt3(2) - row)^2);
radius4 = sqrt((pt4(1) - column)^2 + (pt4(2) - row)^2);


radius = (radius1 + radius2 + radius3 + radius4) / 4;


end

