function [ Xcoordinates,Ycoordinates] = WaypointsToCoordinates( ListOfWaypoints )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Xcoordinates=zeros(1,length(ListOfWaypoints));
Ycoordinates=zeros(1,length(ListOfWaypoints));
for i=1:length(ListOfWaypoints)
    Ycoordinates(i)=floor((ListOfWaypoints(i)-1)/4);
    Xcoordinates(i)=mod((ListOfWaypoints(i)-1),4);
end