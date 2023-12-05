% Ce document est accessible aux assistants Jean Clement et Julien Bouchat. Il est dans votre intérêt de ne pas le copier.
% Ce programme est ma propriété. Copier ce document pourrait entraîner des conséquences sérieuses que vous ne devriez pas négliger.
% Cordialement,
% HENRY François

%test Bataille navale

clc
clear
close all

n=10;

merIA=zeros(n);

t=0;
c=0;

while t < 4

    if t==0
        b=4;
        t=t+1;
    elseif t==1
        b=3;
        t=t+1;
    elseif t==2
        b=2;
        c=c+1;
        if c==2
            t=t+1;
        end
    elseif t==3
        b=1;
        t=t+1;
    end

S=randi([0,1]);
Coo=[];
a=1;

if S==0

    for i=1:n
        for j=1:n
       
            if merIA(i,j)==0
            
                Coo(a,1)=i;
                Coo(a,2)=j;
                a=a+1;

            end
        
        end
    end

    q=true;
    while q

        l=randi([1,length(Coo)-b]);
        d=0;

        if Coo(l,1)==Coo(l+1,1) && Coo(l,2)+1==Coo(l+1,2)
            for i=0:b-1
            
                if Coo(l+i,1)==Coo(l+i+1,1) && Coo(l+i,2)+1==Coo(l+i+1,2)
                    d=d+1;
                end
        
            end
        end
        if d==b
            q=false;
        end
    end

    for i=0:b
        merIA(Coo(l+i,1),Coo(l+i,2))=1;
        
        if Coo(l,1) > 1
        
           merIA(Coo(l+i,1)-1,Coo(l+i,2))=-1; 

        end
        if Coo(l,1) < n
        
           merIA(Coo(l+i,1)+1,Coo(l+i,2))=-1; 

        end
        if l-1 >= 1
            if Coo(l-1,1) >= 1 && Coo(l-1,1) == Coo(l,1)
              
               merIA(Coo(l-1,1),Coo(l-1,2))=-1; 
    
            end
        end
        if l+b+1 <= length(Coo)
            if Coo(l+b+1,1) <= n && Coo(l+b+1,1) == Coo(l+b,1)  
    
               merIA(Coo(l+b+1,1),Coo(l+b+1,2))=-1; 
    
            end
        end
    end

elseif S==1

    for i=1:n
        for j=1:n
       
            if merIA(j,i)==0
            
                Coo(a,1)=j;
                Coo(a,2)=i;
                a=a+1;

            end
        
        end
    end

    q=true;
    while q

        l=randi([1,length(Coo)-b]);
        d=0;

        if Coo(l,2)==Coo(l+1,2) && Coo(l,1)+1==Coo(l+1,1)
            for i=0:b-1
            
                if Coo(l+i,2)==Coo(l+i+1,2) && Coo(l+i,1)+1==Coo(l+i+1,1)
                    d=d+1;
                end
        
            end
        end
        if d==b
            q=false;
        end
    end

    for i=0:b
        merIA(Coo(l+i,1),Coo(l+i,2))=1;
        
        if Coo(l,2) > 1
        
           merIA(Coo(l+i,1),Coo(l+i,2)-1)=-1; 

        end
        if Coo(l,2) < n
        
           merIA(Coo(l+i,1),Coo(l+i,2)+1)=-1; 

        end
        if l-1 >= 1
            if Coo(l-1,2) >= 1 && Coo(l-1,2) == Coo(l,2)
              
               merIA(Coo(l-1,1),Coo(l-1,2))=-1; 
    
            end
        end
        if l+b+1 <= length(Coo)
            if Coo(l+b+1,2) <= n && Coo(l+b+1,2) == Coo(l+b,2)  
    
               merIA(Coo(l+b+1,1),Coo(l+b+1,2))=-1; 
    
            end
        end
    end
end


end

for i=1:n
    for j=1:n
        if merIA(i,j)==-1
            merIA(i,j)=0;
        end
    end
end

% Visualize the grid
%imagesc(merIA)
imshow(merIA, 'InitialMagnification', 'fit');
title('Distribution of Ships');
