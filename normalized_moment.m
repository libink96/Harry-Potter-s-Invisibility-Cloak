function result = normalized_moment(shape,i,j)

if(i +j)>= 2
    result = central_moment(shape,i,j)/(central_moment(shape,0,0)^(1 + (i+j)/2));
else
    result = central_moment(shape,i,j)/central_moment(shape,0,0);
end
end