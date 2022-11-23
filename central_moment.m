function result = central_moment(shape,i,j)
[row , col] = size(shape);
moment = raw_moment (shape,i,j);
area = raw_moment(shape,0,0);

centerx = raw_moment(shape,1,0)/area;
centery = raw_moment(shape,0,1)/area;
M = 0;
for x = 1:row
    for y = 1:col
        M = M + (((x - centerx)^i) * ((y - centery) ^j)) * shape(x,y);
    end
end
result = M;
end