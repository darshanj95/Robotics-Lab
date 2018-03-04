% add the lcm.jar file to the matlabpath - need to only do this once
clear all
clear java
javaaddpath '/home/darshan/my_robot/python/GPS_struct_type.jar'
javaaddpath '/home/darshan/my_robot/python/IMU_struct_type.jar'
javaaddpath /usr/local/share/java/lcm.jar


% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading

log_file = lcm.logging.Log('/home/darshan/my_robot/python/log/lcm-log-run1', 'r'); 

% now read the file 
% here we are assuming that the channel we are interested in is RDI. Your channel 
% name will be different - something to do with GPS
% also RDI has fields altitude and ranges - GPS will probably have lat, lon, utmx,
% utmy etc


while true
 try
   ev = log_file.readNext();
   disp(ev.channel)
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   if strcmp(ev.channel, 'GPS')
     % build rdi object from data in this record
      gps = gps_lcm.gps_t(ev.data);
      % now you can do things like depending upon the rdi_t struct that was
      % defined
      utmx= gps.utm_x;
      utmy=gps.utm_y;
      scatter(utmx,utmy)
      hold on
      %rng = rdi.ranges;
      %timestamp = rdi.utime;  % (timestamp in microseconds since the epoch)
   end
    
    if strcmp(ev.channel, 'IMU')
      disp("HELLO")
     % build rdi object from data in this record
      imu = imu_lcm.imu_t(ev.data);
      disp("Hey")
      % now you can do things like depending upon the rdi_t struct that was
      % define d
      
      yaw(x) = imu.yaw;
      roll(x)=imu.roll;
      pitch(x)= imu.pitch;
      accx(x)= imu.AccelX;
      accy(x)= imu.AccelY;
      accz(x)= imu.AccelZ;
      magx(x)= imu.MagX;
      magy(x)= imu.MagY;
      magz(x)= imu.MagZ;
      gyrx(x)= imu.GyroX;
      gyry(x)= imu.GyroY;
      gyrz(x)= imu.GyroZ;

      %rng = rdi.ranges;
      %timestamp = rdi.utime;  % (timestamp in microseconds since the epoch)
    end
  catch err   % exception will be thrown when you hit end of file
     break;
 
 end
 
end


%       if y==1
%           statement="Data when IMU is close";
%           x1=1089;
%       else
%           statement="Data when IMU is far";
%       end    
%       figure(1)
%       scatter(1:x1,yaw)
%       title(statement)
%       ylabel("Yaw Data (In degrees)")
%       xlabel("Number of events")
%       figure(2)
%       scatter(1:x1,roll)
%       title(statement)
%       ylabel("Roll Data (In degrees)")
%       xlabel("Number of events")
%       figure(3)
%       scatter(1:x1,pitch)
%       title(statement)
%       ylabel("Pitch Data (In degrees)")
%       xlabel("Number of events")
%       figure(4)
%       scatter(1:x1,accx)
%       title(statement)
%       ylabel("Acceleration_X Data (In m/s^2)")
%       xlabel("Number of events")
%       figure(5)
%       scatter(1:x1,accy)
%       title(statement)
%       ylabel("Acceleration_Y Data (In m/s^2)")
%       xlabel("Number of events")
%       figure(6)
%       scatter(1:x1,accz)
%       title(statement)
%       ylabel("Acceleration_Z Data (In m/s^2)")
%       xlabel("Number of events")
%       figure(7)
%       scatter(1:x1,gyrx)
%       title(statement)
%       ylabel("Gyroscope_X Data (In rad/s)")
%       xlabel("Number of events")
%       figure(8)
%       scatter(1:x1,gyry)
%       title(statement)
%       ylabel("Gyroscope_Y Data (In rad/s)")
%       xlabel("Number of events")
%       figure(9)
%       scatter(1:x1,gyrz)
%       title(statement)
%       ylabel("Gyroscope_Z Data (In rad/s)")
%       xlabel("Number of events")
%       figure(10)
%       scatter(1:x1,magx)
%       title(statement)
%       ylabel("Magnetometer_X Data (In gauss)")
%       xlabel("Number of events")
%       figure(11)
%       scatter(1:x1,magy)
%       title(statement)
%       ylabel("Magnetometer_Y Data (In gauss)")
%       xlabel("Number of events")
%       figure(12)
%       scatter(1:x1,magz)
%       title(statement)
%       ylabel("Magnetometer_Z Data (In gauss)")
%       xlabel("Number of events")
