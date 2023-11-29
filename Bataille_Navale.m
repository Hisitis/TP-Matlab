%projet bataille navale

clc
clear
close all

%n = input('Quelle taille de plateau souhaitez-vous ? : ')
n = 10;

MerIA = zeros(n)


%generation du premier bateau

x = randi([1,n]);
y = randi([1,n]);

MerIA(x,y)  = 1

%S = randi([1,2])
S = 1;

if S  ==  1 %vertical

  if x  <= n-5

    for i=0:4

      MerIA(x+i,y)  = 1;

      if y > 1

              MerIA(x+i,y-1)  = -1;

      end
      MerIA(x+i,y+1)  = -1;


    end
     MerIA(x+i+1,y)  = -1;

    if x  > 1
            MerIA(x-1,y)  = -1;
    end

  elseif x >= n-5

    for i=0:4

      MerIA(x-i,y)  = 1;

      if y > 1

              MerIA(x-i,y-1)  = -1;

      end
      MerIA(x-i,y+1)  = -1;


    end
     MerIA(x-i-1,y)  = -1;

    if x  < n
            MerIA(x+1,y)  = -1;
    end

  end

end

  k=1;
  z=1;

  for i=1:n
    for j=1:n

      if MerIA(i,j)==0
        Coo1(k,1)=i;
        Coo1(k,2)=j;
        k=k+1;
      endif
      if MerIA(j,i)==0
        Coo2(z,1)=i;
        Coo2(z,2)=j;
        z=z+1;
      endif

    endfor
  endfor

l = randi([1,length(Coo1)]);

x = Coo1(l,2)
y = Coo1(l,1)

%Coo1 horizontal


%S = randi([1,2])
S = 2;

if S  ==  2 %horizontal

  for i=0:3

    if

  endfor

end

imagesc(MerIA)
