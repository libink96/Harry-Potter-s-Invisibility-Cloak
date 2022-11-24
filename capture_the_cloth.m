function clothImage = capture_the_cloth()
cam = webcam
preview(cam);
tempImage = imread('template.gif');
background = snapshot(cam);
imshow(background);figure("Name","background");
previousPic = snapshot(cam);
basePic = snapshot(cam);
gesture = 1;
while gesture ~= 0
    [t,s] = title('Show cloak to camera.', 'Make sure it covers the whole camera.');
    nextPic = snapshot(cam);
    motionPic = motion_detect(previousPic,basePic,nextPic);
    filteredImage = canny4(motionPic,1.4,1.35,4,8); %find edge gradients
    outlineImage = gradient_orientations(filteredImage);% find edges
    imageMoments = hu_moment1(outlineImage); % image moments
    templateMoments = hu_moment1(tempImage);
    diffMoment = vecnorm(imageMoments - templateMoments); %matches despite size,orientation, or location
    threshold = 0.0001 % haven't tested the value to see if it works
    if diffMoment < threshold
        title('Cheese!');
        pause(3); %hope it pauses for 3 seconds
        capture = snapshot(cam);
        gesture = 0;
    end

    previousPic = basePic;
    basePic = nextPic;
end
clothImage = capture;
imshow(clothImage);figure("Name","Captured Image");
end