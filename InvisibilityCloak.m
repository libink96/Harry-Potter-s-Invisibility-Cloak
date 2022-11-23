cam = webcam
preview(cam);
%cam.Resolution = '1280x720';
background = snapshot(cam);
imshow(background);
cloth = capture_the_cloth(cam); % Don't know if it works
clothArea = cloth_detect(cloth);% Lost Here Onwards
background = clothArea 
cam = cam - clothArea + 
clear cam;