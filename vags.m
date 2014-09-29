function vags(~)
    %Fs = 173.61; %173.61 Hz
    fnam = input('Enter the vag file name :','s');
    fid = fopen(fnam);
    vags = fscanf(fid,'%f ');
    Fs = 2000; %sampling rate
    sze = length(vags);
    time = [1 : sze]/Fs;
    figure;
    subplot(3,1,1);
    plot(time,vags);
    title('VAG Signal');
    ylabel('VAG');
    xlabel('Time in seconds');
    axis tight;
    
    %Order for the fgl_deriv function
    order=[-0.15,-0.3,-0.45];
    %order = -0.45;
    Q=length(order);
    %This is the output of the Grunwald-Letnikow Approximation
    for i=1:Q
        Ix(:,i)=fgl_deriv(order(i),vags,1/Fs);
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
    size(inv);
    g=((inv*delta')*vags);
    size(g);
    
    %Reconstruction of the signal
    predict = (Ix*g);
    subplot(3,1,2);
    plot(time,predict);
    title('Predicted Signal');
    xlabel('Samples');
    ylabel('Amplitude');
    axis tight;
    %set(gca,'FontSize',12);
    %size(Ix)
    %size(predict)
    
    %scale = Ix./predict;
    %predict = scale.*predict;
    error = (vags - predict);
    subplot(3,1,3);
    plot(time,error);
    title('Error in prediction');
    xlabel('Samples');
    ylabel('Amplitude');
    axis tight;
    %plot(time,vags,time,predict,'--',time,error,':');
    %hold on;
    %plot(time,predict,'--');
    %hold on;
    %plot(time,error,':');
    %[X, Y]=meshgrid(t1,order);
    %mesh(X,Y,Ix)
    %xlabel('t'); ylabel('\alpha'); zlabel('y');

    %Ix=fgl_deriv(order,y,Fs);
    %size(Ix);
    %Y = Ix';
    %xlabel('t'); ylabel('\alpha'); zlabel('y');
end


