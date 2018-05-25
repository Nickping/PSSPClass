function [d1,d2,theta]=WhereAmI(CameraId,Rc_ext, Tc_ext, KK )
% clc
while exist('img')~=1%(prod(1.0*ismember('img',[W(:).name])))
     if ~(Camera_setStreaming(CameraId, 1) == 1)
        disp('Camera_setStreaming failed.');
     end;

     if (Camera_grab(CameraId) == 1)
        img = Camera_getImage( CameraId );
     end;
     pause(.001);
%      W=evalin('base','whos');
end;
ImatgeYCbCr=rgb2ycbcr(img);
ImatgeBN=im2bw(ImatgeYCbCr(:,:,3),.53);
ElementEstructurantV = strel('rectangle',[50,2]);% A les dimensions del rectangle, primer files, despr√©s columnes
ImatgeErosionadaV=imerode(ImatgeBN,ElementEstructurantV);
ElementEstructurantH = strel('rectangle',[2,120]);% A les dimensions del rectangle, primer files, despr√©s columnes
ImatgeErosionadaH=imerode(ImatgeBN,ElementEstructurantH);
% Es troben els punts per a la dist√†ncia d1 del robot a la l√≠nia vertical i
% per l'angle theta
x1=1;
y1a=[];
y1b=[];
while (isempty(y1a) && x1<240)
    y1a=find(ImatgeErosionadaV(x1,:)==1,1,'first');
    y1b=find(ImatgeErosionadaV(x1,:)==1,1,'last');
    x1=x1+5;
end
y1=round(0.5*(y1a+y1b));
x2=240;
y2a=find(ImatgeErosionadaV(x2,:)==1,1,'first');
y2b=find(ImatgeErosionadaV(x2,:)==1,1,'last');
while (isempty(y2a) && x2>0)
    y2a=find(ImatgeErosionadaV(x2,:)==1,1,'first');
    y2b=find(ImatgeErosionadaV(x2,:)==1,1,'last');
    x2=x2-5;
end
y2=round(0.5*(y2a+y2b));
% Ara es realitza el producte vectorial 
if ( ~isempty(y1) && ~isempty(y2) )
    p1imatge=[y1,x1];
    p2imatge=[y2,x2];
    [ p1robot ] = pixel2point( p1imatge , Rc_ext, Tc_ext, [-62.7 477.9 0]', KK );
    [ p2robot ] = pixel2point( p2imatge , Rc_ext, Tc_ext, [-62.7 477.9 0]', KK );
    V=cross([p1robot(1:2);1],[p2robot(1:2);1]);
    Vnormalitzat=V./sqrt(V(1)^2+V(2)^2);
    d1=Vnormalitzat(3);
    theta=atan2d(Vnormalitzat(1),Vnormalitzat(2));
    theta=theta-90;
else
    d1=[];
    theta=[];
end

% Es troben els punts per a la dist√†ncia d2 del robot a la l√≠nia vertical i
% per l'angle theta
y1=1;
x1a=find(ImatgeErosionadaH(:,y1)==1,1,'first');
x1b=find(ImatgeErosionadaH(:,y1)==1,1,'last');
while (isempty(x1a) && y1<320)
x1a=find(ImatgeErosionadaH(:,y1)==1,1,'first');
x1b=find(ImatgeErosionadaH(:,y1)==1,1,'last');
    y1=y1+5;
end
x1=round(0.5*(x1a+x1b));
y2=320;
x2a=find(ImatgeErosionadaH(:,y2)==1,1,'first');
x2b=find(ImatgeErosionadaH(:,y2)==1,1,'last');
while (isempty(x2a) && y2>0)
    
   x2a=find(ImatgeErosionadaH(:,y2)==1,1,'first');
x2b=find(ImatgeErosionadaH(:,y2)==1,1,'last');
y2=y2-5;
end
x2=round(0.5*(x2a+x2b));
% Ara es realitza el producte vectorial 
if ( ~isempty(x1) && ~isempty(x2) )
    p1imatge=[y1,x1]';
    p2imatge=[y2,x2]';
    [ p1robot ] = pixel2point( p1imatge , Rc_ext, Tc_ext, [-62.7 477.9 0]', KK );
    [ p2robot ] = pixel2point( p2imatge , Rc_ext, Tc_ext, [-62.7 477.9 0]', KK );
    H=cross([p1robot(1:2);1],[p2robot(1:2);1]);
    Hnormalitzat=H./sqrt(H(1)^2+H(2)^2);
    d2=-Hnormalitzat(3);
else
    d2=[];
end
% % % % % % % 
% % % % % % % close all
% % % % % % % subplot(2,3,1)
% % % % % % % imshow(ImatgeRGB);
% % % % % % % xlabel('Imatge original')
% % % % % % % subplot(2,3,2)
% % % % % % % imshow(ImatgeYCbCr(:,:,3));
% % % % % % % xlabel('Imatge croma, capa 3')
% % % % % % % subplot(2,3,3)
% % % % % % % imshow(ImatgeBN);
% % % % % % % xlabel('Imatge binaritzada')
% % % % % % % subplot(2,3,4)
% % % % % % % imshow(ImatgeErosionadaV);
% % % % % % % xlabel('Imatge erosionada vertical')
% % % % % % % subplot(2,3,5)
% % % % % % % imshow(ImatgeErosionadaH);
% % % % % % % xlabel('Imatge erosionada horitzontal')

% disp('La dist‡ncia a la lÌnia vertical d1 Ès....')
% disp(d1)
% disp('La dist‡ncia a la lÌnia horitzontal d2 Ès....')
% disp(d2)
% disp('L''angle en relaciÛ a la vertical Ès....')
% disp(theta)

