%K-means indev HENRY François 20210792
%commencé le 04.11.2022

hold on

%importation des coordonnées

A   =   importdata('K_Means_Data_Base.xlsx');
A   =   A.data;
scatter(A(:,1),A(:,2),'blue','d',"filled")
s=size(A);
s=s(1,1);

%création des clusters

k=6; %k correspond au nombre de cluster voulu
cluster = rand(k,2)*100;
scatter(cluster(:,1),cluster(:,2),'red','filled');

Pomme=zeros(k,s);
for j=1:k
    for i=1:s
        Pomme(j,i)=norm(A(i,:)-cluster(j,:)); 
%Pomme = stockage des distances des coo. Par rapport aux clusters
    end
end


%détermination du cluster le plus proche de chaque points

Poire=zeros(1,k);
for b=1:k
    Poire(1,b)=b;    
end

Karl=Pomme;
%création du vecteur Karl(détermine quel point appartient à quel cluster)

for j=1:k
    Banane=circshift(Poire,-j);
    for i=1:s 
        if Pomme(Poire(1,j),i)<Pomme(Banane(1,j),i)
            Karl(Banane(1,j),i)=0;
        elseif Pomme(Poire(1,j),i)>Pomme(Banane(1,j),i)
            Karl(Poire(1,j),i)=0;
        end
    end
end 

%création des barycentres 1re génération

bary=zeros(2,k);
count=0;
for j=1:k
    for i=1:s
        if Karl(j,i)>0
           bary(1,j)=bary(1,j)+A(i,1);
           bary(2,j)=bary(2,j)+A(i,2);
           count=count+1;
        end
    end
    bary(1,j)=bary(1,j)/count;
    bary(2,j)=bary(2,j)/count;
    count=0;
end
scatter(bary(1,:),bary(2,:),'yellow','filled')

%Certains barycentre peuvent avoir des coordonées indéterminées, si ça
%arrive,ses coordonnées sont déterminées comme étant (inf,inf)
for i=1:k
    if isnan(bary(:,i))
       bary(:,i)=inf;
    end
end

%création des barycentre de Ne génération

Pom=zeros(k,s);
t=true;
while t
    for j=1:k
        for i=1:s
            Pom(j,i)=norm(A(i,:)-bary(:,j)); 
    %Pom = stockage des distances des coo. Par rapport aux barycentres
        end
    end

    %détermination du barycentre le plus proche de chaque points

    for b=1:k
        Poire(1,b)=b;    
    end

    Kar=Pom;
    %création du vecteur Kar(détermine quel point appartient à quel barycentre)

    for j=1:k
        Banane=circshift(Poire,-j);
        for i=1:s 
            if Pom(Poire(1,j),i)<Pom(Banane(1,j),i)
                Kar(Banane(1,j),i)=0;
            elseif Pom(Poire(1,j),i)>Pom(Banane(1,j),i)
                Kar(Poire(1,j),i)=0;
            end
        end
    end 

    %détermine l'emplacement des nouveaux barycentres
    bary2=zeros(2,k);
    count=0;
    for j=1:k
        for i=1:s
            if Kar(j,i)>0
            bary2(1,j)=bary2(1,j)+A(i,1);
            bary2(2,j)=bary2(2,j)+A(i,2);
            count=count+1;
            end
        end
        bary2(1,j)=bary2(1,j)/count;
        bary2(2,j)=bary2(2,j)/count;
        count=0;
    end
    scatter(bary2(1,:),bary2(2,:),'cyan','filled')
    for i=1:k
        if isnan(bary2(:,i))
            bary2(:,i)=inf;
        end
    end
        if bary2==bary
            t=false;
            scatter(bary2(1,:),bary2(2,:),'black','filled')
        else
            bary=bary2;
        end
    n=1;
    pause(n)
end

count=0;
for i=1:k
    if bary(:,i)<inf
        count=count+1;
    end
end

%colorisation des différents clusters
for j=1:k
    colours=zeros(s,2);
    s1=s;
    if Kar(j,:)==0
    else
        for i=1:s
            if Kar(j,i)==0
            else
                colours(i,:)=A(i,:);
            end
        end
    end
    scatter(colours(:,1),colours(:,2),'d','filled');
end

scatter(bary2(1,:),bary2(2,:),'black','filled')
disp(count) 
disp(' est le nombre final de barycentres.')
