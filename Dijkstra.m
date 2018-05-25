%--------------------------------------------------------------------------
%Computes the optimum path and path cost given a distance matrix via the 
%Dijkstra's algorithm, or -1 if the path is not found.
%
%   Path = Dijkstra(DM, 1, 5) -> returns the path from node 1 to node 5.
%
%   [Path, PathCost] = Dijkstra(DM, 1, 5) -> returns the path from node 
%                      1 to node 5, and the total path cost.
%--------------------------------------------------------------------------
%By Josep Àngel Oltra Oltra (05/2018)
function [ Path, PathCost ] = Dijkstra( DistanceMatrix , Origin, Target )
    if size(DistanceMatrix, 1) ~= size(DistanceMatrix, 2)
       error('Error. The distance matrix has to be a square matrix.');
    end
    n = size(DistanceMatrix, 1);
    if 0 >= Target || Target > n
       error('Error. The target has to be a valid node given the distance matrix.');
    end
    if 0 >= Origin || Origin > n
       error('Error. The origin has to be a valid node given the distance matrix.');
    end

    Nodes = struct('cost', inf*ones(n, 1), 'parent', zeros(n, 1), ...
        'done', zeros(n, 1));
    
    Nodes.cost(Origin) = 0;
    Nodes.parent(Origin) = 0;
    
    for i = 1:n 
        indexes = find(Nodes.cost < inf & Nodes.done == 0);
        [cost, ActualNode] = min(Nodes.cost(indexes));
        ActualNode = indexes(ActualNode);
        
        if ActualNode == Target
            Nodes.done(ActualNode) = 1;
            break;
        end
        
        indexes = find(DistanceMatrix(:, ActualNode) ~= inf);
        m = size(indexes, 1);
        for j = 1:m
            index  = indexes(j);
            if index == ActualNode
                continue;
            end
            if Nodes.cost(index) > cost + DistanceMatrix(index, ActualNode)
                Nodes.cost(index) = cost + ...
                    DistanceMatrix(index, ActualNode);
                Nodes.parent(index) = ActualNode;
            end
        end
        Nodes.done(ActualNode) = 1;
    end
    
    if Nodes.done(Target) ~= 1
        Path = -1;
        PathCost = -1;
        return;
    end
    
    pathLength = size(unique(Nodes.parent(Nodes.done == 1)), 1);
    j = 0;
    Path = zeros(pathLength, 1);
    Path(1) = Target;
    for i = 2:pathLength
        Path(i) = Nodes.parent(Path(i - 1));
        if Path(i) == 0
            j = i - 1;
            break;
        end
        j = i;
    end
    if j == 0
        j = 1;
    end
    Path = flip(Path(1:j));
    PathCost = Nodes.cost(Target);
end

