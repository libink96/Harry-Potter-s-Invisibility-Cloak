function outPic = motion_detect(prePic,curPic,nextPic)
greyImage = read_gray(curPic);
greyImage2 = read_gray(prePic);
greyImage3 = read_gray(nextPic);

diff1 = abs(greyImage - greyImage2);
diff2 = abs(greyImage - greyImage3);
motion = min(diff1,diff2);


threshold = 10;
thresholdImage = (motion > threshold); %makes an image that blacks out background to 0
imdilate(thresholdImage,ones(3,3));


[label,number] = bwlabel(thresholdImage,8);
counters = zeros(1,number);
for i = 1:number
    % for each i, we count the number of pixels equal to i in the labels
    % matrix
    % first, we create a component image, that is 1 for pixels belonging to
    % the i-th connected component, and 0 everywhere else.
    component_image = (label == i);
    
    % now, we count the non-zero pixels in the component image.
    counters(i) = sum(component_image(:));
end
    
% find the id of the largest component
[area, id] = max(counters);    
outPic = (label == id);


end