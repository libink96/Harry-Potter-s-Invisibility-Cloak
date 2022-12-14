function [g_mean g_std r_mean, r_std] = cloth_detect(cloth,clip)
% Takes a whole image of the cloth only
%   Detailed explanation goes here

red_cloth = cloth(:,:,1);
green_cloth = cloth(:,:,2);
blue_cloth = cloth(:,:,3);

red_cloth = red_cloth(360:620,400:1000);
blue_cloth = blue_cloth(360:620,400:1000);
green_cloth = green_cloth(360:620,400:1000);

total_cloth = red_cloth + green_cloth + blue_cloth;
sample_red = red_cloth ./total_cloth;
sample_red(isnan(sample_red)) = 0;
sample_green = green_cloth ./ total_cloth;
sample_green(isnan(sample_green)) = 0;

g_mean = mean (sample_green(:));
g_std = std(sample_green(:));
r_mean = mean(sample_red(:));
r_std = std(sample_red(:));
end
