function ListOfWp = pathPlanning(distanceMatrix,heuristic,origin,target,method)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
ListOfWp = [];
dummy = [];

switch method
    case 0  
        ListOfWp = GreedyPath(distanceMatrix,origin,target);
    case 1  
        disp('find the path with Astar');
        ListOfWp = Astar(distanceMatrix,origin,target);
    case 2  
        disp('find the path with Dijkstra');
        ListOfWp = Dijkstra(distanceMatrix,origin,target);
       
    otherwise
end


end

