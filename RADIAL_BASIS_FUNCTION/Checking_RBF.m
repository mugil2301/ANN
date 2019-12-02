% to check the neural net
I0=[0 1];%for this input
t0=1;%desired output
p0=zeros(h,1);
for i0=1:h
        temp01=c(i0,:);
        temp0=I0-temp01;
        p0(i0,1)=exp(-(temp0*temp0'));
end
b0=-1;
p0=[p0' b0];
O=w'*p0';
display(O);