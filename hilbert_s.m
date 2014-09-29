function hilbert_s1 = hilbert_s (x, qResol, qResid)

dbstop if warning
if(nargin~=3), error('rParab__L: Use with 3 inputs.'), end
if(nargout>1), error('rParab__L: Use with just one output.'), end
kc = x(:);                                                                  % get copy of the input signal
plot(kc);
figure;
W= kc'*kc;                                                                  % Original signal energy
Length = length(kc);                                                        % Signal length
hilbert_s1 = [];                                             % Matrix which will contain the successive IMFs, and the residue
rParabCnt= 0;
qDbResid= 0;                                                                % Equal energies at start
getext= getext_s(kc);                                                       % Total number of maximas and minimas
while ((qDbResid<qResid) && (getext>2) )                                    % Loop to decompose the input signal into successive IMFs
    y1 = kc;                                                                % at the beginning of the sifting process, y1 is the signal
    getmax= getmax_s(y1);                                                   % getmax= [xM(M), yM(M)];
    getmin= getmin_s(y1); 
    bTenv= spline(getmax(:,1), getmax(:,2), 1:Length);                      %  Top envelop: bTenv[n];
    bDenv= spline(getmin(:,1), getmin(:,2), 1:Length);                      % Down envelop: bDenv[n];
    bBias= (bTenv+bDenv)/2;                                                 % First bias estimate
    while true(1)                                                           % Inner loop to find each IMF
        WImf= y1'*y1;                                                       % Current IMF  energy
        WBias= bBias*bBias';                                                % Bias energy
        if WBias*WImf<0 ,end %warning('rParab__L: Ooops, negative energy detected.'), end
        if WBias> 0, DbqResol= 10*log10(WImf/WBias); else DbqResol= Inf; end
        if (DbqResol>qResol),  break, end                                   % Resolution reached
                                                                            % Resolution not reached. More work is needed
        y1 = y1-bBias';                                                     % Subtract bias from y1
        getmax= getmax_s(y1);                                               % getmax= [xM(M), yM(M)];
        getmin= getmin_s(y1);                                               % getmin= [xm(m), ym(m)];
    
        bTenv= spline(getmax(:,1), getmax(:,2), 1:Length);                  % Top envelop: bTenv[n];
        bDenv= spline(getmin(:,1), getmin(:,2), 1:Length);                  % Down envelop: bDenv[n];
        bBias= (bTenv+bDenv)/2;                                             % New bias estimate
    end 
    hilbert_s1 = [hilbert_s1;y1'];                                                  % Store the extracted rParab in the matrix rParab
     kc = kc - y1;                                                            % Subtract the extracted rParab from the signal
     getext= getext_s(kc);
   rParabCnt=rParabCnt+1;
   if (kc'*kc)>0
        qDbResid= 10*log10(W/(kc'*kc));
   else
       qDbResid = Inf;
   end
    
end 
if ((kc'*kc)/W)>(10^-12)
    hilbert_s1=[hilbert_s1; kc'];      
    rParabCnt=rParabCnt+1;
   
end
hilbert_s1= hilbert_s1';
 for i = 1:rParabCnt
  plot(hilbert_s1(:,i));
   figure;
  end

 
end
function getext = getext_s(x)

y=0;    qisTop= false; qisDown= false;
for i=2:(length(x)-1)
    if( ((x(i-1)) < (x(i))) && ((x(i+1))< (x(i))) )                        %Max /-\
        y=y+1;
    end
    if( ((x(i-1)) > (x(i))) && ((x(i+1))> (x(i))) )                        %min \_/
        y=y+1;
    end
%Top
    if( ((x(i-1)) < (x(i))) && ((x(i+1))== (x(i))) )                       %StepL /-
         qisTop= true; qisDown= false;
         
    end
    if( ((x(i-1)) == (x(i))) && ((x(i+1))< (x(i))) )                       %stepR -\
       if qisTop;     y=y+1; end;
        qisTop= false;
    end
    
%Downs   
    if( ((x(i-1)) > (x(i))) && ((x(i+1))== (x(i))) )                       %stepL \_
        qisTop= false; qisDown= true;
      
    end
    if( ((x(i-1)) == (x(i))) && ((x(i+1))> (x(i))) )                       %StepR _/
        if qisDown; y=y+1; end
        qisDown=false;
   end
end
getext= y;
end

function getmax= getmax_s(aS)
coder.extrinsic('getmax_s');
kS= aS(:);
quntLenS=length(kS); 
quntMaxCnt=0;
kSMNdx1=[]; kSMVal=[];                                                     % Signal S Maxima indices and values
if (quntLenS>2)                                                                               
    for Cnt=2:(quntLenS-1) 
        if ( ((kS(Cnt) > kS(Cnt+1))) && ((kS(Cnt) >= kS(Cnt-1))) || ((kS(Cnt) >= kS(Cnt+1))) && ((kS(Cnt) > kS(Cnt-1))) )
            quntMaxCnt=quntMaxCnt+1;
            kSMNdx1= [kSMNdx1; Cnt];  kSMVal=[kSMVal; kS(Cnt)];
        end
    end
end
kSMNdx1=[1;kSMNdx1]; kSMVal=[kS(1);kSMVal];
kSMNdx1=[kSMNdx1;quntLenS]; kSMVal=[kSMVal;kS(end)];
getmax= sortrows([kSMNdx1,kSMVal]);
end

function getmin= getmin_s(aS)         
coder.extrinsic('getmin_s');
kS= aS(:);
quntLenS=length(kS); 
quntMinCnt=0;
kSMNdx1=[]; kSMVal=[];                                                     % Signal S Minima indices and values
if (quntLenS>2)     
    for Cnt=2:(quntLenS-1)  
        if ( ((kS(Cnt) < kS(Cnt+1))) && ((kS(Cnt) <= kS(Cnt-1))) || ((kS(Cnt) <= kS(Cnt+1))) && ((kS(Cnt) < kS(Cnt-1))) )
            quntMinCnt=quntMinCnt+1;
            kSMNdx1= [kSMNdx1; Cnt];  kSMVal=[kSMVal; kS(Cnt)];
        end
    end
end
kSMNdx1 = [1;kSMNdx1]; kSMVal = [kS(1);kSMVal];
kSMNdx1 = [kSMNdx1;quntLenS]; kSMVal = [kSMVal;kS(end)];
getmin= sortrows([kSMNdx1, kSMVal]);
end

