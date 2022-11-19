%K-means indev HENRY François 20210792
%commencé le 04.11.2022

hold on

%importation des coordonnées

A   =   importdata('K_Means_Data_Base.xlsx');
A   =   A.data;
scatter(A(:,1),A(:,2),'blue','d',"filled")
s=size(A);
s=s(1,1);

%création des barycentres 1re gén.

k=6; %k correspond au nombre de bary voulu
bary = rand(k,2)*100;
scatter(bary(:,1),bary(:,2),'red','filled');

Pomme=zeros(k,s);
for j=1:k
    for i=1:s
        Pomme(j,i)=norm(A(i,:)-bary(j,:)); 
%Pomme = stockage des distances des coo. Par rapport aux barycentres
    end
end


%détermination du bary le plus proche de chaque points

Poire=zeros(1,k);
for b=1:k
    Poire(1,b)=b;    
end

    Karl=Pomme;
    %création du vecteur Karl(détermine quel point appartient à quel cluster)

    for l=1:10*k
        Banane=circshift(Poire,-l);
        for j=1:k
            for i=1:s 
                if Pomme(Poire(1,j),i)<Pomme(Banane(1,j),i)
                    Karl(Banane(1,j),i)=0;
                elseif Pomme(Poire(1,j),i)>Pomme(Banane(1,j),i)
                    Karl(Poire(1,j),i)=0;
                end
            end
        end 
    end

%création des barycentres

t=true;
while t
    for j=1:k
        for i=1:s
            Pomme(j,i)=norm(A(i,:)-bary(j,:)); 
    %Pomme = stockage des distances des coo. Par rapport aux barycentres
        end
    end

    %détermination du barycentre le plus proche de chaque points

    for b=1:k
        Poire(1,b)=b;    
    end

    Karl=Pomme;
    %création du vecteur Karl(détermine quel point appartient à quel barycentre)
    for l=1:10*k
        Banane=circshift(Poire,-l);
        for j=1:k
            for i=1:s 
                if Pomme(Poire(1,j),i)<Pomme(Banane(1,j),i)
                    Karl(Banane(1,j),i)=0;
                elseif Pomme(Poire(1,j),i)>Pomme(Banane(1,j),i)
                    Karl(Poire(1,j),i)=0;
                end
            end
        end 
       
    end
    
    %détermine l'emplacement des nouveaux barycentres
    bary2=zeros(k,2);
    count=0;
    for j=1:k
        for i=1:s
            if Karl(j,i)>0
            bary2(j,1)=bary2(j,1)+A(i,1);
            bary2(j,2)=bary2(j,2)+A(i,2);
            count=count+1;
            end
        end
        bary2(j,1)=bary2(j,1)/count;
        bary2(j,2)=bary2(j,2)/count;
        count=0;
    end
    scatter(bary2(:,1),bary2(:,2),'cyan','filled')
    for i=1:k
        if isnan(bary2(i,:))
            bary2(i,:)=inf;
        end
    end
        if bary2==bary
            t=false;
            scatter(bary2(:,1),bary2(:,2),'black','filled')
        else
            bary=bary2;
        end
    n=1;
    pause(n)
end

count=0;
for i=1:k
    if bary(i,:)<inf
        count=count+1;
    end
end

%colorisation des différents clusters
for j=1:count
    colours=zeros(s,2);
    s1=s;
    if Karl(j,:)==0
    else
        for i=1:s
            if Karl(j,i)==0
            else
                colours(i,:)=A(i,:);
            end
        end
    end
    i=1;
    while i<=s
        if colours(i,:)==0
            colours(i,:)=[];
            s=s-1;
        else
            i=i+1;
        end
    end
    scatter(colours(:,1),colours(:,2),'d','filled');
    s=s1;
    colours=zeros(s,2);
end

scatter(bary2(:,1),bary2(:,2),'black','filled') 
x=['Le nombre final de cluster est ',num2str(count), '.'];
disp(x)
