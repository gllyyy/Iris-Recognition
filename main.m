function [img2, featureVector] = main(img)
close all
global GRAY
global RED
global BLUE
global GREEN
GRAY = 4;
RED = 1;
BLUE = 3;
GREEN = 2;

directory = dir('*.png');
%for i = 1 : size(directory,1)
   
    
    % Read in original iris image
    imgs(:,:,GRAY) = rgb2gray(img);
    imgs(:,:,RED)  = img(:,:,RED);
    imgs(:,:,BLUE) = img(:,:,BLUE);
    imgs(:,:,GREEN) = img(:,:,GREEN);
  
    
    [ row, column, radius ] = findPupilSizeAndLocation( img );
    [radius_2 ] = findScleraSizeAndLocation( img,row,column );
    height = size(img,1)/2;
    width = (size(img,2)/2);
    dist = max(height,width);
    H = [1 0;
        0 1;
        -column+width -row+height;];
    T = maketform('affine',H);
    bounds = findbounds(T,[1 1; [size(img,2) size(img,1)]]);
    img_m = imtransform(img,T,'XData',[1 size(img,2)],'YData',[1 size(img,1)]);
    %imtool(img_m);
    
    
    min_size = min(height*2,width*2);
    
    r1 = floor(height-min_size/2)+1;
    c1 = floor(width-min_size/2)+1;
    r2 = floor(height+min_size/2);
    c2 = floor(width+min_size/2);
 
    
    img_x = img_m(r1:r2,c1:c2,:);
    %imtool(img_x);
    min_size = min_size/2;
    img2 = ImToPolar(img_x,radius/min_size,radius_2/min_size,(radius_2-radius)*2,(radius_2-radius)*2*pi);
    imtool(uint8(img2));
    
    % perform feature extraction
    featureVector = extractFeatures(img2);
    
    % display stuff
    imtool(reshape(featureVector / max(featureVector), 255, 96));
end