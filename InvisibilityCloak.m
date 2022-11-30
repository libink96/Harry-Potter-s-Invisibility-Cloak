cam = webcam;

pause(3);
background = snapshot(cam);
imshow(background);
%cloth = capture_the_cloth(cam); % Don't know if it works
pause(5);
cloth = snapshot(cam);
figure();imshow(cloth);
cloth = double(cloth);
[g_mean, g_std, r_mean, r_std] = cloth_detect(cloth);
for i = 1:350
   clip = snapshot(cam);
   clothArea = detect_skin_rg(clip,r_mean,r_std,g_mean,g_std); 
   bw = imbinarize(clothArea);

for i = 1:size(bw,1)
    for j = 1:size(bw,2)
        if (bw(i,j)==1)
            clip(i,j,:) = background(i,j,:);
        end
    end
end

% ind = find(bw == 1);
% [row, col] = ind2sub(size(bw),ind);
% clip(row,col,:) = background(row,col,:);
   imshow(clip);
end
clear cam;