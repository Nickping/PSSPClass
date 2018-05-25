function PublishMotors(Step,MotorId0,MotorId1,MotorId2)

Motor_setSetPointSpeed( MotorId0, Step(1,1));
Motor_setSetPointSpeed( MotorId1, Step(2,1));
Motor_setSetPointSpeed( MotorId2, Step(3,1));

end

