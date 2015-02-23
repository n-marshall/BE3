close all;
clear all;
% Lecture des donn�es
load csp

% Construction du tableau des fr�quences relatives
n=sum(sum(donnees));
Xf=donnees/n;

% Construction des tableaux des profils-lignes et des profils-colonnes
Xi=sum(Xf,1);
Xj=sum(Xf,2);

% Calcul des matrices X, M et D
% - X : matrice calcul�e � partir des fr�quences relatives et des fr�quences marginales
Xindep=repmat(Xi,size(Xf,1),1).*repmat(Xj,1,size(Xf,2));
X=Xf./Xindep-ones(size(Xf,1),size(Xf,2));
% - D : matrice des poids des profils-lignes
D=diag(Xj);
% - M : matrice des poids des profils-colonnes
M=diag(Xi);

% Calcul des axes factoriels et des valeurs propres associ�es
% - Pour les individus
[lambdaI,eI] = eig(X'*D*X*M);
eI=diag(eI);
[eI,eISortOrder]=sort(eI,'descend');
lambdaI=lambdaI(:,eISortOrder);
% - Pour les variables
[lambdaV,eV] = eig(X*M*X'*D);
eV=diag(eV);
[eV,eVSortOrder]=sort(eV,'descend');
lambdaV=lambdaV(:,eVSortOrder);

% Calcul des facteurs associ�s aux axes factoriels
% - Pour le nuage des profils-lignes
Fi=X*M*svi;
    Fi1=X*M*svi(:,1);
    Fi2=X*M*svi(:,2);
% - Pour le nuage des profils-colonnes
% Fv=X'*D*svi;
%     Fv1=X'*D*svv(:,1);
%     Fv2=X'*D*svv(:,2);


% Calcul des indices d�aide � l�interpr�tation des r�sultats de l�analyse factorielle :
% - Le pourcentage d�inertie associ� � chaque axe (afficher le diagramme des valeurs propres)
% - La contribution des profils-lignes et des profils-colonnes pour chaque axe
% - La qualit� de repr�sentation des profils-lignes et des profils-colonnes pour chaque axe


% Visualisation des r�sultats (par soucis de simplification, on ne s�int�ressera qu�au premier plan factoriel)
% - Projeter les profils-lignes sur le premier plan factoriel
x=[min(Fi1):0.01:max(Fi1)];
y=[min(Fi2):0.01:max(Fi2)];
figure
plot(x,0,0,y,Fi1,Fi2,'x');

% - Projeter les profils-colonnes sur le premier plan factoriel
%         x=[-1:0.01:1];
%         cercleUnite(1,:) = sqrt(1-x.^2);
%         cercleUnite(2,:)=-cercleUnite(1,:);
%         figure
%         plot(x,0,0,x,x,cercleUnite,Fi1,Fi2,'x');
%         axis([-1.2 1.2 -1.2 1.2]);
%         axis equal
%         gname(noms_modalites2{1:6});

% Interpr�tation des r�sultats
% - Donner une interpr�tation aux deux premiers facteurs
% - R�aliser une typologie des profils-lignes
% - R�aliser une typologie des profils-colonnes
% - Peut-on lier ces deux typologies ?