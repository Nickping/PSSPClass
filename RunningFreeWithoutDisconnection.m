function [ EndNode,EndAngle ] = RunningFreeWithoutDisconnection( Origin,Destination,InitialAngle,MotorId0,MotorId1,MotorId2,CameraId,OdometryId,Rc_ext,Tc_ext,KK )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 EndNode=Destination;
[ Xcoordinates,Ycoordinates] = WaypointsToCoordinates( [Origin,Destination] );


DeltaY=Ycoordinates(2)-Ycoordinates(1);
DeltaX=Xcoordinates(2)-Xcoordinates(1);
EndAngle=atan2d(DeltaY,DeltaX);
        AnglesToTurn=EndAngle-InitialAngle;
        if (AnglesToTurn)==270
            AnglesToTurn=-90;
        elseif (AnglesToTurn)==-270
            AnglesToTurn=90;
        end
T=[[-0.500000000000000,-0.866000000000000,0.150000000000000;1,0,0.150000000000000;-0.500000000000000,0.866000000000000,0.150000000000000;]];
[success]=Turn(AnglesToTurn,OdometryId,MotorId0,MotorId1,MotorId2)
[d1,d2,theta]=WhereAmI(CameraId,Rc_ext, Tc_ext, KK )
if (~isempty(d1) && evalin('base','ExitFlag')==0) 
    while isempty(d2)
        [Step] = StateForward(d1,theta,T);
        PublishMotors(Step,MotorId0,MotorId1,MotorId2);
        [d1,d2,theta]=WhereAmI(CameraId,Rc_ext, Tc_ext, KK );
    end
        d2ini = d2;
        Odometry_set( OdometryId, 0, 0, 0 );
        [ y, x, TurnedAngle ] = Odometry_get( OdometryId );
        while (y~=0 && evalin('base','ExitFlag')==0)
            Odometry_set( OdometryId, 0, 0, 0 );
            [ y, x, TurnedAngle ] = Odometry_get( OdometryId );
        end
    while (d2ini>=y && evalin('base','ExitFlag')==0)
        [Step] = StateForward(d1,theta,T);
        PublishMotors(Step,MotorId0,MotorId1,MotorId2);
        [ y, x, TurnedAngle ] = Odometry_get( OdometryId );
        [d1,d2,theta]=WhereAmI(CameraId,Rc_ext, Tc_ext, KK );
    end
          PublishMotors([0 0 0]',MotorId0,MotorId1,MotorId2);
end
          PublishMotors([0 0 0]',MotorId0,MotorId1,MotorId2);
assignin('base','EndAngle',EndAngle)
% % % initial picture
