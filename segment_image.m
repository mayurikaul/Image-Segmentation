% Image Segmentation
% Firstly, I convolved the grayscale image with a Gaussian filter. I did this to smooth the image 
% and remove noise. For the parameters of the Gaussian filter. I tried a few values for sigma 
% varying from 1-2 and used 6*sigma for the size parameter. I found that sigma=1.5 gave the best results. 
% I then experimented with various image segmentation techniques taught in class starting with 
% thresholding and then applying morphological operators. I also tried hierarchal agglomerative 
% clustering. However, I decided that given we want an algorithm that performs well on a variety of 
% images k-means clustering gave the best results. I tried a variety of values for k, ranging from 3-5 
% but found that k=3 performed the best. 
% I then performed canny edge detection. I used MatLabs graythresh() function  
% (https://uk.mathworks.com/help/images/ref/graythresh.html) to determine the threshold value for 
% the edge function. 
% After all of this, my algorithm performed okay but detected a lot of background noise and returned 
% many false positives. To counteract this, I tried many methods such as morphological methods - dilate, 
% erode, open, close. I also did some research (https://uk.mathworks.com/help/images/noise-removal.html) 
% and learned about median filtering for noise removal and the medfilt2 operation in MatLab. 
% I also researched (https://uk.mathworks.com/help/images/ref/bwareaopen.html) some image post-processing 
% techniques such as bwareaopen.  Out of these techniques, I found that bwareaopen with P=50 did the 
% best job of reducing the number of false positives. 
% My algorithm is defined below: 


function [seg] = segment_image(I)
    Ig = im2gray(I);
    g = fspecial("gaussian", 9, 1.5); 
    Ic = conv2(Ig, g, "same"); 
    Iseg = imsegkmeans(im2single(Ic), 3); 
    threshold = graythresh(Iseg); 
    ICanny = edge(Iseg,'canny', threshold); 
    seg = bwareaopen(ICanny, 50); 
    imagesc(seg), title('Segmented Image'); colormap('gray'); axis('equal', 'tight'); colorbar  
end
