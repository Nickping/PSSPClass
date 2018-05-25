function [ObsDetected,Readings] = SharpDetection(DistanceSensor0Id,DistanceSensor1Id,DistanceSensor2Id,DistanceSensor3Id,DistanceSensor4Id,DistanceSensor5Id,DistanceSensor6Id,DistanceSensor7Id,DistanceSensor8Id)
ObsDetected = false;
value0 = DistanceSensor_voltage(DistanceSensor0Id);
value1 = DistanceSensor_voltage(DistanceSensor1Id);
value2 = DistanceSensor_voltage(DistanceSensor2Id);
value3 = DistanceSensor_voltage(DistanceSensor3Id);
value4 = DistanceSensor_voltage(DistanceSensor4Id);
value5 = DistanceSensor_voltage(DistanceSensor5Id);
value6 = DistanceSensor_voltage(DistanceSensor6Id);
value7 = DistanceSensor_voltage(DistanceSensor7Id);
value8 = DistanceSensor_voltage(DistanceSensor8Id);
vector = [value0,value1,value2,value3,value4,value5,value6,value7,value8];
Readings = 126.1./vector;

if min(Readings)<300
    ObsDetected = true
end


end

