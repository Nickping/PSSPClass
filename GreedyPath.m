function pathArr = GreedyPath(distanceMatrix,origin,target)
disp('Greedy Algorithm is working');
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% 
% distanceMatrix = [0,8,3,5,Inf;
%                   8,0,2,Inf,5;
%                   Inf,1,0,3,5;
%                   6,Inf,Inf,0,7;
%                   Inf,5,Inf,Inf,0];
% %             
% origin = 1;
% target = 5;
pathArr = [];
pathArr = [pathArr,origin];

sizeOfMatrix = size(distanceMatrix);
colCount = sizeOfMatrix(1,1);
currentNode = origin;
nextNode = 0;
min = 0;
while 1
    %1�࿡�� �ּҸ� ã��, �״��� �࿡�� �ּ�...target ��ܵǸ� ��
    min = Inf;
    if currentNode == target
        break;
    end
    
    for i=1:colCount
        distanceMatrix(i,currentNode) = Inf;
        
    end
    for i=1:colCount
       if min>distanceMatrix(currentNode,i)
           min = distanceMatrix(currentNode,i);
           nextNode = i;
           
       end
    end
    currentNode = nextNode;
    pathArr = [pathArr,nextNode];
end
disp(pathArr);
disp('greedy algorithm end');

              
          

end

