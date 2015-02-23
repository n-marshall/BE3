clear all
close all

% Lecture des donn�es
load villes
X=donnees(:,1:12);

% Calcul de la matrice des distances entre chaque paire d��l�ments de cet ensemble de donn�es (en
% utilisant la fonction Matlab � pdist �)
Y=pdist(X);     %On calcule le vecteur des distances avec par d�faut une distance euclidienne
Ymat=squareform(Y)   %On repr�sente le r�sultat sous forme de matrice

% Construction de l�arbre hi�rarchique par agr�gations successives de deux �l�ments (un utilisant la
% fonction � linkage �)
Z=linkage(Y)    %Trois colonnes : dans les deux premi�res on affiche l'indice des �l�ments qui seront agr�g�s
                % la troisi�me affiche la distance entre les �l�ments li�s et l'indice de niveau
figure, dendrogram(Z);

% Coupure de l�arbre hi�rarchique pour obtenir une partition (en utilisant la fonction � cluster �)
C=cluster(Z,1:15)
nbClasses=max(C);
colors=['b','r','g','m','c','y','k','o'];
figure
plot(X(:,1),X(:,2),'ok');
gname(noms_individus);
hold on
for i=1:nbClasses
    ind=find(C==i)
    plot(X(ind,1),X(ind,2),strcat(colors(i),'x'))
end