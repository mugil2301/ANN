pnts=[54,54,37,41,2,7,25,22,18,4,13,18,24,25,44,41,45,58,62,82,91,83,71,64,68,83,87,74,71,58;
      67,62,84,94,99,64,62,60,54,50,40,40,42,38,35,26,21,35,32,7,38,46,44,60,58,69,76,78,71,69];
  
s = size(pnts);
city = s(1,2);
position = city;
D = zeros(city,city); % D = distance matrix
for i=1:city-1
    D(i,i) = 0;
    for j = i+1:city
        D(i,j) = sqrt((pnts(2,j)-pnts(2,i))^2 + (pnts(1,j)-pnts(1,i))^2);
        D(j,i) = D(i,j);
    end
end

St = [0,0,0,0,0,0];
p = 130;
b = 120;
T = 400;
epoch = 100;
R = 0.5;
for i=1:city
    W(i,i) = b;
    for j=i+1:city
        W(i,j) = -p;
        W(j,i) = W(i,j);
    end
end

valid  = 0;
res_arr = zeros(1,city);
min_dist = intmax;
f_dist = 0;
for z = 1:epoch
    dist = 0;
    del_c = 0;
    x=0;y=0;
    U = zeros(city,city);
    W = zeros(city,city);
    num=0;
    o = 0;
    for l = 1:city
            if(x == 0)
                o = o+1;
                x = randi([1,city],1,1);
                y = randi([1,city],1,1);
                
            else
                num = num+1;
                while((f_row(U(x,:),1) > 0) + (f_col(U(:,y),1) > 0) >= 1)
                    x = randi([1,city],1,1);
                    y = randi([1,city],1,1);
                end
            end
            U(x,y) = 1;
    end
    for i = 1:city
            j = f_row(U(i,:),1);
            j_prev = 1;
            j_next = 1;
            i_prev = 1;
            i_next = 1;
            if(j==1)
                j_prev = city;
                j_next = j+1;
            elseif j==city
                j_prev = j-1;
                j_next = 1;
            else
                j_prev = j-1;
                j_next = j+1;
            end
            i_prev = f_col(U(:,j_prev),1);
            i_next = f_col(U(:,j_next),1);
            del_c = b -(D(i,i_prev)+D(i,i_next));
            
            A = 1/(exp(-1*del_c/T));
            if(A < R)
                U(i,j) = 0;
                valid = 0;
                break;
            
            else
                valid = 1;
            end
        end
    
    if(valid == 1)
        %Storing the order of journey
        tmp = zeros(1,city);
        for j = 1:city
            i = f_col(U(:,j),1);
            tmp(1,j) = i;
        end
        %calculating distance
        for i=1:city-1
            tmp1 = tmp(1,i);
            tmp2 = tmp(1,i+1);
            dist = dist + D(tmp1,tmp2);
        end
        dist = dist + D(tmp(1,city),tmp(1,1));
        if(dist  < min_dist)
            min_dist = dist;
            res_arr = tmp;
            f_dist = dist;
        end
    end
    T = 0.95*T;   
end
labels=cellstr(num2str(res_arr'));
labels1=cellstr(num2str([1:30]'));
subplot(1,2,1)
hold on
grid on
    title('Initial points on the axis');
    plot(pnts(1,:),pnts(2,:),'rx');
    text(pnts(1,:),pnts(2,:),labels1);
    axis([0 100 0 100])
subplot(1,2,2)
 hold on
 grid on
    title('Order of traversal');
    plot(pnts(1,:),pnts(2,:),'rx');
    text(pnts(1,:),pnts(2,:),labels);
    axis([0 100 0 100]);
display(f_dist);
display(res_arr);
display('Finished');