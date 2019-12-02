%RBF optimization to make XOR points linearly seperable
I=[0 0 1 1;
   0 1 0 1];
do=[0 1 1 0];
Is=4;
h=2;
c=[0 0;
   1 1];
p=zeros(Is,h);
for i=1:h
    for j=1:Is
        temp=I(:,j);
        temp1=c(i,:);
        temp=temp-temp1';
        p(j,i)=exp(-(temp'*temp));
    end
end
b=ones(Is,1)*(-1);
p=[p b];
w=(((p'*p)^(-1))*p')*do';
subplot(1,2,1)
hold on
for z=1:Is
    title('Points before RBF optimization');
    plot(I(1,z),I(2,z),'*');
    axis([-1 2 -1 2]);
end
pp=p;
pp(:,3)=[];
subplot(1,2,2)
hold on
for z=1:Is
    title('Points after RBF optimization');
    plot(pp(z,1),pp(z,2),'*');
    axis([-1 2 -1 2]);
end