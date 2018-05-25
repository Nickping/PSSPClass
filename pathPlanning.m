function ListOfWp = pathPlanning(distanceMatrix,heuristic,origin,target,method)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
ListOfWp = [];

switch method
    case 0
        ListOfWp = GreedyPath(distanceMatrix,origin,target);
    case 1
    case 2
    otherwise
end


end

