function [f]=frequency(p)
size_of_signalf=max(size(p));
t=linspace(0,23.6,size_of_signalf);
f=different(p,t);

end