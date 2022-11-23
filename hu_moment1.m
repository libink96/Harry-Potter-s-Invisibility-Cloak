function result = hu_moment1(shape)
n20 = normalized_moment(shape,2,0);
n02 = normalized_moment(shape,0,2);
n11 = normalized_moment(shape,1,1);
n30 = normalized_moment(shape,3,0);
n12 = normalized_moment(shape,1,2);
n21 = normalized_moment(shape,2,1);
n03 = normalized_moment(shape,0,3);


r1 = n20 + n02;
r2 = (n20 - n02)^2 + (2 * n11)^2;
r3 = (n30 - 3 * n12)^2 + ((3 * n21) - n03)^2;
r4 = (n30 + n12)^2 + (n21 + n03)^2;
r5 = (n30 - 3 * n12)*(n30 +n12)*((n30+n12)^2 - 3 * (n21 + n03)^2) + ((3 * n21) - n03) * (n21 +n03)*((3 * (n30 + n12)^2) -(n21 + n03)^2);
r6 = (n20 - n02) * ((n30 +n12)^2 - (n21+n03)^2) + 4 * n11*(n30 + n12)*(n21 +n03);
r7 = (3 * n21 - n03) * (n30 + n12) * ((n30 + n12)^2 - 3 * (n21 +n03)^2) - (n30 - 3 *n12) * (n21 + n03) * (3 * (n30 + n12)^2 - (n21 + n03)^2);

r1 = sign(r1)*log(r1);
r2 = sign(r2)*log(r2);
r3 = sign(r3)*log(r3);
r4 = sign(r4)*log(r4);
r5 = sign(r5)*log(r5);
r6 = sign(r6)*log(r6);
r7 = sign(r7)*log(r7);
result = [r1 r2 r3 r4 r5 r6 r7];
end