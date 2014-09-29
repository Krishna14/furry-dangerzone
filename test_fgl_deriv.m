%Test Case for the fgl_deriv code
%Enter the inputs here 
%p - Order of the fractional derivative
%y - Sampled function
%h - Period of the sampling lattice
%Q - Number of orders to be present in the signal
%x(n) - Input signal

%Output 
%Y : Fractional Derivative estimate given the sampled signal
%sum = zeros(length(x));
%p_k = -1.*p;

clear all;
close all;
Q=3;
h=0.01;
t=0:h:2*pi;
y=sin(t);
order=[-0.15,-0.3,-0.45];
%Enter the order values in the array set for order 
%uncomment the following lines
%Here Enter an order that's positive
%if order > 0
%    order = -1.*order; 
for i =1:Q
    Ix(i,:)=fgl_deriv(order(i),y,h);
end
%plot(t,Ix);

Y=Ix';
size(Y)

rho= zeros(size(Y,1),1);
delta = [];
for i=Q
    rho(i) = Y(i);
    delta = [delta rho(i)];
end

size(delta)
size(y)
g=(((delta)'.*delta)^-1).*delta'.*y;
size(g)

[X, Y]=meshgrid(t,order);
mesh(X,Y,Ix)
xlabel('t'); ylabel('\alpha'); zlabel('y');
