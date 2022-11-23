function clothImage = capture_the_cloth(cam)
tempImage = imread('template.gif');
previousPic = snapshot(cam);
basePic = snapshot(cam)
gesture = false
while gesture == false
    nextPic = snapshot(cam);
    motionPic = motion_detect(previousPic,basePic,nextPic);
    filteredImage = canny4(motionPic,1.4,1.35,4,8); %find edge gradients
    outlineImage = gradient_orientations(filteredImage);% find edges
    imageMoments = hu_moment1(outlineImage); % image moments
    templateMoments = hu_moment1(tempImage);
    diffMoment = vecnorm(imageMoments - templateMoments); %matches despite size,orientation, or location
    threshold = 0.0001 % haven't tested the value to see if it works
    if diffMoment < threshold
        pause(3); %hope it pauses for 3 seconds
        clothImage = snapshot(cam);
        gesture = true;
    end

    previousPic = basePic;
    basePic = nextPic;
end

end