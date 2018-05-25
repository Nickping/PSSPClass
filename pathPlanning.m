function ListOfWp = pathPlanning(distanceMatrix,heuristic,origin,target,method)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
ListOfWp = [];
dummy = [];

switch method
    case 0
        ListOfWp = GreedyPath(distanceMatrix,origin,target);
    case 1
        dummy = Dijkstra(distanceMatrix,origin,target);
        ListOfWp = dummy(1,1);
    case 2
        dummy = 
    otherwise
end


end

