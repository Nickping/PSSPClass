function angles = AnglesToTurn(ListOfWp)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
angles = [];
dummyAngles = [];
setOfCoordinates = NodesToCoordinates(ListOfWp);
previousAngles = 90;
finalAngles = [];
disp('AnglesToTurn');
xPos = [];
yPos = [];
xIncreament = [];
yIncreament = [];
sizeOfArr = size(ListOfWp);
numberOfNodeForPath = sizeOfArr(1,1);

for i=1:numberOfNodeForPath
%     
xPos = [xPos,setOfCoordinates(i,1)];
yPos = [yPos,setOfCoordinates(i,2)];

end

for i=1:(numberOfNodeForPath-1)
    xIncreament = [xIncreament,xPos(i+1)-xPos(i)];
    yIncreament = [yIncreament,yPos(i+1)-yPos(i)];
    
end

dummyAngles = atan2d(yIncreament,xIncreament);
sizeOfArr = size(dummyAngles); %(1,5) 
numberOfNodeForPath = sizeOfArr(1,2);

finalAngles = [finalAngles,previousAngles];
finalAngles = [finalAngles,dummyAngles];
for i=2:numberOfNodeForPath+1
    dif = finalAngles(i)-finalAngles(i-1);
    angles = [angles,dif];
end

disp(angles);

end

