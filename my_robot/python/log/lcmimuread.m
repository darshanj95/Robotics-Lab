% add the lcm.jar file to the matlabpath - need to only do this once
javaaddpath '/home/darshan/lcm-1.3.1/examples/lcm-spy/my_types.jar'
javaaddpath /usr/local/share/java/lcm.jar


% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading

log_file = lcm.logging.Log('/home/darshan/my_robot/lcmtypes/logfar.00', 'r'); 

% now read the file 
% here we are assuming that the channel we are interested in is RDI. Your channel 
% name will be different - something to do with GPS
% also RDI has fields altitude and ranges - GPS will probably have lat, lon, utmx,
% utmy etc
x=1;
while true
 try
   ev = log_file.readNext();
   
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   if strcmp(ev.channel, 'IMU')
      disp("HELLO")
     % build rdi object from data in this record
      rdi = exlcm.imu_t(ev.data);
      
      % now you can do things like depending upon the rdi_t struct that was defined
      yaw(x) = rdi.yaw;
      roll(x)=rdi.roll;
      pitch(x)= rdi.pitch;
      accx(x)= rdi.AccelX;
      accy(x)= rdi.AccelY;
      accz(x)= rdi.AccelZ;
      magx(x)= rdi.MagX;
      magy(x)= rdi.MagY;
      magz(x)= rdi.MagZ;
      gyrx(x)= rdi.GyroX;
      gyry(x)= rdi.GyroY;
      gyrz(x)= rdi.GyroZ;

      %rng = rdi.ranges;
      %timestamp = rdi.utime;  % (timestamp in microseconds since the epoch)
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 end
  x=x+1;
end
y=2;
x1=1062
      if y==1
          statement="Data when IMU is close";
          x1=1089;
      else
          statement="Data when IMU is far";
      end    
      figure(1)
      scatter(1:x1,yaw)
      title(statement)
      ylabel("Yaw Data (In degrees)")
      xlabel("Number of events")
      figure(2)
      scatter(1:x1,roll)
      title(statement)
      ylabel("Roll Data (In degrees)")
      xlabel("Number of events")
      figure(3)
      scatter(1:x1,pitch)
      title(statement)
      ylabel("Pitch Data (In degrees)")
      xlabel("Number of events")
      figure(4)
      scatter(1:x1,accx)
      title(statement)
      ylabel("Acceleration_X Data (In m/s^2)")
      xlabel("Number of events")
      figure(5)
      scatter(1:x1,accy)
      title(statement)
      ylabel("Acceleration_Y Data (In m/s^2)")
      xlabel("Number of events")
      figure(6)
      scatter(1:x1,accz)
      title(statement)
      ylabel("Acceleration_Z Data (In m/s^2)")
      xlabel("Number of events")
      figure(7)
      scatter(1:x1,gyrx)
      title(statement)
      ylabel("Gyroscope_X Data (In rad/s)")
      xlabel("Number of events")
      figure(8)
      scatter(1:x1,gyry)
      title(statement)
      ylabel("Gyroscope_Y Data (In rad/s)")
      xlabel("Number of events")
      figure(9)
      scatter(1:x1,gyrz)
      title(statement)
      ylabel("Gyroscope_Z Data (In rad/s)")
      xlabel("Number of events")
      figure(10)
      scatter(1:x1,magx)
      title(statement)
      ylabel("Magnetometer_X Data (In gauss)")
      xlabel("Number of events")
      figure(11)
      scatter(1:x1,magy)
      title(statement)
      ylabel("Magnetometer_Y Data (In gauss)")
      xlabel("Number of events")
      figure(12)
      scatter(1:x1,magz)
      title(statement)
      ylabel("Magnetometer_Z Data (In gauss)")
      xlabel("Number of events")
      
      
