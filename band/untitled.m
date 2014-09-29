A=magnitude(y);
p=phase(y);
p=p';
A=A';
T=linspace(0,23.6,4097);
T=T';
a=A.*A;
E=intg(a,T);

 
Z=fft(y);
z=abs(Z);
z=z(1:end-1);
time=T(1:end-1);
w=frequency(p);
w=w';
answer=w.*z.*z;
term=intg(answer,time);
avg_w=term/E;
a=different(A,T);
a=a';
answer=a.*a;
B_am=intg(answer,time);
B_am=B_am/E;
a=A(1:end-1);

term= (w-avg_w).*(w-avg_w).*(a.*a);
B_fm=intg(term,time);
B_fm=B_fm/E;
B=sqrt(B_am + B_fm);
