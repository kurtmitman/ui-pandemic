function qt=weektomonth(x)
    T=floor(length(x)/4);
    qt=zeros(T,1);
    for t=1:T
        qt(t)=mean(x(4*(t-1)+1:4*t));
    end
    
