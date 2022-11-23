function clothArea = cloth_detect(cloth,cam)
% Takes a whole image of the cloth only
%   Detailed explanation goes here
cloth = double(cloth);

red_cloth = cloth(:,:,1);
green_cloth = cloth(:,:,2);
blue_cloth = cloth(:,:,3);

total_cloth = red_cloth + green_cloth + blue_cloth;
sample_red = red_cloth ./total_cloth;
sample_red(isnan(sample_red)) = 0;
sample_green = green_cloth ./ total_cloth;
sample_green(isnan(sample_green)) = 0;

g_mean = mean (sample_green);
g_std = std(sample_green);
r_mean = mean(sample_red);
r_std = std(sample_red);
%lost from here onwards
clothArea = detect_skin_rg(cam,r_mean,r_std,g_mean,g_std); %supposed to apply filter while camera is operating
%But got no idea how
end