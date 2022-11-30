function skin_detection = detect_skin_rg(img, r_mean, r_std, g_mean, g_std)
%DETECT_SKIN_RG This function returns P(rg | skin)

[rows, cols, bands] = size(img);

skin_detection = zeros(rows, cols);

for row = 1:rows
    for col = 1:cols
        red = double(img(row, col, 1));
        green = double(img(row, col, 2));
        blue = double(img(row, col, 3));
    
        sum = red+green+blue;
        if sum > 0
            r = red / sum;
            g = green / sum;
        else
            r = 0;
            g = 0;
        end
        
        r_prob = gaussian_probability(r_mean, r_std, r);
        g_prob = gaussian_probability(g_mean, g_std, g);
        prob = r_prob * g_prob;
        skin_detection(row, col) = prob;
    end
end

end

