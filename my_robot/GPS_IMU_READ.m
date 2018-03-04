%This matlab file analyzes the GPS & IMU Data
time= IMU_data_run(:,1);
Yaw=IMU_data_run(:,2);
Pitch=IMU_data_run(:,3);
Roll=IMU_data_run(:,4);
mag_x=IMU_data_run(:,5);
mag_y=IMU_data_run(:,6);
mag_z=IMU_data_run(:,7);
acc_x=IMU_data_run(:,8);
acc_y=IMU_data_run(:,9);
acc_z=IMU_data_run(:,10);
gyro_x=IMU_data_run(:,11);
gyro_y=IMU_data_run(:,12);
gyro_z=IMU_data_run(:,13);
utm_x= GPS_data_run(:,2);
utm_y= GPS_data_run(:,3);

%Checking Hard iron and soft iron corrections
%https://www.sensorsmag.com/components/compensating-for-tilt-hard-iron-and-soft-iron-effects

%Starting with Hard Iron Correction
figure();
plot(mag_x,mag_y);
title('Raw Magnetometer Plot');
alpha= (max(mag_x)+min(mag_x))/2;
beta=  (max(mag_y)+min(mag_y))/2;
gamma= (max(mag_z)+min(mag_z))/2;
hard_x= mag_x-alpha;
hard_y= mag_y-beta;
hard_z= mag_z-gamma;
figure();
plot(hard_x,hard_y)
title('Hard Iron Corrected Plot')

%Starting with Soft Iron Correction
dist_vect=sqrt(hard_x.^2 + hard_y.^2);
MagVector=[ hard_x,hard_y]; 
MagVector=MagVector';
theta=asind(max(hard_y)/max(dist_vect));
RotMatrix=[cosd(theta),sind(theta); -sind(theta), cosd(theta)];
CorrectVector= RotMatrix*MagVector;
a=max(dist_vect);
b=min(dist_vect);
sigma=b/a;
CorrectMagx=CorrectVector(1,:)/sigma;
CorrectMagy=CorrectVector(2,:);
figure();
plot(CorrectMagx,CorrectMagy)
title('Corrected Magnetometer Plot')



mag_angle_raw=atan2(mag_y,mag_x);
figure();
plot(time,mag_angle_raw)
title('Raw Magnetometer Yaw')
mag_angle_correct=atan2(CorrectMagy,CorrectMagx);
mag_angle_correct1=mag_angle_correct';
figure();
plot(time,mag_angle_correct1)
title('Corrected Magnetometer Yaw')
gyro_angle=cumtrapz(gyro_z);
gyro_angle=wrapToPi(gyro_angle);
figure();
plot(time,gyro_angle);
title('Gyroscope Yaw')
samplePeriod = 256;
filtCutOff = 0.001;
[b, a] = butter(1, (2*filtCutOff)/(1/samplePeriod), 'high');
gyro_z_Filt = filtfilt(b, a, gyro_z);
figure();
plot(time,gyro_z_Filt);
title('Butter Filter Gyroscope Yaw')
Combine_angle=0.98.*gyro_z_Filt+ 0.02.*mag_angle_correct1;
figure();
plot(time,Combine_angle)
title('Complementary filter(Gyroscope + Magnetometer)')


%Butterworth Filter for acceleration data

figure();
plot(acc_x)
title('Raw acc_x')
figure();
plot(acc_y)
title('Raw acc_y')

samplePeriod = 256;
 filtCutOff = 0.001;
 [b, a] = butter(1, (2*filtCutOff)/(1/samplePeriod), 'high');
 acc_x = filtfilt(b, a, acc_x);
 [b, a] = butter(1, (2*filtCutOff)/(1/samplePeriod), 'high');
 acc_y = filtfilt(b, a, acc_y);

acc_mean_x1=acc_x-mean(acc_x);
acc_mean_y1=acc_y-mean(acc_y);


figure();
plot(acc_mean_x1);
title('Butter filter acc_x');
figure();
plot(acc_mean_y1);
title('Butter filter acc_y');
vel_x=cumtrapz(acc_mean_x1);
vel_mean_x = mean(vel_x);
vel_x1 = vel_x-vel_mean_x;
pos_x=cumtrapz(vel_x);
pos_mean_x = mean(pos_x);
pos_x1 = pos_x-pos_mean_x;

vel_y=cumtrapz(acc_mean_y1);
vel_mean_y = mean(vel_x);
vel_y1 = vel_x-vel_mean_y;
pos_x=cumtrapz(vel_y);
pos_mean_y = mean(pos_y);
pos_y1 = pos_y-pos_mean_y;

ydd=acc_y;
w=gyro_z;
xd=vel_x1;

figure();
plot(utm_x,utm_y)
xlabel('UTM_x (m)')
ylabel('UTM_y (m)')
hold on;
plot(utm_x(1),utm_y(1),'x')
hold off
title('UTM_x vs UTM_y')