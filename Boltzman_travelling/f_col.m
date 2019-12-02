function y = f_col(c_arr,k)
s = size(c_arr);
n = s(1,1);
y=0;
for i=1:n
    if(c_arr(i,1) == k)
        y=i;
        break;
    end
end
end