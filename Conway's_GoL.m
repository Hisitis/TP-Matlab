%création du plateau de jeu
%Diego est passé par là
q   =   input('taille du plateau? : ');

n   =   input('pourcentage de cellules vivantes ? : ');
n2  = (100-n)/100;
cells   =   rand(q,q)   >  n2;
newcells    =   cells;

%déroulement de la partie
spy(cells); drawnow
while true
    for i=2:q-1
        for j=2:q-1
            v   =   sum(sum(cells(i-1:i+1, j-1:j+1)))-cells(i,j);
                disp(v)
                if v == 3
                    newcells(i,j)=1;
                elseif v==2
                    newcells(i,j)=cells(i,j);
                else
                    newcells(i,j)=0;
                end
        end
    end
    cells=newcells;
    spy(cells); drawnow
end
