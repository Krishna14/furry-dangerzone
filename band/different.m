function [d]=different(y,t)
size_of_signald=max(size(y));
x=t;


for n=1:(size_of_signald-1)
    d(n)=(y(n+1)-y(n))/(x(n+1)-x(n));
end
 
 
end