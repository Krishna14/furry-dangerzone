function [I]=intg(y,t)
size_of_signali=max(size(y));
x=t;

I=0;
for n=1:(size_of_signali-1)
    l=x(n+1)-x(n);
    m=y(n+1)-y(n);
    if y(n+1)>y(n)
       I = I + l*y(n)+0.5*l*m;
    else
       I = I + l*y(n+1)-0.5*l*m; 
     end
end

end
