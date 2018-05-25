function [ q ] = pixel2point( p , Rc_ext, Tc_ext, Tr_ext, KK )
%[ q ] = pixel2point( p )
%pixel2point transforma un punt de de la imatge a un punt de l'espai.
%Se suposa una calibracio previa tant dels parametres intrinsecs com dels
%extrinsecs.
%Un punt de l'espai esta representat per tres coordenades q=(x,y,z)
%La notacio esta treta de la seccio 2.1 del Computer Vision: Algorithms and
%Applications (Szeliski, 2010). Algunes expressions surten d'alla i
%d'altres de la toolbox de calibracio
%
%INPUT
%   p: coordenades (xx,yy) del punt p a la imatge de la camera
%   Rc_ext: matriu de rotacio externa segons la torna la toolbox de
%   calibracio
%   Tc_ext: vector de traslacio extern segons el torna la toolbox de
%   calibracio
%   Tr_ext: vector de traslacio del centre de coordenades on es fa la
%   calibracio repecte el centre de coordenades del robotino
%   KK: matriu de calibracio dels parametres intrinsecs (mes comunment
%   anomenada matriu de la camera)
%OUTPUT
%   q: coordenades (x,y,z) d'un punt de l'espai referides als eixos
%   centrats en el punt mig del robotino, tocant a terra.

%% Primera transformacio
% Es transforma p a coordenades homogenies per facilitar les següents
% transformacions

if size(p,2)==2
    p=p';
end
if size(p,1)~=2 || size(p,2)~=1
    return
end
p = [p;1];


%% Calcul de la matriu de rotacio i el vector de traslacio
% Cal anar en compte per obtenir R i t doncs Rc_ext i Tr_ext estan definits
% diferentment i no tenen el mateix significat.

theta = -90;
n=[0,0,1];
nx = [0,-n(3),n(2);n(3),0,-n(1);-n(2),n(1),0];
R = eye(3,3)+sind(theta)*nx+(1-cosd(theta))*nx^2;  % matriu de rotacio d'un
                        % punt 90 graus antihoraris sobre l'eix Z. R' ens
                        % permet rotar els eixos de coordenades de com
                        % estan al robot a com estan en la calibracio
trotat = R'*Tr_ext;     % Tr_ext es el vector que va del centre del robot a
                        % l'origen de coordenades de la calibracio 

% la seguent operacio es equivalent a
% TrasRot = [Rc_ext Tc_ext;[0 0 0 1]]*[R' [0;0;0]; [0,0,0,1]]*[eye(3,3) -Tr_ext;[0 0 0 1]];
TrasRot = [Rc_ext Tc_ext;[0 0 0 1]]*[R' -trotat; [0,0,0,1]]; % en canvi, la
                        % toolbox de calibracio ja ens dona Rc_ext i Tc_ext
                        % perque els puguem utilitzar directament a la
                        % matriu de traslacio+rotacio

R = TrasRot(1:3,1:3);
t = -R'*TrasRot(1:3,4);
z = R'*inv(KK)*p;       % aqui falta un
lamda = 0-t(3)/z(3);
q = t + lamda*R'*inv(KK)*p;
