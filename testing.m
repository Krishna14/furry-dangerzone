% Sample the EEG Signal with f = 173.61 Hz
function testing(myData);
    Fs = 173.61; %173.61 Hz
    %T = 1;
    %The input signal derived from the dataset
    l = myData(:,1);
    len = length(l);
    
    %Forming the time-scale for sampling the signal
        Ts = 1/Fs;
        t1 = 0:1:(len-1);
        subplot(3,1,1);
        plot(l);
        subplot(3,1,2);
        y=stem(t1,l);
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
    
        size(delta);
        inv = (delta'*delta)^(-1);
        g=(inv*delta'*l);
        size(g)
    
        %Reconstruction of the signal
        predict = (Ix*g);
        plot(t1,predict);
        size(Ix)
        size(predict)
    
        %Calculating the error, Well It was simple :P
        error = (l - predict);
        subplot(3,1,3);
        plot(t1,error,'b');
    
        energy_signal = abs(l).^(2);
        sig_energy = sum(energy_signal)
        energy_error = abs(error).^(2);
        error_energy = sum(energy_error)
    
        ratio = error_energy/sig_energy;
    %[X, Y]=meshgrid(t1,order);
    %mesh(X,Y,Ix)
    %xlabel('t'); ylabel('\alpha'); zlabel('y');
        
    
    %Ix=fgl_deriv(order,y,Fs);
    %size(Ix);
    %Y = Ix';
    %xlabel('t'); ylabel('\alpha'); zlabel('y');
end

