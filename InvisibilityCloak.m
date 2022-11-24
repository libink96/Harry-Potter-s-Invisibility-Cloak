cam = webcam;
preview(cam);
%cam.Resolution = '1280x720';
background = snapshot(cam);
imshow(background);
%cloth = capture_the_cloth(cam); % Don't know if it works
cloth = double(imread("cloth.jpg"));
[g_mean, g_std, r_mean, r_std] = cloth_detect(cloth);
for i = 1:750
    clip = double(snapshot(cam));
    clothArea = detect_skin_rg(clip,r_mean,r_std,g_mean,g_std);
   % layout = clothArea >= 
   % cloak = background(layout)
    invisible = clip - clothArea + cloak;
    imshow(invisible);
   
end
clear cam;