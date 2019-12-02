function y = f_row(r_arr,k)
s = size(r_arr);
n = s(1,2);
y=0;
for i=1:n
    if(r_arr(1,i) == k)
        y=i;
        break;
    end
end
end