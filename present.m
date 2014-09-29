files = dir('*.txt');
numfiles = length(files);
mydata = cell(1, numfiles);
results_abvag = zeros(5,2);
%results_novag = zeros(5,2);
abvag_1 = load('abvag10');
abvag_2 = load('abvag11');
abvag_3 = load('abvag12');
abvag_4 = load('abvag13');
abvag_5 = load('abvag14');

novag_1 = load('novag10');
novag_2 = load('novag11');
novag_3 = load('novag12');
novag_4 = load('novag13');
novag_5 = load('novag14');

novag = [novag_1 novag_2 novag_3 novag_4 novag_5];
abvag = [abvag_1 abvag_2 abvag_3 abvag_4 abvag_5];

Fs = 2000; %173.61 Hz
%T = 1;
%The input signal derived from the dataset
for i=1:5
    l = abvag(:,i);
    len = length(l);
    %Forming the time-scale for sampling the signal
    Ts = 1/Fs;
    t1 = 0:1:(len-1);
    %subplot(3,1,1);
    %plot(l);
    %subplot(3,1,2);
    %y=stem(t1,l);
    %y = l(Ts*t1);
    %plot(y)
    
    %Order for the fgl_deriv function
    order=[-0.15,-0.3,-0.45];
    %order = -0.30;
    Q=length(order);
    %This is the output of the Grunwald-Letnikow Approximation
    for i=1:Q
        Ix(:,i)=fgl_deriv(order(i),l,Fs);
    end
    size(Ix);
    delta = Ix;
    %Y=Ix';
    %size(Y)
    
    %rho= zeros(size(Y,1),1);
    %delta = [];
    
    %for i=1:Q
    %    rho(i) = Y(i);
    %    delta = [delta rho(i)];
    %end
    
    inv = (delta'*delta)^(-1);
    g=(inv*delta'*l);
    size(g)
    
    %Reconstruction of the signal
    predict = (Ix*g);
    %plot(t1,predict);
    size(Ix)
    size(predict)
    
    %Calculating the error, Well It was simple :P
    error = (l - predict);
    %subplot(3,1,3);
    %plot(t1,error,'b');
    
    energy_signal = abs(l).^(2);
    sig_energy = sum(energy_signal)
    energy_error = abs(error).^(2);
    error_energy = sum(energy_error)
    
    ratio = error_energy/sig_energy;
    results_abvag(i,:) = [sig_energy error_energy];
end

    
%[X, Y]=meshgrid(t1,order);
%mesh(X,Y,Ix)
%xlabel('t'); ylabel('\alpha'); zlabel('y');

   
    
