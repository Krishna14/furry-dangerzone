function [a]=magnitude(x)
size_of_signal=max(size(x));  
for n=1:size_of_signal
    r=real(x(n));
    i=imag(x(n));
    a(n)=sqrt(r*r + i*i);%abs(x(n))
end
end
  