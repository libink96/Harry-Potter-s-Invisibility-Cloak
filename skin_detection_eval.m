function [area1,area2, area3] = skin_detection_eval()
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
trainA = double(imread("training_A.bmp"));
negative_histogram = read_double_image('negatives.bin');
positive_histogram = read_double_image('positives.bin');
A_red = trainA(:,:,1);
A_green = trainA(:,:,2);
A_blue = trainA(:,:,3);


test = double(imread("test.bmp"));

 

trainB = double(imread("training_B.bmp"));

B_red = trainB(:,:,1);
B_green = trainB(:,:,2);
B_blue = trainB(:,:,3);




patch1_Ared = (A_red(122:150,297:338));
patch2_Ared = (A_red(246:265,117:145));
patch1_Agreen = (A_green(122:150,297:338));
patch2_Agreen = (A_green(246:265,117:145));
patch1_Ablue = (A_blue(122:150,297:338));
patch2_Ablue = (A_blue(246:265,117:145));


patch1_Bred = (B_red(189:230,213:293));
patch2_Bred = (B_red(376:423,63:120));
patch3_Bred = (B_red(413:471,404:455));
patch1_Bgreen = (B_green(189:230,213:293));
patch2_Bgreen = (B_green(376:423,63:120));
patch3_Bgreen = (B_green(413:471,404:455));
patch1_Bblue = (B_blue(189:230,213:293));
patch2_Bblue = (B_blue(376:423,63:120));
patch3_Bblue = (B_blue(413:471,404:455));

patch1_Ared = patch1_Ared(:);
patch2_Ared = patch2_Ared(:);
patch1_Agreen = patch1_Agreen(:);
patch2_Agreen = patch2_Agreen(:);
patch1_Ablue = patch1_Ablue(:);
patch2_Ablue = patch2_Ablue(:);


patch1_Bred = patch1_Bred(:);
patch2_Bred = patch2_Bred(:);
patch3_Bred = patch3_Bred(:);
patch1_Bgreen = patch1_Bgreen(:);
patch2_Bgreen = patch2_Bgreen(:);
patch3_Bgreen = patch3_Bgreen(:);
patch1_Bblue = patch1_Bblue(:);
patch2_Bblue = patch2_Bblue(:);
patch3_Bblue = patch3_Bblue(:);



patch_Ared = [patch1_Ared' patch2_Ared'];
patch_Agreen = [patch1_Agreen' patch2_Agreen'];
patch_Ablue = [patch1_Ablue' patch2_Ablue'];

patch_Atotal = patch_Ared + patch_Agreen + patch_Ablue;

patch_Ared = patch_Ared./patch_Atotal;
patch_Ared(isnan(patch_Ared)) = 0;
patch_Agreen = patch_Agreen./patch_Atotal;
patch_Agreen(isnan(patch_Agreen)) = 0;


patch_Bred = [patch1_Bred' patch2_Bred' patch3_Bred'];
patch_Bgreen = [patch1_Bgreen' patch2_Bgreen' patch3_Bgreen'];
patch_Bblue = [patch1_Bblue' patch2_Bblue' patch3_Bblue'];

patch_Btotal = patch_Bred + patch_Bgreen + patch_Bblue;

patch_Bred = patch_Bred./patch_Btotal;
patch_Bred(isnan(patch_Bred)) = 0;

patch_Bgreen = patch_Bgreen./patch_Btotal;
patch_Bgreen(isnan(patch_Bgreen)) = 0;






mean_Ared = mean(patch_Ared);
mean_Agreen = mean(patch_Agreen);


mean_Bred = mean(patch_Bred);
mean_Bgreen = mean(patch_Bgreen);




std_Ared = std(patch_Ared);
std_Agreen = std(patch_Agreen);


std_Bred = std(patch_Bred);
std_Bgreen = std(patch_Bgreen);





skin3 = detect_skin(test,positive_histogram,negative_histogram);
skin1 = detect_skin_rg(test,mean_Ared,std_Ared,mean_Agreen,std_Agreen);
skin2 = detect_skin_rg(test,mean_Bred,std_Bred,mean_Bgreen,std_Bgreen);
skin2 = skin2 >0.1;
imshow(skin1,[]);figure('Name',"skin1");
imshow(skin2,[]);figure('Name',"skin2");
imshow(skin3,[]);figure('Name',"skin3");

min1 = min(skin1(:));
max1 = max(skin1(:));
max2 = max(skin2(:));
threshold = (max1-min1)/20;


tp1 = zeros(20);tn1 = zeros(20); tn2 = zeros(20);tp2 = zeros(20);tp3 = zeros(20);tn3=zeros(20);
j =1;
for i = 0 :0.05 : 1
   [tp1(j),tn1(j)] = eval_threshold(skin1,i*max1);
   [tp2(j),tn2(j)] = eval_threshold(skin2,i*max2);
   [tp3(j),tn3(j)] = eval_threshold(skin3,i);
   j= j+1;
    
end

area1 = compute_auc(tp1(:),tn1(:))

area2 = compute_auc(tp2(:),tn2(:))
imshow(area2,[]);figure('Name',"area")
area3 = compute_auc(tp3(:),tn3(:))



end