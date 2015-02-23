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
[eI,lambdaI] = eig(X'*D*X*M);
lambdaI=diag(lambdaI);
[lambdaI,eISortOrder]=sort(lambdaI,'descend');
eI=eI(:,eISortOrder);
% - Pour les variables
[eV,lambdaV] = eig(X*M*X'*D);
lambdaV=diag(lambdaV);
[lambdaV,eVSortOrder]=sort(lambdaV,'descend');
eV=eV(:,eVSortOrder);

% Calcul des facteurs associ�s aux axes factoriels
% - Pour le nuage des profils-lignes
Fi=X*M*eI;
    Fi1=Fi(:,1);
    Fi2=Fi(:,2);
% - Pour le nuage des profils-colonnes
Fv=X'*D*eV;
    Fv1=Fv(:,1);
    Fv2=Fv(:,2);


% Calcul des indices d�aide � l�interpr�tation des r�sultats de l�analyse factorielle :
% - Le pourcentage d�inertie associ� � chaque axe (afficher le diagramme des valeurs propres)
v=lambdaI/sum(lambdaI)*100;
figure;
stem(v);
xlim([0 7]);
gname(num2str(v));
% - La contribution des profils-lignes et des profils-colonnes pour chaque axe
% - - Pour les profils-lignes
ContributionI1=D*(Fi1.*Fi1)/(Fi1'*D*Fi1);
ContributionI2=D*(Fi2.*Fi2)/(Fi2'*D*Fi2);
% - - Pour les profils-colonnes
ContributionV1=M*(Fv1.*Fv1)/(Fv1'*M*Fv1);
ContributionV2=M*(Fv2.*Fv2)/(Fv2'*M*Fv2);
% - La qualit� de repr�sentation des profils-lignes et des profils-colonnes pour chaque axe
% - - Pour les profils-lignes
distCarre=repmat(sum(X.*X,2),1,size(X,2))
Qualite=Fi.*Fi./distCarre % les r�sultats sont tr�s faibles et je ne comprends pas pourquoi, j'ai essay� de faire Q=(OHi)�/(Oi)� comme dans le cours
% - - Pour les profils-colonnes

% Visualisation des r�sultats (par soucis de simplification, on ne s�int�ressera qu�au premier plan factoriel)
% - Projeter les profils-lignes sur le premier plan factoriel
x=[min(Fi1):0.01:max(Fi1)];
y=[min(Fi2):0.01:max(Fi2)];
figure; hold on;
% axis auto;
% plot(x,0,0,y,'-'); % je n'arrive pas � tracer les axes en trait plein et �a m'�nerve...
plot(Fi1,Fi2,'x');
gname(noms_modalites1);
% - Projeter les profils-colonnes sur le premier plan factoriel
x=[min(Fv1):0.01:max(Fv1)];
y=[min(Fv2):0.01:max(Fv2)];
figure;
plot(Fv1,Fv2,'x');
gname(noms_modalites2);


% Interpr�tation des r�sultats
% - Donner une interpr�tation aux deux premiers facteurs
% - R�aliser une typologie des profils-lignes
% - R�aliser une typologie des profils-colonnes
% - Peut-on lier ces deux typologies ?