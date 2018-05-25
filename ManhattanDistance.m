%--------------------------------------------------------------------------
%Computes the heuristic Manhattan distance of each node given an distance 
%matrix and the target.
%The i-th element in the returned array is the Manhattan distance of the
%i-th node.
%
%   Heuristics = ManhattanDistance(DM, 5) -> returns the heuristic array
%   of the given distance matrix and the target node (5).
%
%--------------------------------------------------------------------------
%By Josep Àngel Oltra Oltra (05/2018)
function [ Heuristics ] = ManhattanDistance( DistanceMatrix, Target )
    if size(DistanceMatrix, 1) ~= size(DistanceMatrix, 2)
       error('Error. The distance matrix has to be a square matrix.');
    end
    n = size(DistanceMatrix, 1);
    if 0 >= Target || Target > n
       error('Error. The target has to be a valid node given the distance matrix.');
    end
   
    Heuristics = zeros(n, 1);
    Nodes = zeros(n, 1);
    for i = 2:n
        DistanceMatrix(Target, Target) = inf;
        indexes = sum(DistanceMatrix(:, Target) ~= inf, 2);
        indexes = find(indexes);
        Heuristics(indexes) = 1 + Heuristics(Target(1));
        DistanceMatrix(:, Target) = inf;
        DistanceMatrix(Target, :) = inf;
        Nodes(Target) = 1;
        if isempty(indexes)
            break;
        else
            Target = indexes;
        end
    end
end
