figure;
hold on;

gridSource1 = [0 0;
              1 0;
              2 0;
              3 0; 
             ];
gridSource2 = [
              0 1;
              1 1;
              2 1;
              3 1;
             ];
gridSource3 = [
              0 2;
              1 2;
              2 2;
              3 2;
             ];
gridSource4 = [
              0 3;
              1 3;
              2 3;
              3 3;];
gridSource5 = [
              1 0;
              1 1;
              1 2;
              1 3;];
gridSource6 = [
              2 0;
              2 1;
              2 2;
              2 3;];
gridSource7 = [
               3 0;
               3 1;
               3 2;
               3 3;]
gridSource8 = [
               0 0;
               0 1;
               0 2;
               0 3;]
           
%handels.Name,....

%hold on- >CreateFcn 
for i=1:size(gridSource1,1)-1

    plot(gridSource1(i:i+1,1),gridSource1(i:i+1,2),'-r');

end
for i=1:size(gridSource2,1)-1
    plot(gridSource2(i:i+1,1),gridSource2(i:i+1,2),'-r');
end

for i=1:size(gridSource3,1)-1
    plot(gridSource3(i:i+1,1),gridSource3(i:i+1,2),'-r');
end
for i=1:size(gridSource4,1)-1
    plot(gridSource4(i:i+1,1),gridSource4(i:i+1,2),'-r');
end
for i=1:size(gridSource5,1)-1
    plot(gridSource5(i:i+1,1),gridSource5(i:i+1,2),'-r');
end
for i=1:size(gridSource6,1)-1
    plot(gridSource6(i:i+1,1),gridSource6(i:i+1,2),'-r');
end
for i=1:size(gridSource7,1)-1
    plot(gridSource7(i:i+1,1),gridSource7(i:i+1,2),'-r');
end
for i=1:size(gridSource8,1)-1
    plot(gridSource8(i:i+1,1),gridSource8(i:i+1,2),'-r');
end


for i=1:size(Coordinates,1)-1
   
    plot(Coordinates(i:i+1,1),Coordinates(i:i+1,2),'-g','LineWidth',3);
    
    
end