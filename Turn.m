function [success]=Turn(AngleToTurn,OdometryId,MotorId0,MotorId1,MotorId2)
% Use: [success]=Turn(AngleToTurn,ComId,OdometryId,MotorId0,MotorId1,MotorId2)
% To turn a specific angle 
    vt=600; 
    Odometry_set( OdometryId, 0, 0, 0 );
    [ y, x, TurnedAngle ]=Odometry_get( OdometryId);
    %     disp(TurnedAngle)

    while TurnedAngle~=0
    %     Odometry_set( OdometryId, 0, 0, 0 );% dos cops. no s� per qu�
    Odometry_set( OdometryId, 0, 0, 0 );
        [ y, x, TurnedAngle ]=Odometry_get( OdometryId);
    %     clc
    %     disp(TurnedAngle)
    %     pause(.5)
    end
    
     MultipleOf90deg=abs(AngleToTurn/90);
    for i=1:MultipleOf90deg
        while sign(AngleToTurn)*(TurnedAngle)<sign(AngleToTurn)*(AngleToTurn/MultipleOf90deg) 
            Motor_setSetPointSpeed( MotorId0, sign(AngleToTurn)*vt);
            Motor_setSetPointSpeed( MotorId1, sign(AngleToTurn)*vt);
            Motor_setSetPointSpeed( MotorId2, sign(AngleToTurn)*vt);
            [ y, x, TurnedAngle ] = Odometry_get( OdometryId );
        end
        Motor_setSetPointSpeed( MotorId0, 0 );
            Motor_setSetPointSpeed( MotorId1, 0 );
            Motor_setSetPointSpeed( MotorId2, 0);
            pause(.1)
        Odometry_set( OdometryId, 0, 0, 0 );
        [ y, x, TurnedAngle ] = Odometry_get( OdometryId );
       while TurnedAngle~=0
           [ y, x, TurnedAngle ] = Odometry_get( OdometryId );
       end
    end
    success=1;