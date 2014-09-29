function [p]=phase(x)
size_of_signalp=numel(x);  
for n=1:size_of_signalp
    r=real(x(n));
    i=imag(x(n));
    p(n)=atan(i/r);
end
end
  