function [ AnglesToTurn ] = Angles( ListOfWaypoints ,InitialAngle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ThetaPrev=InitialAngle;
    [ Xcoordinates,Ycoordinates] = WaypointsToCoordinates( ListOfWaypoints );
    AnglesToTurn=zeros(1,length(ListOfWaypoints)-1);
    for i=1:length(ListOfWaypoints)-1
        Dx=Xcoordinates(i+1)-Xcoordinates(i);
        Dy=Ycoordinates(i+1)-Ycoordinates(i);
        Theta=atan2(Dy,Dx)*180/pi;
        AnglesToTurn(i)=Theta-ThetaPrev;
        if (AnglesToTurn(i))==270
            AnglesToTurn(i)=-90;
        elseif (AnglesToTurn(i))==-270
            AnglesToTurn(i)=90;
        end
        ThetaPrev=Theta;
    end

end

