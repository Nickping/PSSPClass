function  setOfCoordinates = NodesToCoordinates(ListOfWp)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
setOfCoordinates =[];
dummySet = [];


sizeOfArr = size(ListOfWp);
numberOfNodeForPath = sizeOfArr(1,1);
disp('numberOfNodeForPath==')
disp(numberOfNodeForPath);
sizeOfCol = 4;%distanceMatrix Size
disp('nodesToCoordinate');
disp(ListOfWp);
for i=1:numberOfNodeForPath
    disp(ListOfWp(i,1));
    index = (ListOfWp(i,1)-1);
    if index == 0
        xCoordinate = 0;
        yCoordinate = 0;
    else
        xCoordinate = mod(index,sizeOfCol);
        yCoordinate = fix(index/sizeOfCol);
        
    end
%     disp(ListOfWp(1,i));
%     disp('x : ');
%     disp(xCoordinate);
%     disp('y : ');
%     disp(yCoordinate);
    dummySet = [xCoordinate,yCoordinate];
    setOfCoordinates = [setOfCoordinates;dummySet];
end
disp(setOfCoordinates);

end



