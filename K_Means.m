%K-means alpha 1.0.0 HENRY François 20210792
%commencé le 04.11.2022
%fini le 20.11.2022

hold on

%importation des coordonnées

A   =   importdata('K_Means_Data_Base.xlsx');
A   =   A.data;
scatter(A(:,1),A(:,2),'blue','d',"filled")
s=size(A);
s=s(1,1);

%création des barycentres 1re gén.

p=20;
elbow=zeros(p,1);
for k=1:p
%k correspond au nombre de barycentres voulus    

    bary = rand(k,2)*100;
    %scatter(bary(:,1),bary(:,2),'red','filled');

    Pomme=zeros(k,s);
    t=true;
    while t
        for j=1:k
            for i=1:s
                Pomme(j,i)=norm(A(i,:)-bary(j,:)); 
        %Pomme = stockage des distances des coo. Par rapport aux barycentres
            end
        end

        %détermination du barycentre le plus proche de chaque points

        Karl=Pomme;
        %création du vecteur Karl(détermine quel point appartient à quel cluster)
        for j=1:k
            for i=1:s 
                if not(Pomme(j,i)==min(Pomme(:,i)))
                    Karl(j,i)=inf;
                else
                    Karl(j,i)=Pomme(j,i);
                end
            end
        end 

        %détermine l'emplacement des nouveaux barycentres
        bary2=zeros(k,2);
        count=0;
        for j=1:k
            for i=1:s
                if Karl(j,i)<inf
                    bary2(j,1)=bary2(j,1)+A(i,1);
                    bary2(j,2)=bary2(j,2)+A(i,2);
                    count=count+1;
                end
            end
            bary2(j,1)=bary2(j,1)/count;
            bary2(j,2)=bary2(j,2)/count;
            count=0;
        end
        %scatter(bary2(:,1),bary2(:,2),'cyan','filled')
        
        i=1;
        while i<=k
            if isnan(bary2(i,:))
                bary2(i,:) = rand(1,2)*100;
            else
                i=i+1;
            end
        end
        if bary2==bary
            t=false;
        else
            bary=bary2;
        end
            pause(0.05)
    end

    %colorisation des différents clusters
    for j=1:k
        colours=zeros(s,2);
        s1=s;
        if Karl(j,:)==inf
        else
            for i=1:s
                if Karl(j,i)==inf
                   colours(i,:)=inf;
                else
                    colours(i,:)=A(i,:);
                end
            end
        end
        i=1;
        while i<=s
            if colours(i,:)==inf
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

    %scatter(bary2(:,1),bary2(:,2),'black','filled') 
    disp(k)

    Marc=zeros(1);
    for j=1:k
        for i=1:s
            if Karl(j,i)<inf
                Marc(1,1)=Marc(1,1)+(Karl(j,i)^2);
            end
        end
    end
    elbow(k,1)=Marc(1,1);
end
figure(2); plot(elbow);
